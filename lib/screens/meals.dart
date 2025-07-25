import 'package:flutter/material.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    // 切换收藏状态
    required this.onToggleFavorite,
  });

  // 属性
  final String? title;

  // 食物列表
  final List<Meal> meals;

  // 切换收藏状态
  final void Function(Meal meal) onToggleFavorite;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          onToggleFavorite: (isFavorite) {
            onToggleFavorite(meal);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 食物列表
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) =>
          MealItem(meal: meals[index], onSelect: selectMeal),
    );

    // 如果 没有 食物
    if (meals.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No meals found. Start adding some!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }

    // 如果 有 食物
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}
