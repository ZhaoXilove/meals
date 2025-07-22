import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

// CategoryGridItem是用于显示分类的网格项
class CategoryGridItem extends StatelessWidget {
  // 构造函数
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelect,
  });

  // 分类
  final Category category;

  // 选择分类
  final void Function() onSelect;
  // 构建方法
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        // EdgeInsets表示内边距，表示容器内边距为16
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          gradient: LinearGradient(
            colors: [
              category.color.withValues(alpha: 0.55),
              category.color.withValues(alpha: 0.9),
            ],
            // 渐变方向 Alignment.topLeft 左上角，Alignment.bottomRight 右下角
            begin: Alignment.topLeft,
            // 渐变结束位置 Alignment.bottomRight 右下角，Alignment.topLeft 左上角
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
