# Flutter 美食应用知识点总结

## 项目概述

这是一个 Flutter 实现的美食分类与展示应用，用户可以浏览不同分类的美食，查看详细信息。应用采用了 Flutter 的组件化开发方式，实现了良好的 UI 交互和数据管理。

## 项目结构

```
lib/
  ├── data/         - 数据存储
  ├── models/       - 数据模型
  ├── screens/      - 页面
  ├── widgets/      - UI组件
  └── main.dart     - 应用入口
```

## 核心知识点

### 1. Dart 语言基础

#### 1.1 常量定义：const vs final

- **const**：编译时常量，值在编译时必须确定，对象及其所有属性完全不可变

  ```dart
  const availableCategories = [
    Category(id: 'c1', title: 'Italian', color: Colors.purple),
    // ...
  ];
  ```

- **final**：运行时常量，第一次使用时初始化，对象属性可变
  ```dart
  final filteredMeals = dummyMeals.where((meal) =>
    meal.categories.contains(category.id)).toList();
  ```

#### 1.2 枚举类型

用于定义有限集合的数据类型，增强代码可读性：

```dart
enum Complexity { simple, challenging, hard }
enum Affordability { affordable, pricey, luxurious }
```

### 2. Flutter UI 组件

#### 2.1 布局组件

- **Scaffold**：提供基本的应用结构（应用栏、主体内容区域）

  ```dart
  return Scaffold(
    appBar: AppBar(title: const Text('选择你的分类')),
    body: GridView(...),
  );
  ```

- **GridView**：网格布局，适合展示分类列表

  ```dart
  GridView(
    padding: const EdgeInsets.all(16),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 3 / 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
    ),
    children: [...],
  )
  ```

- **ListView.builder**：高性能列表构建器，适合展示长列表

  ```dart
  ListView.builder(
    itemCount: meals.length,
    itemBuilder: (ctx, index) => Text(meals[index].title),
  )
  ```

- **Container**：可自定义的容器组件，支持装饰、内边距等
  ```dart
  Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(...),
    child: Text(...),
  )
  ```

#### 2.2 交互组件

- **InkWell**：带水波纹效果的触摸区域，Material 风格的点击效果
  ```dart
  InkWell(
    onTap: onSelect,
    splashColor: Theme.of(context).primaryColor,
    borderRadius: BorderRadius.circular(16),
    child: Container(...),
  )
  ```

- **Stack**：层叠布局组件，允许子组件相互重叠
  ```dart
  Stack(
    children: [
      FadeInImage(...),  // 底层图片
      Positioned(...),   // 定位在图片上方的文本
    ],
  )
  ```

- **Positioned**：在 Stack 中精确定位子组件
  ```dart
  Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(...),
  )
  ```

#### 2.3 图片处理

- **FadeInImage**：提供占位图和淡入效果的图片组件
  ```dart
  FadeInImage(
    placeholder: MemoryImage(kTransparentImage),  // 加载时显示的透明占位图
    image: NetworkImage(meal.imageUrl),           // 实际要加载的网络图片
    fit: BoxFit.cover,                            // 图片填充方式
    width: double.infinity,
    height: 200,
  )
  ```

- **MemoryImage**：从内存中加载图片数据
  ```dart
  MemoryImage(kTransparentImage)  // kTransparentImage 是 transparent_image 包提供的透明图片
  ```

- **NetworkImage**：从网络加载图片
  ```dart
  NetworkImage(meal.imageUrl)
  ```

#### 2.4 装饰与样式

- **BoxDecoration**：用于美化 Container 的外观

  ```dart
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    gradient: LinearGradient(...),
  )
  ```

- **LinearGradient**：线性渐变效果，增强 UI 视觉体验
  ```dart
  gradient: LinearGradient(
    colors: [
      category.color.withValues(alpha: 0.55),
      category.color.withValues(alpha: 0.9),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  )
  ```

- **Card**：Material Design 卡片组件，提供预设的阴影、圆角和背景色
  ```dart
  Card(
    margin: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    clipBehavior: Clip.hardEdge,
    elevation: 2,
    child: ...
  )
  ```

