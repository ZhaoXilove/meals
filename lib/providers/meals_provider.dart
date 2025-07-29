// 状态管理 提供者
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 导入 静态数据
import 'package:meals/data/dummy_data.dart';
// 导入 Meals 类型
import 'package:meals/models/meal.dart';

// 定义 mealsProvider 提供者
final mealsProvider = Provider<List<Meal>>((ref) {
  return dummyMeals;
});
