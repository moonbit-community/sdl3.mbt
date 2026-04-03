# 稳定层事件 ADT 设计草案

## 文档状态

- 状态：草案
- 负责人：TODO
- 最后更新：TODO

## 目标

- 明确稳定层 `events.Event` 的整体形状。
- 明确第一批事件组的建模方向。
- 明确事件系统与 `video`、`input`、`base` 之间的边界。

## 已决定的总体原则

- 稳定层 `Event` 采用“按领域分组”的一层 ADT。
- 不采用完全扁平的巨大 `Event` enum。
- 不采用“部分事件放顶层、部分事件放分组”的混合设计。
- payload 不再保留 SDL 风格的 `event_type`、`data1`、`data2`。
- payload 以语义化字段为主。
- 允许在同一大类内部少量复用 payload struct，但不做跨大类复用。
- 当前 `raw` 尚未完整覆盖或稳定层尚未准备好的事件，可先落入 `Unknown`。

## 顶层 `Event` 草案

```moonbit
pub(all) enum Event {
  App(AppEvent)
  Display(DisplayEvent)
  Window(WindowEvent)
  Keyboard(KeyboardEvent)
  Text(TextEvent)
  Mouse(MouseEvent)
  Joystick(JoystickEvent)
  Gamepad(GamepadEvent)
  Touch(TouchEvent)
  Clipboard(ClipboardEvent)
  Drop(DropEvent)
  AudioDevice(AudioDeviceEvent)
  Sensor(SensorEvent)
  Pen(PenEvent)
  Camera(CameraEvent)
  User(UserEvent)
  Unknown(UnknownEvent)
}
```

说明：

- 顶层只分一层，不再继续引入 `Video(Window(...))` 或 `Input(Mouse(...))` 一类更深层嵌套。
- `Text` 与 `Keyboard` 明确分开，因为“文本输入/IME”和“物理按键”不是一回事。
- `Display` 与 `Window` 明确分开，因为两者虽然都归属于视频系统，但处理逻辑不同。
- `User` 与 `Unknown` 必须分开：
  - `User` 表示“已知是用户自定义事件”
  - `Unknown` 表示“当前稳定层尚不能解释该事件”

## 第一批优先细化的事件组

当前第一批优先细化：

- `AppEvent`
- `WindowEvent`
- `KeyboardEvent`
- `TextEvent`
- `MouseEvent`
- `UserEvent`
- `UnknownEvent`

原因：

- 这几组足以支撑退出、窗口生命周期、键盘、文本输入、鼠标等最常见用例。
- 它们与 `sys/events.mbt` 当前第一版的 `decode_*` 和 typed queue 目标最直接相关。

## `AppEvent` 草案

```moonbit
pub struct AppEventInfo {
  timestamp : TimestampNs
} derive(Show, Eq)

pub(all) enum AppEvent {
  Quit(AppEventInfo)
  Terminating(AppEventInfo)
  LowMemory(AppEventInfo)
  WillEnterBackground(AppEventInfo)
  DidEnterBackground(AppEventInfo)
  WillEnterForeground(AppEventInfo)
  DidEnterForeground(AppEventInfo)
  LocaleChanged(AppEventInfo)
  SystemThemeChanged(AppEventInfo)
}
```

说明：

- `AppEvent` 当前以通知型事件为主。
- 第一版建议共用一个 `AppEventInfo`，不为每个通知单独建立 payload struct。

## `WindowEvent` 草案

```moonbit
pub struct WindowEventInfo {
  timestamp : TimestampNs
  window_id : WindowId
} derive(Show, Eq)

pub struct WindowMovedEvent {
  timestamp : TimestampNs
  window_id : WindowId
  position : PixelPoint
} derive(Show, Eq)

pub struct WindowResizedEvent {
  timestamp : TimestampNs
  window_id : WindowId
  size : PixelSize
} derive(Show, Eq)

pub struct WindowDisplayChangedEvent {
  timestamp : TimestampNs
  window_id : WindowId
  display_id : DisplayId
} derive(Show, Eq)
```

第一批建议支持的变体：

```moonbit
pub(all) enum WindowEvent {
  Shown(WindowEventInfo)
  Hidden(WindowEventInfo)
  Exposed(WindowEventInfo)

  Moved(WindowMovedEvent)
  Resized(WindowResizedEvent)
  PixelSizeChanged(WindowResizedEvent)

  Minimized(WindowEventInfo)
  Maximized(WindowEventInfo)
  Restored(WindowEventInfo)

  MouseEnter(WindowEventInfo)
  MouseLeave(WindowEventInfo)
  FocusGained(WindowEventInfo)
  FocusLost(WindowEventInfo)

  CloseRequested(WindowEventInfo)
  DisplayChanged(WindowDisplayChangedEvent)

  Occluded(WindowEventInfo)
  EnterFullscreen(WindowEventInfo)
  LeaveFullscreen(WindowEventInfo)

  Destroyed(WindowEventInfo)
}
```