- **clipBehavior**：控制子组件如何裁剪，特别是当子组件超出父组件边界时
  ```dart
  clipBehavior: Clip.hardEdge,  // 硬边裁剪，子组件超出部分被裁剪掉
  ```

- **elevation**：控制组件的阴影高度，数值越大阴影越明显，创造出组件的"浮起"效果
  ```dart
  elevation: 2,  // 轻微的阴影效果
  ```

#### 2.5 文本处理

- **Text**：基本文本显示组件，支持丰富的样式设置
  ```dart
  Text(
    meal.title,
    maxLines: 2,                 // 最多显示2行
    textAlign: TextAlign.center, // 文本居中对齐
    softWrap: true,              // 允许文本换行
    overflow: TextOverflow.ellipsis, // 文本溢出时显示省略号
    style: const TextStyle(...),
  )
  ```

- **TextStyle**：定义文本的样式属性
  ```dart
  TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  )
  ```

- **TextOverflow**：处理文本溢出的方式
  ```dart
  overflow: TextOverflow.ellipsis,  // 文本溢出时显示省略号(...)
  ```

### 3. 主题与样式

#### 3.1 主题定制

- **ThemeData**：定义全局应用主题

  ```dart
  final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 131, 57, 0),
    ),
    textTheme: GoogleFonts.latoTextTheme(),
  );
  ```

- **Theme.of(context)**：访问当前主题
  ```dart
  style: Theme.of(context).textTheme.titleLarge!.copyWith(
    color: Theme.of(context).colorScheme.onSurface,
  )
  ```

#### 3.2 颜色处理

- **Color.withValues()**：调整颜色透明度的新方法（替代已弃用的 withOpacity）
  ```dart
  category.color.withValues(alpha: 0.55)
  ```

### 4. 导航与路由

- **Navigator**：页面间导航
  ```dart
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) => MealsScreen(title: category.title, meals: filteredMeals),
    ),
  );
  ```

- **MaterialPageRoute**：Material Design风格的页面过渡效果
  ```dart
  MaterialPageRoute(
    builder: (ctx) => MealsScreen(title: category.title, meals: filteredMeals),
  )
  ```

- **路由参数传递**：通过构造函数传递数据到新页面
  ```dart
  MealsScreen(title: category.title, meals: filteredMeals)
  ```

### 5. 组件间通信与数据传递

在 Flutter 应用中，页面（Screen）本身也是一个大的组件（Widget）。页面间的跳转和数据传递，本质上就是组件间的通信。这个美食应用主要采用了两种方式：**构造函数传参**和**回调函数**。

#### 5.1 页面跳转与顺向传参（父传子）

这种方式就像单向的指令下达，上级页面把需要的信息告诉下级页面。

**场景：从 `分类页` 跳转到 `美食列表页`**

1.  **用户操作**：在 `CategoriesScreen`，用户点击一个美食分类（比如“意大利菜”）。
2.  **准备数据**：`CategoriesScreen` 内部的 `_selectCategory` 函数会立刻从总的美食列表 (`dummyMeals`) 中，筛选出所有属于“意大利菜”的美食，存为一个新的列表 `filteredMeals`。
3.  **导航并“打包”数据**：通过 `Navigator.of(context).push(...)` 跳转到 `MealsScreen`。在创建 `MealsScreen` 实例时，会像填写包裹单一样，把分类标题 (`category.title`) 和筛选出的美食列表 (`filteredMeals`) 作为构造函数的参数传递过去。
4.  **接收数据**：`MealsScreen` 在自己的构造函数中声明需要接收 `title` 和 `meals` 这两个参数，从而拿到上级页面传来的数据并进行展示。

