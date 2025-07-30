import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 导入 Riverpod 库
import 'package:meals/providers/filters_provider.dart'; // 导入 filtersProvider

// 以下是被注释掉的导入，可能在开发过程中暂时不需要
// import 'package:meals/screens/tabs.dart';
// import 'package:meals/widgets/main_drawer.dart';

// FiltersScreen 是一个有状态组件，用于管理和设置食物过滤器
// ConsumerWidget 是 Riverpod 提供的一个组件，用于在组件中使用 provider 替换了之前的 ConsumerStatefulWidget, 不需要再创建状态类
// ConsumerWidget 是无状态组件，不需要再创建状态类，好处是简化代码，但缺点是每次构建时都会重新构建，性能不如有状态组件
class FiltersScreen extends ConsumerWidget {
  // 构造函数，接收当前过滤器设置
  // 现在不需要currentFilters参数了，使用filtersProvider的值
  // required this.currentFilters
  const FiltersScreen({super.key});

  // 当前过滤器设置，使用Map存储每个过滤器的开启状态
  //  final Map<Filter, bool> currentFilters;

  /*   @override
  ConsumerState<FiltersScreen> createState() {
    // 创建并返回状态类的实例
    return _FiltersScreenState();
  }
}

// FiltersScreen的状态类，管理过滤器的UI和状态
class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  // 无麸质过滤器的状态（麸质是小麦中的一种蛋白质，某些人对其过敏）
  var _glutenFreeFilterSet = false;

  // 无乳糖过滤器的状态（乳糖是奶制品中的糖，某些人无法消化）
  var _lactoseFreeFilterSet = false;

  // 素食过滤器的状态（不含肉类，但可能含蛋和奶）
  var _vegetarianFilterSet = false;

  // 纯素食过滤器的状态（不含任何动物产品，包括蛋和奶）
  var _veganFilterSet = false; */

  // @override
  // void initState() {
  // 调用父类的initState方法
  // super.initState();
  // 从filtersProvider中获取过滤器状态
  // final activeFilters = ref.read(filtersProvider);
  // 更新各个过滤器的状态
  // _glutenFreeFilterSet = activeFilters[Filter.glutenFree]!;
  // _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree]!;
  // _vegetarianFilterSet = activeFilters[Filter.vegetarian]!;
  // _veganFilterSet = activeFilters[Filter.vegan]!;
  // 从widget属性中初始化各个过滤器的状态
  // _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
  // _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
  // _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
  // _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    // 构建过滤器页面的脚手架
    return Scaffold(
      appBar: AppBar(title: const Text('过滤器')), // 设置页面标题为"过滤器"
      body: Column(
        children: [
          // 无麸质过滤器开关
          SwitchListTile(
            value: activeFilters[Filter.glutenFree]!, // 开关状态
            onChanged: (isChecked) {
              // 当开关状态变化时更新状态
              // setState(() {
              //   _glutenFreeFilterSet = isChecked;
              // });
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
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
            contentPadding: const EdgeInsets.only(left: 34, right: 22), // 内容边距
          ),
          // 无乳糖过滤器开关
          SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!, // 开关状态
            onChanged: (isChecked) {
              // 当开关状态变化时更新状态
              // setState(() {
              //   _lactoseFreeFilterSet = isChecked;
              // });
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
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
            contentPadding: const EdgeInsets.only(left: 34, right: 22), // 内容边距
          ),
          // 素食过滤器开关
          SwitchListTile(
            value: activeFilters[Filter.vegetarian]!, // 开关状态
            onChanged: (isChecked) {
              // 当开关状态变化时更新状态
              // setState(() {
              //   _vegetarianFilterSet = isChecked;
              // });
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
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
            contentPadding: const EdgeInsets.only(left: 34, right: 22), // 内容边距
          ),
          // 纯素食过滤器开关
          SwitchListTile(
            value: activeFilters[Filter.vegan]!, // 开关状态
            onChanged: (isChecked) {
              // 当开关状态变化时更新状态
              //  setState(() {
              //   _veganFilterSet = isChecked;
              // });
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
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
            contentPadding: const EdgeInsets.only(left: 34, right: 22), // 内容边距
          ),
        ],
      ),
    );
  }
}