当前建议暂缓到后续讨论的窗口事件：

- `MetalViewResized`
- `HitTest`
- `IccProfileChanged`
- `DisplayScaleChanged`
- `SafeAreaChanged`
- `HdrStateChanged`

原因：

- 这些事件会额外引入平台特化建模、色彩/ICC 模型、safe area 表达或 HDR 状态建模问题。
- 它们不应阻塞第一版稳定窗口事件骨架。
- `WindowEvent` 中的 `window_id` 不应可选，因为这类事件天然属于某个窗口。

## `KeyboardEvent` 草案

```moonbit
pub struct KeyEvent {
  timestamp : TimestampNs
  window_id : WindowId?
  keyboard_id : KeyboardId?
  scancode : Scancode
  key : Key
  mods : KeyMods
  repeat : Bool
} derive(Show, Eq)

pub struct KeyboardDeviceEvent {
  timestamp : TimestampNs
  keyboard_id : KeyboardId
} derive(Show, Eq)

pub struct KeyboardSystemEvent {
  timestamp : TimestampNs
} derive(Show, Eq)

pub(all) enum KeyboardEvent {
  KeyDown(KeyEvent)
  KeyUp(KeyEvent)
  KeymapChanged(KeyboardSystemEvent)
  Added(KeyboardDeviceEvent)
  Removed(KeyboardDeviceEvent)
}
```

说明：

- `KeyDown` 与 `KeyUp` 共用 `KeyEvent`。
- `repeat` 保留在 `KeyEvent` 中。
- SDL 的平台 raw scancode 暂不进入稳定层 payload。
- `KeyEvent.window_id` 保留为 `WindowId?`，因为 SDL 原始语义是“the window with keyboard focus, if any”。
- `KeyEvent.keyboard_id` 保留为 `KeyboardId?`，因为 SDL 原始语义是“keyboard instance id, or 0 if unknown or virtual”。
- `KeyboardDeviceEvent.keyboard_id` 为必填，因为设备热插拔事件天然绑定具体键盘设备。

## `TextEvent` 草案

```moonbit
pub struct TextInputEvent {
  timestamp : TimestampNs
  window_id : WindowId?
  text : String
} derive(Show, Eq)

pub struct TextEditingEvent {
  timestamp : TimestampNs
  window_id : WindowId?
  text : String
  range_start : Int
  range_length : Int
} derive(Show, Eq)

pub struct TextEditingCandidatesEvent {
  timestamp : TimestampNs
  window_id : WindowId?
  candidates : Array[String]
  selected_index : Int?
} derive(Show, Eq)

pub(all) enum TextEvent {
  Input(TextInputEvent)
  Editing(TextEditingEvent)
  EditingCandidates(TextEditingCandidatesEvent)
}
```

说明：

- `TextEvent` 与 `KeyboardEvent` 明确分开。
- `Input`、`Editing`、`EditingCandidates` 当前建议分别使用专用 payload。
- `TextEvent.window_id` 保留为 `WindowId?`，因为 SDL 原始语义是“the window with keyboard focus, if any”。
- 如果早期 `raw` 对某一类文本事件 payload 尚未准备好，可暂时落入 `Unknown`，但目标形状先按此设计。

## 鼠标输入相关基础类型草案

```moonbit
pub(all) enum MouseButton {
  Left
  Middle
  Right
  X1
  X2
  Indexed(Int)
}

/// 语义上表示“当前按下的按钮集合”
pub struct PressedMouseButtons(UInt32) derive(Show, Eq)

pub(all) enum MouseWheelDirection {
  Normal
  Flipped
}

pub(all) enum MouseSource {
  Device(MouseId)
  Touch
  Pen
  Unspecified
}
```

说明：

- `MouseButton` 与 `PressedMouseButtons` 必须分开：
  - `MouseButton` 表示单个按钮身份
  - `PressedMouseButtons` 表示某一时刻当前按下的按钮集合
- `MouseButton` 不采用只有 5 个构造器的封闭 enum，而是保留：
  - `Left / Middle / Right / X1 / X2`
  - `Indexed(Int)` 用于没有 SDL 标准名字的额外按钮
- 当前建议在文档与实现注释中约定：
  - `Indexed(Int)` 主要面向 `6..32` 的额外按钮索引
  - 第一版暂不强制用更重的类型系统约束表达这一范围
