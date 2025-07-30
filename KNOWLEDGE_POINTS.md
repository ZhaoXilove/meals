# Flutter 美食应用知识点记录

## Dart 语言基础

### const 和 final 的区别

- **final**: 运行时常量，第一次使用时初始化，对象属性可变
- **const**: 编译时常量，编译时必须确定值，对象及其属性完全不可变（深度不可变）
- 示例：

  ```dart
  final time = DateTime.now(); // 正确，运行时确定
  const pi = 3.14; // 正确，编译时已知

  final list = [1, 2];
  list.add(3); // 正确，可修改属性

  const list2 = [1, 2];
  list2.add(3); // 错误，不能修改const对象
  ```

## Flutter UI 组件

### 主题与样式

- **ThemeData**: 定义应用的整体主题
- **ColorScheme**: 定义应用的颜色方案
  - `onSurface`: 用于 Surface 元素上的文本/图标颜色
  - `onBackground`: 用于背景上的文本/图标颜色

### 布局组件

- **Container**: 可定制的矩形视觉元素
- **BoxDecoration**: 自定义 Container 的装饰
  - `gradient`: 创建渐变效果
  - `borderRadius`: 设置圆角
- **Card**: Material Design 风格的卡片组件
  - `margin`: 设置外边距
  - `shape`: 定义卡片形状，如圆角
  - `clipBehavior`: 控制子组件溢出时的裁剪方式
  - `elevation`: 控制阴影高度，数值越大阴影越明显
  - 示例：
    ```dart
    Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      child: ...
    )
    ```
- **Stack**: 层叠布局组件，允许子组件相互重叠
  - 子组件按添加顺序堆叠，后添加的在上层
  - 示例：
    ```dart
    Stack(
      children: [
        FadeInImage(...),  // 底层图片
        Positioned(...),   // 定位在图片上方的文本
      ],
    )
    ```
- **Positioned**: 在 Stack 中精确定位子组件
  - `bottom`/`top`/`left`/`right`: 控制子组件位置
  - 示例：
    ```dart
    Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(...),
    )
    ```
- **GridView**: 网格布局组件，用于展示网格形式的内容
  - `gridDelegate`: 控制网格布局参数
  - `SliverGridDelegateWithFixedCrossAxisCount`: 固定列数的网格布局
  - 示例：
    ```dart
    GridView(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,  // 两列
        childAspectRatio: 3 / 2,  // 宽高比
        crossAxisSpacing: 20,  // 水平间距
        mainAxisSpacing: 20,  // 垂直间距
      ),
      children: [...],
    )
    ```
- **ListView.builder**: 高效构建长列表的组件
  - 按需构建可见项，适合大量数据
  - 示例：
    ```dart
    ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(meal: meals[index]),
    )
    ```

- **SingleChildScrollView**: 可滚动的单子组件容器
  - 使内容可在空间不足时滚动查看
  - 适用于有限内容的滚动需求
  - 不会按需构建子组件，所有内容一次性加载到内存
  - 常用属性:
    - `scrollDirection`: 滚动方向，默认垂直 (Axis.vertical)
    - `reverse`: 是否反转滚动方向
    - `padding`: 内边距
    - `physics`: 控制滚动行为，如 BouncingScrollPhysics、ClampingScrollPhysics
    - `controller`: 滚动控制器，用于控制或监听滚动
  - 示例：
    ```dart
    SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text('标题'),
          Image.asset('assets/image.jpg'),
          Text('很长的描述内容...')
        ],
      ),
    )
    ```
  - 与其他滚动组件对比:
    - 相比 ListView：适合内容有限且结构简单的情况
    - 相比 CustomScrollView：更简单，但灵活性较低
    - 不适合无限内容或大量数据，此类场景应使用 ListView.builder

### 交互组件

- **GestureDetector**: 检测多种手势的 widget

  - 无视觉反馈，只检测手势
  - 常用回调:
    - `onTap`: 点击事件
    - `onDoubleTap`: 双击事件
    - `onLongPress`: 长按事件
    - `onPanUpdate`: 拖动更新
    - `onScaleUpdate`: 缩放更新
  - 示例：
    ```dart
    GestureDetector(
      onTap: () {
        print('点击事件');
      },
      onLongPress: () {
        print('长按事件');
      },
      child: Container(
        color: Colors.blue,
        child: Text('点击我'),
      ),
    )
    ```

