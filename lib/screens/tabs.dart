import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  // 当前选中的页面索引
  int _selectedPageIndex = 0;

  // 收藏的菜品
  final List<Meal> _favoriteMeals = [];

  // 切换收藏状态
  void _toggleMealFavoriteStatus(Meal meal) {
    // 判断是否已经收藏
    final isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      _favoriteMeals.remove(meal);
    } else {
      _favoriteMeals.add(meal);
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 这个activePage 是动态的，根据 _selectedPageIndex 的值来决定显示哪个页面
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );

    var activePageTitle = 'Categories';

    // 如果 _selectedPageIndex 的值为 1，则显示 FavoritesScreen
    if (_selectedPageIndex == 1) {
      // 如果 _selectedPageIndex 的值为 1，则显示 MealsScreen
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          _selectPage(index);
        },
        items: const [
          // 底部导航栏的图标和文字
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
