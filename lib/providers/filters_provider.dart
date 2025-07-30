import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/meals_provider.dart';

// 定义过滤器枚举类型，包含四种饮食限制选项
enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

// 定义 FiltersNotifier 类
/// 参数 `Map<String, bool>` 过滤器状态
/// 返回值 无
/// 描述 管理过滤器状态的通知器
class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
    : super({
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegan: false,
        Filter.vegetarian: false,
      });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  // 设置过滤器状态
  void setFilter(Filter filter, bool isActive) {
    // state 是不可变的，所以需要使用 {...state, filter: isActive} 来更新状态
    // 不能使用 state[filter] = isActive 来更新状态
    state = {...state, filter: isActive};
  }
}

/// 定义过滤器提供者
/// 参数 `FiltersNotifier` 过滤器通知器
/// 返回值 `Map<Filter, bool>` 过滤器状态
/// 描述 提供过滤器状态的提供者
final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
      (ref) => FiltersNotifier(),
    );

/// 定义过滤后的食物提供者
/// 参数 `Provider<List<Meal>>` 食物列表
/// 返回值 `List<Meal>` 过滤后的食物列表
/// 描述 提供过滤后的食物列表的提供者
/// 将逻辑从页面上抽取出来，避免在页面上重复写相同的逻辑
final filteredMealsProvider = Provider<List<Meal>>((ref) {
  // 使用 mealsProvider 获取食物列表
  final meals = ref.watch(mealsProvider);
  // 使用 filtersProvider 获取过滤器状态
  final activeFilters = ref.watch(filtersProvider);
  // 使用 meals.where 方法过滤食物列表
  return meals.where((meal) {
    // 如果无麸质过滤器开启且食物含麸质，则排除
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    // 如果无乳糖过滤器开启且食物含乳糖，则排除
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    // 如果素食过滤器开启且食物不是素食，则排除
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    // 如果纯素食过滤器开启且食物不是纯素食，则排除
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    // 通过所有过滤器检查，保留该食物
    return true;
  }).toList();
});
