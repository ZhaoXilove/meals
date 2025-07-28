import 'package:flutter/material.dart';
import 'package:meals/screens/tabs.dart';
import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  // 是否开启 gluten-free 过滤器
  var _glutenFreeFilterSet = false;
  // 是否开启 lactose-free 过滤器
  var _lactoseFreeFilterSet = false;
  // 是否开启 vegan 过滤器
  var _veganFilterSet = false;
  // 是否开启 vegetarian 过滤器
  var _vegetarianFilterSet = false;

  // 设置屏幕
  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'meals') {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (ctx) => const TabScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: Column(
        children: [
          SwitchListTile(
            title: Text(
              'Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            value: _glutenFreeFilterSet,
            onChanged: (isChecked) {
              setState(() {
                _glutenFreeFilterSet = isChecked;
              });
            },
            // 这里可以设置一个开关，当开关打开时，只显示 gluten-free 的菜肴
            subtitle: Text(
              'Only include gluten-free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            // 设置开关的颜色
            activeColor: Theme.of(context).colorScheme.tertiary,
            // 设置开关的间距
            contentPadding: EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            title: Text('Lactose-free'),
            value: _lactoseFreeFilterSet,
            onChanged: (isChecked) {
              setState(() {
                _lactoseFreeFilterSet = isChecked;
              });
            },
            subtitle: Text(
              'Only include lactose-free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            title: Text('Vegan'),
            value: _veganFilterSet,
            onChanged: (isChecked) {
              setState(() {
                _veganFilterSet = isChecked;
              });
            },
            subtitle: Text(
              'Only include vegan meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            title: Text('Vegetarian'),
            value: _vegetarianFilterSet,
            onChanged: (isChecked) {
              setState(() {
                _vegetarianFilterSet = isChecked;
              });
            },
            subtitle: Text(
              'Only include vegetarian meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
