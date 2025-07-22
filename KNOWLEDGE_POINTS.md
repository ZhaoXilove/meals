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
  - 示例：
    ```dart
    Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print('点击事件');
        },
        splashColor: Colors.amber,
        child: Container(
          padding: EdgeInsets.all(12),
          child: Text('带水波纹效果'),
        ),
      ),
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

### 颜色处理

- **Color 方法**:
  - `withOpacity()`: 已弃用
  - `withValues(alpha:)`: 推荐使用，避免精度损失
  - `withAlpha()`: 使用 0-255 整数值设置透明度

## 最佳实践

- 使用主题系统保持 UI 一致性
- 为注释添加多语言说明提高代码可读性
- 遵循 Material Design 指南
- 避免使用已弃用的 API

## 项目结构

- **models/**: 数据模型
- **widgets/**: UI 组件
- **screens/**: 应用页面
