import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 导入 Riverpod 库

import 'package:meals/models/meal.dart'; // 导入食物模型
import 'package:meals/screens/categories.dart'; // 导入分类页面
import 'package:meals/screens/filters.dart'; // 导入过滤器页面
import 'package:meals/screens/meals.dart'; // 导入食物列表页面
import 'package:meals/widgets/main_drawer.dart'; // 导入主抽屉菜单组件
import 'package:meals/providers/meals_provider.dart'; // 导入 mealsProvider

// 定义初始过滤器设置，所有过滤器默认为关闭状态
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

// TabsScreen是应用的主页面，包含底部导航栏，用于切换不同的主要页面
// 使用 ConsumerStatefulWidget 来管理状态
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();

  // 获取 mealsProvider 的值
  // List<Meal> get meals => ref.watch(mealsProvider);
}

// TabsScreen的状态类，管理底部导航栏、收藏夹和过滤器
class _TabsScreenState extends ConsumerState<TabsScreen> {
  // 当前选中的页面索引，0表示分类页面，1表示收藏页面
  int _selectedPageIndex = 0;

  // 收藏的食物列表，初始为空
  final List<Meal> _favoriteMeals = [];

  // 当前选中的过滤器设置，初始使用kInitialFilters
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  // 显示信息提示的方法，使用SnackBar
  void _showInfoMessage(String message) {
    // 清除之前的SnackBar
    ScaffoldMessenger.of(context).clearSnackBars();
    // 显示新的SnackBar
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // 切换食物收藏状态的方法
  void _toggleMealFavoriteStatus(Meal meal) {
    // 检查食物是否已经在收藏列表中
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      // 如果已经收藏，则从收藏列表中移除
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite.'); // 显示移除收藏的提示
    } else {
      // 如果未收藏，则添加到收藏列表
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('Marked as a favorite!'); // 显示添加收藏的提示
      });
    }
  }

  // 选择底部导航栏页面的方法
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index; // 更新选中的页面索引
    });
  }

  // 设置屏幕的方法，处理抽屉菜单的导航
  void _setScreen(String identifier) async {
    // 关闭抽屉菜单
    Navigator.of(context).pop();

    // 如果选择了过滤器选项
    if (identifier == 'filters') {
      // 导航到过滤器页面，并等待返回结果
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      );

      // 更新过滤器设置，如果result为null则使用初始设置
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 获取 mealsProvider 的值
    final meals = ref.watch(mealsProvider);

    // 根据当前过滤器设置筛选可用的食物
    final availableMeals = meals.where((meal) {
      // 如果无麸质过滤器开启且食物含麸质，则排除
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      // 如果无乳糖过滤器开启且食物含乳糖，则排除
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      // 如果素食过滤器开启且食物不是素食，则排除
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      // 如果纯素食过滤器开启且食物不是纯素食，则排除
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      // 通过所有过滤器检查，保留该食物
      return true;
    }).toList();

    // 根据当前选中的页面索引决定显示哪个页面
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus, // 传递切换收藏状态的回调
      availableMeals: availableMeals, // 传递经过过滤的食物列表
    );
    var activePageTitle = 'Categories'; // 默认页面标题为"分类"

    if (_selectedPageIndex == 1) {
      // 如果选中的是收藏页面
      activePage = MealsScreen(
        meals: _favoriteMeals, // 传递收藏的食物列表
        onToggleFavorite: _toggleMealFavoriteStatus, // 传递切换收藏状态的回调
      );
      activePageTitle = 'Your Favorites'; // 页面标题为"你的收藏"
    }

    // 返回应用的主脚手架
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)), // 设置标题栏
      drawer: MainDrawer(onSelectScreen: _setScreen), // 设置抽屉菜单
      body: activePage, // 设置主体内容为当前活动页面
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage, // 设置点击事件处理方法
        currentIndex: _selectedPageIndex, // 设置当前选中的索引
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal), // 分类页面的图标
            label: 'Categories', // 分类页面的标签
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star), // 收藏页面的图标
            label: 'Favorites', // 收藏页面的标签
          ),
        ],
      ),
    );
  }
}
