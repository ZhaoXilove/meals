import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart'; // 导入食物模型
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 导入 Riverpod 库
import 'package:meals/providers/favorite_provider.dart'; // 导入 favoriteMealsProvider 和 FavoriteMealsNotifier
import 'package:meals/providers/filters_provider.dart'; // 导入 filteredMealsProvider

// MealDetailsScreen是一个无状态组件，用于显示食物的详细信息
// 使用 ConsumerWidget 来管理状态 替代 StatelessWidget
class MealDetailsScreen extends ConsumerWidget {
  // 构造函数，接收必要的参数
  const MealDetailsScreen({
    super.key,
    required this.meal, // 要显示详情的食物
    // required this.onToggleFavorite, // 切换收藏状态的回调函数
  });

  // 要显示详情的食物对象
  final Meal meal;

  // 切换收藏状态的回调函数，参数表示是否收藏
  // final void Function(bool isFavorite) onToggleFavorite;

  //  显示信息提示的方法，使用SnackBar
  void _showInfoMessage(BuildContext context, String message) {
    // 清除之前的SnackBar
    ScaffoldMessenger.of(context).clearSnackBars();
    // 显示新的SnackBar
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 获取 favoriteMealsProvider 的值, 这里使用read不使用watch是 因为 这里不需要监听 收藏列表的变化，只是触发收藏状态的改变
    // final favoriteMeals = ref.read(favoriteMealsProvider);

    // 监听 favoriteMealsProvider 的值
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    // 判断 meal 是否在 favoriteMeals 中
    final isFavorite = favoriteMeals.contains(meal);

    // 返回一个脚手架，包含标题栏和主体内容
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title), // 标题栏显示食物名称
        actions: [
          // 添加一个收藏按钮
          IconButton(
            onPressed: () {
              // 点击时调用切换收藏状态的回调函数
              //  onToggleFavorite(meal.id == meal.id);
              // 切换收藏状态
              // 现在使用 ref.read(favoriteMealsProvider.notifier) 来获取 favoriteMealsProvider 的值
              // 返回值是Bool 是否添加成功
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              _showInfoMessage(
                context,
                wasAdded ? '食物已添加至收藏夹.' : '食物已从收藏夹中移除.',
              );
            },
            // 隐式动画 使用AnimatedSwitcher 来实现动画效果
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  // 缩放动画
                  // ScaleTransition(scale: animation, child: child),
                  // 旋转动画
                  RotationTransition(
                    // Tween是动画的插值器，用于计算动画的值, 用于做补间动画 ，这里用于做旋转动画
                    turns: Tween<double>(
                      begin: 0.7,
                      end: 1.0,
                    ).animate(animation),
                    child: child,
                  ),
              // 需要设置Key，不然隐式动画无法触发，因为动画是根据Key来判断的
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite),
              ), // 使用星形图标表示收藏
            ),
          ),
        ],
      ),
      // 使用SingleChildScrollView使内容可滚动
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 显示食物的图片
            // 使用Hero 来实现动画效果 ， 在两个页面之间共享动画 ， 并且使用很方便
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl, // 图片URL
                width: double.infinity, // 宽度占满屏幕
                height: 300, // 高度固定为300
                fit: BoxFit.cover, // 图片填充方式为覆盖
              ),
            ),
            const SizedBox(height: 14), // 间隔
            // 显示"配料"标题
            Text(
              'Ingredients', // 配料
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14), // 间隔
            // 循环显示所有配料
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            const SizedBox(height: 24), // 间隔
            // 显示"步骤"标题
            Text(
              'Steps', // 步骤
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14), // 间隔
            // 循环显示所有步骤
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12, // 水平内边距
                  vertical: 8, // 垂直内边距
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center, // 文本居中对齐
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
