// 状态管理 提供者
// 导入 Riverpod 库
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 导入 Meal 类型
import 'package:meals/models/meal.dart';

// 定义 FavoriteMealsNotifier 类
/// 参数 `List<Meal>` 食物列表
/// 返回值 无
/// 描述 管理食物收藏状态的通知器
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  // 构造函数
  FavoriteMealsNotifier() : super([]);

  /// 切换食物的收藏状态
  /// 参数 `Meal` 食物
  /// 返回值 无
  /// 描述 切换食物的收藏状态，如果食物已经收藏，则从收藏列表中移除，如果未收藏，则添加到收藏列表
  bool toggleMealFavoriteStatus(Meal meal) {
    // 判断食物是否已经收藏 使用 contains 方法判断是否包含
    // 在flutter_riverpod不能直接去改变值，需要使用 state = 来改变值
    // mealIsFavorite 食物是否已经收藏
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      // 如果已经收藏，则从收藏列表中移除
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // 如果未收藏，则添加到收藏列表
      state = [...state, meal];
      return true;
    }
  }
}

// 定义 favoriteMealsProvider 提供者
// 使用 StateNotifierProvider 来管理状态 ， 第一个参数是 提供者的类型，第二个参数是 提供者的构造函数
final favoriteMealsProvider =
    // 使用 StateNotifierProvider 来管理状态 ， 第一个参数是 提供者的类型，第二个参数是 提供者的构造函数
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
      (ref) => FavoriteMealsNotifier(),
    );
