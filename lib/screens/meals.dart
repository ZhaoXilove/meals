import 'package:flutter/material.dart';

import 'package:meals/models/meal.dart'; // 导入食物模型
import 'package:meals/screens/meal_details.dart'; // 导入食物详情页面
import 'package:meals/widgets/meal_item.dart'; // 导入食物项组件

// MealsScreen是一个无状态组件，用于显示食物列表
class MealsScreen extends StatelessWidget {
  // 构造函数，接收必要的参数
  const MealsScreen({
    super.key,
    this.title, // 页面标题，可选参数
    required this.meals, // 要显示的食物列表
    // 切换收藏状态的回调函数
    required this.onToggleFavorite,
  });

  // 页面标题，可以为null（当作为标签页的内容时不需要标题）
  final String? title;

  // 要显示的食物列表
  final List<Meal> meals;

  // 切换收藏状态的回调函数
  final void Function(Meal meal) onToggleFavorite;

  // 当选择一个食物项时调用的方法
  void selectMeal(BuildContext context, Meal meal) {
    // 导航到食物详情页面
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal, // 传递选中的食物
          onToggleFavorite: (isFavorite) {
            // 将详情页的收藏回调转发到本页面的回调
            onToggleFavorite(meal);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 创建食物列表视图
    Widget content = ListView.builder(
      itemCount: meals.length, // 列表项数量
      itemBuilder: (ctx, index) =>
          MealItem(meal: meals[index], onSelect: selectMeal), // 创建食物项
    );

    // 如果没有食物，显示提示信息
    if (meals.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // 列高度最小化
          children: [
            Text(
              'No meals found. Start adding some!', // 没有找到食物，开始添加一些吧！
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16), // 间隔
            Text(
              'Try selecting a different category!', // 尝试选择不同的分类！
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    }

    // 如果title为null，直接返回内容（作为标签页的内容）
    if (title == null) {
      return content;
    }

    // 如果有标题，则返回带有标题栏的脚手架
    return Scaffold(
      appBar: AppBar(title: Text(title!)), // 显示页面标题
      body: content, // 显示食物列表
    );
  }
}
