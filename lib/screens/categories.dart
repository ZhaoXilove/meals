import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/widgets/category_grid_item.dart';

// 无状态组件
class CategoriesScreen extends StatelessWidget {
  // 这是主页的分类页面
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick your category')),
      body: GridView(
        padding: const EdgeInsets.all(16),
        // 设置网格的列数
        // SliverGridDelegateWithFixedCrossAxisCount 是用来设置网格的列数
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        // 设置网格的子元素
        children: [
          // CategoryItem(title: 'Italian', color: Colors.red),
          // CategoryItem(title: 'Italian', color: Colors.red),
          // Text('Italian', style: TextStyle(color: Colors.white)),
          // Text('Italian', style: TextStyle(color: Colors.white)),
          for (final category in availableCategories)
            CategoryGridItem(category: category),
        ],
      ),
    );
  }
}