```dart
// 在 CategoriesScreen 中 (发送方)
void _selectCategory(BuildContext context, Category category) {
  final filteredMeals = dummyMeals
      .where((meal) => meal.categories.contains(category.id))
      .toList();
  Navigator.of(context).push(
    MaterialPageRoute(
      // 创建 MealsScreen 实例，并把数据通过构造函数传进去
      builder: (ctx) => MealsScreen(
        title: category.title,
        meals: filteredMeals,
        onToggleFavorite: onToggleFavorite, // 回调函数也一并传递
      ),
    ),
  );
}

// 在 MealsScreen 中 (接收方)
class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavorite,
  });

  final String? title;
  final List<Meal> meals;
  // ...
}
```

#### 5.2 回调函数与逆向通信（子传父）

这种方式更像是下级向上级汇报工作。子页面在某个时刻，调用父页面预先“安装”在它身上的一个函数，来通知父页面发生了某件事或请求改变状态。

**场景：在任何页面点击“收藏”按钮，更新总收藏列表**

1.  **状态持有者与“操作许可”**：
    *   `TabsScreen` 是最顶层的页面，它持有最终的收藏列表 `_favoriteMeals`。
    *   它定义了一个能修改这个列表的函数 `_toggleMealFavoriteStatus`。这个函数就是“操作许可”。

2.  **“操作许可”的层层传递**：
    *   `TabsScreen` 把 `_toggleMealFavoriteStatus` 函数传给了它直接管理的 `CategoriesScreen`。
    *   `CategoriesScreen` 在跳转到 `MealsScreen` 时，又把这个函数接力传了下去。
    *   `MealsScreen` 在跳转到 `MealDetailsScreen` 时，继续把这个函数传给详情页。

3.  **子页面调用回调**：
    *   当用户在 `MealDetailsScreen` 点击收藏按钮时，它并不自己处理收藏逻辑，因为它没有权限。
    *   它会调用那个一路传递下来的 `onToggleFavorite` 函数，并把自己当前的 `meal` 对象作为参数传回去。

4.  **顶层状态更新**：
    *   调用信号最终回到了 `TabsScreen` 的 `_toggleMealFavoriteStatus` 函数。
    *   该函数根据传入的 `meal`，更新 `_favoriteMeals` 列表，并调用 `setState` 来刷新界面，从而让所有依赖这个收藏列表的页面（比如收藏夹页面）都能显示最新的状态。

**简单来说，数据是自上而下（`Tabs` -> `Categories` -> `Meals` -> `Details`）通过构造函数传递的；而状态的变更请求是自下而上（`Details` -> `Meals` -> `Categories` -> `Tabs`）通过回调函数传递的。**

- **List.where()**：根据条件筛选列表数据
  ```dart
  final filteredMeals = dummyMeals
      .where((meal) => meal.categories.contains(category.id))
      .toList();
  ```

### 6. 数据管理与处理

#### 6.1 条件渲染

根据数据状态显示不同内容：

```dart
if (meals.isEmpty) {
  return Center(
    child: Column(...),  // 显示"没有找到餐品"的提示
  );
}
```

#### 2.6 抽屉导航 (Drawer)

抽屉导航是移动应用中常见的模式，用于收纳主要的导航链接。Flutter 提供了 `Drawer` 组件来轻松实现此功能。 `lib/widgets/main_drawer.dart` 就是一个典型的抽屉实现。

-   **Drawer**: Material Design 风格的侧边栏面板，通常与 `Scaffold` 的 `drawer` 属性配合使用。
-   **DrawerHeader**: 用于 `Drawer` 的标准头部区域，可以自定义背景、图标和文本。
-   **ListTile**: 一个固定高度的列表项，非常适合在 `Drawer` 中显示导航选项。它包含了放置图标（`leading`）和文本（`title`）的预设位置，以及点击事件回调（`onTap`）。

**代码结构示例 (基于 `main_drawer.dart`)**:

```dart
// 在 main_drawer.dart 中
Drawer(
  child: Column(
    children: [
      DrawerHeader(...),
      ListTile(
        leading: Icon(Icons.restaurant),
        title: Text('Categories'),
        onTap: () {
          // 处理导航到分类页的逻辑
        },
      ),
      ListTile(
        leading: Icon(Icons.favorite),
        title: Text('Favorites'),
        onTap: () {
          // 处理导航到收藏页的逻辑
        },
      ),
    ],
  ),
)
```