- **InkWell**: 带 Material 风格水波纹效果的触摸区域
  - 必须在 Material 组件内使用
  - 提供视觉反馈（水波纹）
  - 支持与 GestureDetector 相同的基本手势
  - 额外属性:
    - `splashColor`: 自定义水波纹颜色
    - `highlightColor`: 点按时的高亮颜色
    - `radius`: 设置水波纹半径
  - 项目中用法：
    ```dart
    InkWell(
      onTap: () => onSelect(context, meal),  // 点击时调用回调函数
      child: Stack(...),
    )
    ```

### GestureDetector vs InkWell

- **选择建议**:
  - 需要水波纹效果时使用 InkWell
  - 需要复杂手势（拖拽、缩放等）时使用 GestureDetector
  - 性能要求高时使用 GestureDetector（更轻量）
- **嵌套关系**:
  - InkWell 必须在 Material 内部
  - GestureDetector 可以在任何位置使用
- **组合使用**:
  ```dart
  GestureDetector(
    onPanUpdate: (details) {
      // 处理拖动
    },
    child: Material(
      child: InkWell(
        onTap: () {
          // 处理点击并显示水波纹
        },
        child: Container(),
      ),
    ),
  )
  ```

### 渐变

- **LinearGradient**: 线性渐变
  - `colors`: 渐变中使用的颜色列表
  - `begin`/`end`: 渐变的起始和结束位置

### 图片处理

- **FadeInImage**: 提供占位图和淡入效果的图片组件
  - `placeholder`: 加载时显示的占位图
  - `image`: 实际要加载的图片
  - `fit`: 图片填充方式
  - 示例：
    ```dart
    FadeInImage(
      placeholder: MemoryImage(kTransparentImage),  // 透明占位图
      image: NetworkImage(meal.imageUrl),           // 网络图片
      fit: BoxFit.cover,                            // 填充方式
      width: double.infinity,
      height: 200,
    )
    ```
- **MemoryImage**: 从内存中加载图片数据
- **NetworkImage**: 从网络URL加载图片

### 文本处理

- **Text**: 显示文本的基本组件
  - `style`: 文本样式
  - `maxLines`: 最大行数
  - `overflow`: 文本溢出处理方式
  - `textAlign`: 文本对齐方式
  - `softWrap`: 是否自动换行
  - 示例：
    ```dart
    Text(
      meal.title,
      maxLines: 2,
      textAlign: TextAlign.center,
      softWrap: true,
      overflow: TextOverflow.ellipsis,  // 溢出显示省略号
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    )
    ```

### 导航与路由

- **Navigator**: 页面导航系统
  - `Navigator.of(context).push()`: 导航到新页面
  - 示例：
    ```dart
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(title: category.title, meals: filteredMeals),
      ),
    );
    ```
- **MaterialPageRoute**: Material Design风格的页面过渡效果

### 颜色处理

- **Color 方法**:
  - `withOpacity()`: 已弃用
  - `withValues(alpha:)`: 推荐使用，避免精度损失
  - `withAlpha()`: 使用 0-255 整数值设置透明度

## 组件间通信

- **构造函数传参**: 父组件向子组件传递数据
  - 示例：
    ```dart
    // 父组件传递数据
    MealItem(meal: meals[index], onSelect: _selectMeal)
    
    // 子组件接收
    const MealItem({required this.meal, required this.onSelect});
    ```
- **回调函数**: 子组件向父组件通信
  - 父组件定义函数并传给子组件
  - 子组件在特定事件发生时调用该函数
  - 示例：
    ```dart
    // 父组件定义回调
    void _selectMeal(BuildContext context, Meal meal) {
      // 处理逻辑
    }
    
    // 子组件调用
    onTap: () => onSelect(context, meal)
    ```

## Flutter Riverpod 状态管理

### Riverpod 基础概念

- **Provider**: 提供状态的容器
  - 不可变的数据源，只读
  - 示例：
    ```dart
    // 定义一个简单的 Provider
    final mealsProvider = Provider<List<Meal>>((ref) {
      return dummyMeals;  // 返回静态数据
    });
    ```

