import 'package:flutter/material.dart';

// 以下是被注释掉的导入，可能在开发过程中暂时不需要
// import 'package:meals/screens/tabs.dart';
// import 'package:meals/widgets/main_drawer.dart';

// 定义过滤器枚举类型，包含四种饮食限制选项
enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

// FiltersScreen 是一个有状态组件，用于管理和设置食物过滤器
class FiltersScreen extends StatefulWidget {
  // 构造函数，接收当前过滤器设置
  const FiltersScreen({super.key, required this.currentFilters});

  // 当前过滤器设置，使用Map存储每个过滤器的开启状态
  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() {
    // 创建并返回状态类的实例
    return _FiltersScreenState();
  }
}

// FiltersScreen的状态类，管理过滤器的UI和状态
class _FiltersScreenState extends State<FiltersScreen> {
  // 无麸质过滤器的状态（麸质是小麦中的一种蛋白质，某些人对其过敏）
  var _glutenFreeFilterSet = false;

  // 无乳糖过滤器的状态（乳糖是奶制品中的糖，某些人无法消化）
  var _lactoseFreeFilterSet = false;

  // 素食过滤器的状态（不含肉类，但可能含蛋和奶）
  var _vegetarianFilterSet = false;

  // 纯素食过滤器的状态（不含任何动物产品，包括蛋和奶）
  var _veganFilterSet = false;

  @override
  void initState() {
    // 调用父类的initState方法
    super.initState();

    // 从widget属性中初始化各个过滤器的状态
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    // 构建过滤器页面的脚手架
    return Scaffold(
      appBar: AppBar(title: const Text('过滤器')), // 设置页面标题为"过滤器"
      // 以下是被注释掉的抽屉菜单代码
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (ctx) => const TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),
      body: PopScope(
        // 使用PopScope替代已弃用的WillPopScope组件
        // 设置canPop为false，防止用户通过系统返回按钮直接关闭页面而不保存过滤器状态
        canPop: false,
        // 当用户尝试返回时的回调函数
        onPopInvoked: (didPop) {
          // 如果系统没有处理返回操作（didPop为false）
          if (!didPop) {
            // 手动处理导航返回，并传递当前过滤器设置
            Navigator.of(context).pop({
              Filter.glutenFree: _glutenFreeFilterSet,
              Filter.lactoseFree: _lactoseFreeFilterSet,
              Filter.vegetarian: _vegetarianFilterSet,
              Filter.vegan: _veganFilterSet,
            });
          }
        },
        // 页面主体内容
        child: Column(
          children: [
            // 无麸质过滤器开关
            SwitchListTile(
              value: _glutenFreeFilterSet, // 开关状态
              onChanged: (isChecked) {
                // 当开关状态变化时更新状态
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
              title: Text(
                // 标题：无麸质
                '无麸质',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                // 副标题：只包含无麸质的食物
                '只包含无麸质的食物',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary, // 开关激活颜色
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ), // 内容边距
            ),
            // 无乳糖过滤器开关
            SwitchListTile(
              value: _lactoseFreeFilterSet, // 开关状态
              onChanged: (isChecked) {
                // 当开关状态变化时更新状态
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
              title: Text(
                // 标题：无乳糖
                '无乳糖',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                // 副标题：只包含无乳糖的食物
                '只包含无乳糖的食物',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary, // 开关激活颜色
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ), // 内容边距
            ),
            // 素食过滤器开关
            SwitchListTile(
              value: _vegetarianFilterSet, // 开关状态
              onChanged: (isChecked) {
                // 当开关状态变化时更新状态
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
              },
              title: Text(
                // 标题：素食
                '素食',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                // 副标题：只包含素食的食物
                '只包含素食的食物',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary, // 开关激活颜色
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ), // 内容边距
            ),
            // 纯素食过滤器开关
            SwitchListTile(
              value: _veganFilterSet, // 开关状态
              onChanged: (isChecked) {
                // 当开关状态变化时更新状态
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
              title: Text(
                // 标题：纯素食
                '纯素食',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                // 副标题：只包含纯素食的食物
                '只包含纯素食的食物',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary, // 开关激活颜色
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ), // 内容边距
            ),
          ],
        ),
      ),
    );
  }
}