**导航逻辑处理**:

`ListTile` 的 `onTap` 回调是实现导航的关键。有两种常见的处理方式：

1.  **直接导航**: 在 `onTap` 中直接调用 `Navigator`。为了用户体验，通常在跳转前先关闭抽屉。

    ```dart
    onTap: () {
      Navigator.of(context).pop(); // 关闭抽屉
      Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => CategoriesScreen(),
      ));
    }
    ```
    如果希望新页面替换当前页面而不是堆叠在上面（例如，在主导航中切换），可以使用 `pushReplacement`。
    ```dart
    onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (ctx) => TargetScreen(),
        ));
    }
    ```

2.  **通过回调函数**: 这种方式更加灵活和推荐（参考笔记第 5.2 节）。`Drawer` 组件接收一个函数作为参数，在 `onTap` 时调用该函数，由父组件（通常是 `Scaffold` 所在的页面）来处理实际的页面切换。

    ```dart
    // main_drawer.dart
    class MainDrawer extends StatelessWidget {
      const MainDrawer({super.key, required this.onSelectScreen});
      final void Function(String identifier) onSelectScreen;

      // ... build method ...
          ListTile(
            // ...
            onTap: () {
              onSelectScreen('categories');
            },
          ),
          ListTile(
            // ...
            onTap: () {
              onSelectScreen('favorites');
            },
          ),
    // ...
    }

    // 使用 Drawer 的父组件
    class TabsScreen extends StatefulWidget {
      // ...
      void _setScreen(String identifier) {
        Navigator.of(context).pop(); // 关闭抽屉
        if (identifier == 'favorites') {
          // 导航到收藏页
        } else {
          // 默认导航到分类页
        }
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(...),
          drawer: MainDrawer(onSelectScreen: _setScreen),
          body: ...
        );
      }
    }
    ```
    这种方法将导航逻辑从 `Drawer` 中分离出来，使 `Drawer` 成为一个纯粹的、可复用的 UI 部件，增强了代码的模块化和可维护性。

## 核心交互逻辑的 “费曼” 解释 (小学生版)

想象一下，我们的应用是一个大型的乐高城堡，由很多小部件（积木）和页面（房间）组成。它们之间需要互相沟通和配合才能正常工作。

### 1. 城堡总设计师与建筑工：父组件如何“命令”子组件？ (数据传递)

- **故事是这样的**：
  城堡的总设计师 (`TabsScreen`，最顶层的页面) 有一张完整的城堡蓝图。他决定要建一个“分类展厅”(`CategoriesScreen`)。

- **如何下达指令**：
  设计师不会自己去搬砖，他会找到一个建筑工头 (`CategoriesScreen`)，然后把一部分图纸（比如“所有可以用的食物列表”`availableMeals`）交给他。这个“交给他”的动作，就是在创建建筑工头这个“对象”时，把图纸作为“参数”传进去。

  ```dart
  // 设计师(TabsScreen) 创建并命令 建筑工头(CategoriesScreen)
  Widget activePage = CategoriesScreen(
    availableMeals: availableMeals, // <-- 把“可用的食物列表”这份图纸交给他
    onToggleFavorite: _toggleMealFavoriteStatus, // <-- 同时给了他一个对讲机
  );
  ```
  指令只能从上级传给下级，建筑工头不能反过来命令总设计师。这就是**单向数据流**。

### 2. 对讲机：子组件如何向父组件“汇报”？ (回调函数)

- **故事是这样的**：
  虽然建筑工头不能命令设计师，但如果他在工地上发现了什么重要情况（比如用户按下了“收藏”按钮），他需要立刻向设计师汇报。

- **如何汇报工作**：
  设计师在派工头去干活的时候，给了他一个神奇的“对讲机” (`onToggleFavorite` 函数)。这个对讲机是独一无二的，只能呼叫到这位总设计师。

  当用户在某个很深的房间里 (`MealDetailsScreen`) 点击了收藏按钮，这个房间里的工人就会拿起那个代代相传的对讲机，喊话：“报告！用户收藏了这个汉堡！”

