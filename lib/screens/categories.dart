import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

// 无状态组件
class CategoriesScreen extends StatelessWidget {
  // 这是主页的分类页面
  const CategoriesScreen({super.key});

  // 选择分类
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            MealsScreen(title: category.title, meals: filteredMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('选择你的分类')),
      body: GridView(
        padding: const EdgeInsets.all(16),
        // 设置网格的列数
        // SliverGridDelegateWithFixedCrossAxisCount 是用来设置网格的列数
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          // 设置网格的列数
          crossAxisCount: 2,
          // 设置网格的子元素的宽高比
          childAspectRatio: 3 / 2,
          // 设置网格的子元素的间距
          crossAxisSpacing: 20,
          // 设置网格的子元素的间距
          mainAxisSpacing: 20,
        ),
        // 设置网格的子元素
        children: [
          // CategoryItem(title: 'Italian', color: Colors.red),
          // CategoryItem(title: 'Italian', color: Colors.red),
          // Text('Italian', style: TextStyle(color: Colors.white)),
          // Text('Italian', style: TextStyle(color: Colors.white)),
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelect: () => _selectCategory(context, category),
            ),
        ],
      ),
    );
  }
}
