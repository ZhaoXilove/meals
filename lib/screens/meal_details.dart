import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart'; // 导入食物模型

// MealDetailsScreen是一个无状态组件，用于显示食物的详细信息
class MealDetailsScreen extends StatelessWidget {
  // 构造函数，接收必要的参数
  const MealDetailsScreen({
    super.key,
    required this.meal, // 要显示详情的食物
    required this.onToggleFavorite, // 切换收藏状态的回调函数
  });

  // 要显示详情的食物对象
  final Meal meal;

  // 切换收藏状态的回调函数，参数表示是否收藏
  final void Function(bool isFavorite) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    // 返回一个脚手架，包含标题栏和主体内容
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title), // 标题栏显示食物名称
        actions: [
          // 添加一个收藏按钮
          IconButton(
            onPressed: () {
              // 点击时调用切换收藏状态的回调函数
              onToggleFavorite(meal.id == meal.id);
            },
            icon: const Icon(Icons.star), // 使用星形图标表示收藏
          ),
        ],
      ),
      // 使用SingleChildScrollView使内容可滚动
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 显示食物的图片
            Image.network(
              meal.imageUrl, // 图片URL
              width: double.infinity, // 宽度占满屏幕
              height: 300, // 高度固定为300
              fit: BoxFit.cover, // 图片填充方式为覆盖
            ),
            const SizedBox(height: 14), // 间隔
            // 显示"配料"标题
            Text(
              'Ingredients', // 配料
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14), // 间隔
            // 循环显示所有配料
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            const SizedBox(height: 24), // 间隔
            // 显示"步骤"标题
            Text(
              'Steps', // 步骤
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14), // 间隔
            // 循环显示所有步骤
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12, // 水平内边距
                  vertical: 8, // 垂直内边距
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center, // 文本居中对齐
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