- **设计师的反应**：
  总设计师 (`TabsScreen`) 在他的办公室里听到了对讲机。他拿出自己的总收藏清单 (`_favoriteMeals` 列表)，在上面添加了“汉堡”，然后用大喇叭通知整个城堡 (`setState`)：“大家注意，收藏清单更新了，请按新清单展示！”

  这个“对讲机”就是**回调函数**。它本身是“向下”传递的，但它的“信号”是“向上”发送的。

### 3. 房间传送门：页面是如何跳转和返回的？ (导航)

- **进入新房间** (`Navigator.push`)：
  我们的乐高城堡里有很多房间（页面）。当你从“分类大厅”想去“意大利美食”这个房间时，你喊了一声“Navigator, push!”，应用就会在你面前打开一扇通往新房间的传送门。

- **去新房间时带上玩具** (传递参数)：
  你去“意大利美食”房间时，不能空手去，你得带上所有属于“意大利”的美食玩具。所以在开门的时候，你就告诉传送门：“我要去 `MealsScreen` 房间，并且带上这些玩具 `meals`”。

- **从房间回来时带回纪念品** (`pop` 并返回值)：
  你去了一个叫“过滤器”的特殊房间 (`FiltersScreen`)，在里面设置了很多开关。当你从这个房间出来 (`pop`) 时，你手里拿着一张写着最新设置的“纪念品卡片”。

  在门外等你的设计师 (`TabsScreen`) 会 `await` (焦急地等待)，直到你出来，然后接过你手里的卡片，并根据上面的新设置更新整个城堡的规则。

  ```dart
  // 设计师等待建筑工从“过滤器”房间带回结果
  final result = await Navigator.of(context).push(...);

  // 拿到结果后，更新自己的状态
  setState(() {
    _selectedFilters = result ?? kInitialFilters;
  });
  ```

### 4. 守卫森严的房间出口 (PopScope)

- **故事是这样的**：
  城堡里有一个非常重要的房间，叫做“过滤器设计室”(`FiltersScreen`)。里面有很多精密的开关。如果一个冒失的访客不小心碰了返回按钮就跑掉了，他所有的设计（选择的过滤器）都会丢失，这太糟糕了！

- **如何设置守卫**：
  为了防止这种情况，我们在房间的出口处放了一个名叫 `PopScope` 的忠诚守卫。
  我们给了守卫一条死命令：`canPop: false`。意思就是：“没有我的允许，谁也不能离开！”

- **当有人想离开时**：
  当访客（用户）想要离开时，守卫会拦住他，并通过 `onPopInvoked` 对讲机向我们报告：“报告！有人想离开，但我把他拦住了 (`didPop` 是 `false`)”。

- **我们的处理**：
  听到报告后，我们就可以执行我们的计划了。我们会跑过去，把访客在桌子上的所有设计图（`_glutenFreeFilterSet` 等状态）小心翼翼地收进一个文件夹里，然后亲自护送他离开，并把这个文件夹交给他下一个要去见的人。这个“护送并交出文件夹”的动作，就是 `Navigator.of(context).pop(文件夹)`。

- **代码的样子**：
  ```dart
  // 在 FiltersScreen 房间门口设置守卫
  PopScope(
    canPop: false, // 命令：不许走！
    onPopInvoked: (didPop) { // 当他想走时，守卫报告
      if (!didPop) {
        // 我们把设计图打包好...
        final designs = { Filter.glutenFree: _glutenFreeFilterSet, /* 其他... */ };
        // ...然后亲自送他出门，并把设计图交出去
        Navigator.of(context).pop(designs);
      }
    },
    child: ... // 房间内部
  )
  ```
  这样，`PopScope` 守卫就确保了没有重要的信息会因为意外的返回而丢失。

### `PopScope` 的正式解释

`PopScope` 是一个用于拦截导航返回事件（例如，点击系统返回按钮或使用导航手势）的组件。它是对已弃用的 `WillPopScope` 的现代化替代方案。

