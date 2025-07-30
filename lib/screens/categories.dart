import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart'; // 导入示例数据
import 'package:meals/models/category.dart'; // 导入分类模型
import 'package:meals/models/meal.dart'; // 导入食物模型
import 'package:meals/screens/meals.dart'; // 导入食物列表页面
import 'package:meals/widgets/category_grid_item.dart'; // 导入分类网格项组件

// CategoriesScreen 是一个无状态组件，用于显示所有食物分类的网格视图
class CategoriesScreen extends StatefulWidget {
  // 构造函数，接收必要的参数
  const CategoriesScreen({
    super.key,
    // required this.onToggleFavorite, // 切换收藏状态的回调函数
    required this.availableMeals, // 可用的食物列表（已应用过滤器后的）
  });

  // 切换收藏状态的回调函数，当用户点击收藏按钮时调用
  // final void Function(Meal meal) onToggleFavorite;

  // 可用的食物列表，这是经过过滤器筛选后的食物
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// 继承 SingleTickerProviderStateMixin 以支持动画，作用是提供一个动画控制器
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // late的变量在初始化之前不能被使用  类型为 AnimationController
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // 初始化动画控制器，使用 vsync 参数 用于提供一个动画控制器
    _animationController = AnimationController(
      vsync: this,
      // milliseconds 毫秒
      duration: const Duration(milliseconds: 300),
      // 设置动画控制器的值为 0 lowerBound 是动画控制器的值的最小值
      lowerBound: 0,
      // 设置动画控制器的值为 1 upperBound 是动画控制器的值的最大值
      upperBound: 1,
    );
    // 设置动画控制器的值为 0
    // 启动动画
    _animationController.forward();
  }

  @override
  // 释放动画控制器，避免内存泄漏
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // 当用户选择一个分类时调用的方法
  void _selectCategory(BuildContext context, Category category) {
    // 筛选出属于所选分类的食物
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // 导航到食物列表页面，显示筛选后的食物
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title, // 设置页面标题为分类名称
          meals: filteredMeals, // 传递筛选后的食物列表
          // onToggleFavorite: onToggleFavorite, // 传递切换收藏状态的回调函数
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 返回一个动画构建器，用于构建动画
    return AnimatedBuilder(
      animation: _animationController,
      // 返回一个网格视图，显示所有食物分类
      child: GridView(
        padding: const EdgeInsets.all(16), // 设置网格的内边距
        // 使用SliverGridDelegateWithFixedCross  A xisCount配置网格布局
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 设置每行显示2个网格项
          childAspectRatio: 3 / 2, // 设置网格项的宽高比为3:2
          crossAxisSpacing: 20, // 设置水平方向的间距
          mainAxisSpacing: 20, // 设置垂直方向的间距
        ),
        // 网格的子元素列表
        children: [
          // 以下是被注释掉的示例代码
          // CategoryItem(title: 'Italian', color: Colors.red),
          // CategoryItem(title: 'Italian', color: Colors.red),
          // Text('Italian', style: TextStyle(color: Colors.white)),
          // Text('Italian', style: TextStyle(color: Colors.white)),

          // 使用for循环为每个可用分类创建一个CategoryGridItem
          for (final category in availableCategories)
            CategoryGridItem(
              category: category, // 传递分类对象
              onSelect: () => _selectCategory(context, category), // 设置选择回调
            ),
        ],
      ),
      builder: (context, child) => Padding(
        padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
        child: child,
      ),
    );
  }
}