- `PressedMouseButtons` 采用不透明 bitmask 值类型，而不是数组或固定布尔字段。
- `MouseWheelDirection` 采用 `Normal / Flipped`，保持与 SDL 原始语义一致。
- `MouseSource` 用于表达鼠标事件来源：
  - 真实鼠标设备
  - 触摸映射的虚拟鼠标
  - 笔映射的虚拟鼠标
  - 未指定来源

## `MouseEvent` 草案

```moonbit
pub struct MouseDeviceEvent {
  timestamp : TimestampNs
  mouse_id : MouseId
} derive(Show, Eq)

pub struct MouseMotionEvent {
  timestamp : TimestampNs
  window_id : WindowId?
  source : MouseSource
  position : Point
  delta : Offset
  buttons : PressedMouseButtons
} derive(Show, Eq)

pub struct MouseButtonEvent {
  timestamp : TimestampNs
  window_id : WindowId?
  source : MouseSource
  button : MouseButton
  clicks : Int
  position : Point
} derive(Show, Eq)

pub struct MouseWheelEvent {
  timestamp : TimestampNs
  window_id : WindowId?
  source : MouseSource
  delta : Offset
  direction : MouseWheelDirection
} derive(Show, Eq)

pub(all) enum MouseEvent {
  Motion(MouseMotionEvent)
  ButtonDown(MouseButtonEvent)
  ButtonUp(MouseButtonEvent)
  Wheel(MouseWheelEvent)
  Added(MouseDeviceEvent)
  Removed(MouseDeviceEvent)
}
```

说明：

- `ButtonDown` 与 `ButtonUp` 共用 `MouseButtonEvent`。
- 鼠标位置与滚轮/移动量先按连续空间几何建模。
- `MouseDeviceEvent.mouse_id` 为必填，因为设备热插拔事件天然绑定真实鼠标设备。
- `MouseMotionEvent / MouseButtonEvent / MouseWheelEvent` 中不再直接使用 `MouseId?`，而改用 `MouseSource`：
  - SDL 原始语义中，这些事件的 `which` 可能表示真实鼠标、触摸映射鼠标、笔映射鼠标，或 `0`
  - `MouseId?` 会丢失触摸与笔的来源信息
- `MouseMotionEvent / MouseButtonEvent / MouseWheelEvent.window_id` 保留为 `WindowId?`，因为 SDL 原始语义是“the window with mouse focus, if any”。

## `UserEvent` 与 `UnknownEvent` 草案

```moonbit
pub struct UnsafeUserEventData {
  data1 : @raw.VoidPtr
  data2 : @raw.VoidPtr
} derive(Show, Eq)

pub struct UserEvent {
  timestamp : TimestampNs
  event_id : UserEventId
  window_id : WindowId?
  code : Int
  unsafe_data : UnsafeUserEventData
} derive(Show, Eq)

pub struct UnknownEvent {
  raw_type : UInt
} derive(Show, Eq)
```

说明：

- `UserEvent` 与 `UnknownEvent` 必须分开。
- `UserEvent` 允许保留 `data1 / data2`，但必须包裹在显式 `unsafe` 命名的结构中。
- 第一版 `UnknownEvent` 故意保持较小，只暴露 `raw_type`。

## 事件系统使用的几何命名约定

当前建议采用两套几何家族：

### 浮点几何家族

```moonbit
pub struct Point {
  x : Double
  y : Double
} derive(Show, Eq)

pub struct Size {
  w : Double
  h : Double
} derive(Show, Eq)

pub struct Rect {
  x : Double
  y : Double
  w : Double
  h : Double
} derive(Show, Eq)

pub struct Offset {
  dx : Double
  dy : Double
} derive(Show, Eq)
```

### 像素几何家族

```moonbit
pub struct PixelPoint {
  x : Int
  y : Int
} derive(Show, Eq)

pub struct PixelSize {
  w : Int
  h : Int
} derive(Show, Eq)

pub struct PixelRect {
  x : Int
  y : Int
  w : Int
  h : Int
} derive(Show, Eq)
```

当前约定：

- `Point / Size / Rect / Offset` 默认表示连续空间或浮点语义。
- `PixelPoint / PixelSize / PixelRect` 表示离散像素语义。
- `WindowEvent` 中的窗口位置与尺寸使用 `PixelPoint / PixelSize`。
- `MouseEvent` 中的位置与增量使用 `Point / Offset`。
- 当前不建议第一版立即增加 `PixelOffset`。

## 当前仍待继续讨论的细节

- `DisplayEvent`、`GamepadEvent`、`TouchEvent` 等后续事件组的具体形状。
- `WindowEvent` 暂缓变体的补入顺序与依赖类型。