**核心作用**：
- **防止数据丢失**：当用户在表单中输入了数据但未保存时，可以拦截返回操作，并弹出一个确认对话框，询问用户是否确定要放弃更改。
- **确保返回时传递数据**：在某些页面（如设置页或过滤器页），我们希望用户返回时必须带回一个结果。`PopScope`可以阻止用户空手而归，并强制通过我们自己的代码 `Navigator.pop(result)` 来返回。
- **自定义返回逻辑**：在执行返回操作前，可以执行一些自定义的异步任务，例如保存数据到服务器。

**主要API**:

- `child` (必须): `Widget` - 被 `PopScope` 包裹的子组件。
- `canPop` (必须): `bool` - 一个布尔值，决定了是否可以直接返回。
    - `true`: 允许正常返回。当返回手势发生时，页面会直接关闭，然后 `onPopInvoked` 会被调用，其参数 `didPop` 为 `true`。
    - `false`: 阻止直接返回。当返回手势发生时，页面不会关闭，此时 `onPopInvoked` 会被调用，其参数 `didPop` 为 `false`。这是实现自定义逻辑的关键。
- `onPopInvoked`: `void Function(bool didPop)` - 当返回事件被触发时调用的回调函数。
    - `didPop` 参数告知你返回操作是否真的发生了。你可以在这个回调中根据 `didPop` 的值来执行相应的逻辑（例如，当 `didPop` 为 `false` 时，手动调用 `Navigator.pop` 并传递数据）。

**使用场景示例：确保离开过滤器页面时返回数据**

在我们的美食应用中，`FiltersScreen` 就是一个绝佳的例子。我们不希望用户在修改了过滤器后，通过返回手势直接离开导致设置无效。我们必须拦截这个返回操作，并带上最新的过滤器设置返回给主页面。

```dart
// 在 FiltersScreen 中
class _FiltersScreenState extends State<FiltersScreen> {
  // ... (状态变量 _glutenFreeFilterSet 等)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('过滤器')),
      body: PopScope(
        canPop: false, // 阻止默认的返回行为
        onPopInvoked: (didPop) {
          // 当用户尝试返回时 (例如，通过手势)，didPop会是false，因为被canPop:false阻止了
          if (!didPop) {
            // 我们不显示对话框，而是直接带上最新的过滤器设置返回
            Navigator.of(context).pop({
              Filter.glutenFree: _glutenFreeFilterSet,
              Filter.lactoseFree: _lactoseFreeFilterSet,
              Filter.vegetarian: _vegetarianFilterSet,
              Filter.vegan: _veganFilterSet,
            });
          }
        },
        child: Column(
          // ... (包含各种 SwitchListTile 的子组件)
        ),
      ),
    );
  }
}
```

## 最佳实践与设计模式

### 1. 组件化开发

- 将 UI 拆分为可复用的小组件（如 CategoryGridItem）
- 每个组件负责特定功能，提高代码可维护性

### 2. 数据模型分离

- 使用专门的模型类定义数据结构（Category, Meal）
- 通过构造函数传递数据，保持组件无状态

### 3. 回调函数传递

- 通过函数回调实现子组件向父组件的通信
  ```dart
  onSelect: () => _selectCategory(context, category)
  ```

### 4. 多语言友好的注释

在代码中同时使用中英文注释，提高国际团队合作效率：

```dart
// 选择分类
void _selectCategory(BuildContext context, Category category) {
  // ...
}
```

## 性能优化技巧

1. 使用`const`构造函数创建不变的组件，减少重建
2. 使用`ListView.builder`而非普通`ListView`处理长列表
3. 适当使用`StatelessWidget`减少状态管理复杂度

## 常见问题与解决方案

1. **问题**：透明度设置方法变更
   **解决**：使用`withValues(alpha:)`替代已弃用的`withOpacity()`

2. **问题**：GridView 布局调整
   **解决**：通过`SliverGridDelegateWithFixedCrossAxisCount`调整网格参数

3. **问题**：页面间数据传递
   **解决**：通过构造函数参数传递数据给新页面