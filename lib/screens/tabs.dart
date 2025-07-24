import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 这个activePage 是动态的，根据 _selectedPageIndex 的值来决定显示哪个页面
    Widget activePage = const CategoriesScreen();

    var activePageTitle = 'Categories';

    // 如果 _selectedPageIndex 的值为 1，则显示 FavoritesScreen
    if (_selectedPageIndex == 1) {
      // 如果 _selectedPageIndex 的值为 1，则显示 MealsScreen
      activePage = const MealsScreen(meals: []);
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
