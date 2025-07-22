enum Complexity { simple, challenging, hard }

enum Affordability { affordable, pricey, luxurious }

class Meal {
  const Meal({
    // id
    required this.id,
    // 分类
    required this.categories,
    // 标题
    required this.title,
    // 图片
    required this.imageUrl,
    // 配料
    required this.ingredients,
    // 步骤
    required this.steps,
    // 时长
    required this.duration,
    // 难度
    required this.complexity,
    // 价格
    required this.affordability,
    // 是否 含有麸质
    required this.isGlutenFree,
    // 是否 含有乳糖
    required this.isLactoseFree,
    // 是否 纯素
    required this.isVegan,
    // 是否 素食
    required this.isVegetarian,
  });

  // 属性
  final String id;
  // 分类
  final List<String> categories;
  // 标题
  final String title;
  // 图片
  final String imageUrl;
  // 配料
  final List<String> ingredients;
  // 步骤
  final List<String> steps;
  // 时长
  final int duration;
  // 难度
  final Complexity complexity;
  // 价格
  final Affordability affordability;
  // 是否 含有麸质
  final bool isGlutenFree;
  // 是否 含有乳糖
  final bool isLactoseFree;
  // 是否 纯素
  final bool isVegan;
  // 是否 素食
  final bool isVegetarian;
}
