import 'package:flutter_riverpod/flutter_riverpod.dart';

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