- **StateNotifier**: 可变状态的管理器
  - 封装状态修改逻辑
  - 确保状态修改的可控性和可预测性
  - 示例：
    ```dart
    // 定义一个 StateNotifier 类
    class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
      // 构造函数，初始化空列表
      FavoriteMealsNotifier() : super([]);
      
      // 状态修改方法
      bool toggleMealFavoriteStatus(Meal meal) {
        final mealIsFavorite = state.contains(meal);
        if (mealIsFavorite) {
          // 移除收藏
          state = state.where((m) => m.id != meal.id).toList();
          return false;
        } else {
          // 添加收藏
          state = [...state, meal];
          return true;
        }
      }
    }
    ```

- **StateNotifierProvider**: 将 StateNotifier 暴露给 UI
  - 连接 StateNotifier 和 UI
  - 提供状态和修改状态的方法
  - 示例：
    ```dart
    // 定义一个 StateNotifierProvider
    final favoriteMealsProvider = 
        StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
          (ref) => FavoriteMealsNotifier(),
        );
    ```

### Riverpod 组件

- **ConsumerWidget**: 替代 StatelessWidget，可以访问 Provider
  - 通过 WidgetRef 参数访问 Provider
  - 示例：
    ```dart
    class MealDetailsScreen extends ConsumerWidget {
      @override
      Widget build(BuildContext context, WidgetRef ref) {
        // 使用 ref 访问 Provider
        final wasAdded = ref
            .read(favoriteMealsProvider.notifier)
            .toggleMealFavoriteStatus(meal);
        // ...
      }
    }
    ```

- **ConsumerStatefulWidget** 和 **ConsumerState**: 替代 StatefulWidget 和 State
  - 在有状态组件中访问 Provider
  - 示例：
    ```dart
    class TabsScreen extends ConsumerStatefulWidget {
      @override
      ConsumerState<TabsScreen> createState() => _TabsScreenState();
    }
    
    class _TabsScreenState extends ConsumerState<TabsScreen> {
      @override
      Widget build(BuildContext context) {
        // 使用 ref 访问 Provider
        final meals = ref.watch(mealsProvider);
        // ...
      }
    }
    ```

### 访问 Provider 数据

- **ref.watch()**: 监听 Provider 的变化并在变化时重建 UI
  - 用于需要实时反映状态变化的场景
  - 示例：
    ```dart
    // 监听 Provider 的值
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);
    ```

- **ref.read()**: 一次性读取 Provider 的值，不监听变化
  - 用于事件处理程序中，如按钮点击
  - 示例：
    ```dart
    // 读取 Provider 的值并调用方法
    final wasAdded = ref
        .read(favoriteMealsProvider.notifier)
        .toggleMealFavoriteStatus(meal);
    ```

- **ref.listen()**: 监听 Provider 的变化并执行回调，不重建 UI
  - 用于执行副作用，如显示通知
  - 示例：
    ```dart
    // 监听 Provider 的变化
    ref.listen(someProvider, (previous, next) {
      if (previous != next) {
        // 执行副作用
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('状态已更新')),
        );
      }
    });
    ```

### 状态修改最佳实践

- **不可变状态**: 始终创建新的状态对象，而不是修改现有对象
  - 错误示例：`state[filter] = isActive;` (直接修改)
  - 正确示例：`state = {...state, filter: isActive};` (创建新对象)

- **状态封装**: 将状态修改逻辑封装在 StateNotifier 中
  - 示例：
    ```dart
    // 在 StateNotifier 中封装状态修改逻辑
    void setFilter(Filter filter, bool isActive) {
      state = {...state, filter: isActive};
    }
    ```

- **Provider 组合**: 使用 ref 在一个 Provider 中访问另一个 Provider
  - 示例：
    ```dart
    // 过滤可用的食物
    final availableMeals = meals.where((meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      // 更多过滤逻辑...
      return true;
    }).toList();
    ```

## 最佳实践

- 使用主题系统保持 UI 一致性
- 为注释添加多语言说明提高代码可读性
- 遵循 Material Design 指南
- 避免使用已弃用的 API

## 项目结构

- **models/**: 数据模型
- **widgets/**: UI 组件
- **screens/**: 应用页面
- **providers/**: 状态管理提供者
