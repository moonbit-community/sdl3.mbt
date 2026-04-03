# SDL3 未决问题

## 文档状态

- 状态：草案
- 负责人：TODO
- 最后更新：TODO

## 使用方式

- 把会影响包边界或公开 API 的未决设计问题记录在这里。
- 每个问题都尽量控制在一次讨论线程或一次集中设计里可以收敛的范围内。
- 一旦某个问题定案，就把结论同步回架构文档或推进路线文档，并在这里留下简短决议记录。

## 状态说明

- `open`：已经提出，但尚未定案
- `proposed`：当前有偏好方向，但未正式采纳
- `decided`：已经定案，并已反映到架构
- `deferred`：明确暂缓

## 当前问题

### Q1. 稳定 API 是否必须显式持有 `Runtime` token？

- 状态：`open`
- 为什么重要：
  - 影响所有创建型 API 的形状
  - 影响生命周期清晰度与测试性
- 当前备选：
  - 显式传递或持有 `Runtime`
  - 部分隐式全局运行时 + 显式资源拥有者
  - 以全局 API 为主，仅保留极少量 runtime token
- TODO：
  - 比较 MoonBit 使用体验与生命周期清晰度

### Q2. 稳定层资源释放策略是什么？

- 状态：`open`
- 为什么重要：
  - 影响 `Window`、`Canvas`、`Texture`、`Surface`、`Font` 以及设备句柄
- 当前备选：
  - 仅显式 `close()`
  - 显式 `close()` + finalizer 兜底
  - 主要依赖 finalizer，显式释放作为提前回收
- TODO：
  - 记录对 MoonBit 用户体验的利弊分析

### Q3. 输入与窗口事件的 payload 细节应如何建模？

- 状态：`open`
- 为什么重要：
  - 影响稳定层 typed event 的可发现性与可维护性
  - 影响 `events`、`input`、`video`、`base` 的边界
- 当前已定部分：
  - 顶层 `Event` 采用按领域分组的一层 ADT
  - 第一批优先细化 `App / Window / Keyboard / Text / Mouse / User / Unknown`
  - `WindowEvent` 第一批优先支持通用生命周期、几何、焦点与 fullscreen 相关变体
  - 事件系统中的几何命名暂按：
    - `Point / Size / Rect / Offset`
    - `PixelPoint / PixelSize / PixelRect`
- TODO：
  - 继续收敛 `MouseButtons`
  - 继续收敛 `MouseWheelDirection`
  - 继续收敛 `WindowId? / MouseId? / KeyboardId?` 的可选性边界

### Q4. 稳定 2D 渲染状态模型如何设计？

- 状态：`open`
- 为什么重要：
  - 影响 `render2d` 中几乎所有绘制调用
- 当前备选：
  - 每次 draw call 显式传入 `Paint`
  - `Canvas` 持有可变“当前状态”，通过 setter 更新
  - 提供 `with_paint` 之类的作用域状态 helper
- TODO：
  - 比较简单 demo 与较大绘制代码中的可读性差异

### Q5. `base` 层几何模型如何确定？

- 状态：`open`
- 为什么重要：
  - 影响 `base`、`video`、`surface`、`render2d`
- 当前备选：
  - 默认使用浮点类型，同时显式提供 `Pixel*` 类型
  - 默认以像素/整数为主，额外提供浮点渲染几何
  - 在所有场景中完全显式区分
- TODO：
  - 选出一套更自然的 MoonBit 命名方式

### Q6. `image` 和 `ttf` 是否只与 `Surface` 交互？

- 状态：`open`
- 为什么重要：
  - 影响包耦合度和测试方式
- 当前备选：
  - 只与 `Surface` 交互
  - 以 `Surface` 为主，在 `render2d` 提供便利转换
  - 直接在卫星包中支持 `Texture` 创建
- 当前倾向：
  - 保持卫星包以 `Surface` 为主

## 讨论模板

新增问题时，尽量使用以下模板：

```md
### QX. 简短问题

- 状态：`open`
- 为什么重要：
- 当前备选：
  - 方案 A
  - 方案 B
- 当前倾向：
- 受影响的包：
- TODO：
```

## 决议记录

### 已决问题

- 已决定：低层目录命名采用 `raw/`，不再使用 `lib/` 作为目标名称。
- 已决定：低层结构采用 `raw + sys` 两层方向；其中 `raw/` 已存在，`sys/` 需要后续拆出。
- 已决定：`raw` 是公开的低层 API，目标是尽量接近 SDL C 接口。
- 已决定：`raw` 可以保留绑定所必需的薄包装和基础 glue，不必为追求“纯”而先全面清洗。
- 已决定：`sys` 是内部浅层改造层，用来整理 `raw`，而不是再做一套最终用户 API。
- 已决定：建立 `sys` 时，不要求先彻底整理 `raw`；推荐一边建设 `sys`，一边只做最小必要的 `raw` 边界清理。
- 已决定：`sys/` 当前不新增子目录，只新增平铺的 `.mbt` 文件和模块。
- 已决定：`sys` 第一批建议模块为：
  - `sys/error.mbt`
  - `sys/result_shape.mbt`
  - `sys/runtime.mbt`
  - `sys/events.mbt`
  - `sys/video.mbt`
  - `sys/render.mbt`
  - `sys/surface.mbt`
- 已决定：`sys/error.mbt` 第一版错误类型草案为：
  - `pub suberror SysError { SysError(SysErrorKind, operation~ : String, msg~ : String) }`
- 已决定：`SysErrorKind` 第一版草案包含：
  - `BoolFailure`
  - `NullFailure`
  - `NegativeFailure`
  - `ValidationFailure`
  - `DecodeFailure`
  - `Uncategorized`
- 已决定：`SysError` 中保留 `kind`，但 `operation` 与 `msg` 先继续使用 `String`。
- 已决定：`operation` 与 `msg` 必须采用 label argument，避免两个字符串在调用点混淆。
- 已决定：`sys/error.mbt` 第一批函数草案包括：
  - `last_error_message`
  - `take_last_error_message`
  - `make_error`
  - `make_last_error`
  - `raise_error`
  - `raise_last_error`
  - `expect_ok`
  - `expect_not_null`
  - `expect_non_negative`
- 已决定：`sys/out.mbt` 更名为 `sys/result_shape.mbt`，以避免把职责误解为仅处理 out 参数。
- 已决定：`sys/result_shape.mbt` 第一批函数草案包括：
  - `slot`
  - `pair`
  - `triple`
  - `quad`
  - `get`
  - `get2`
  - `get3`
  - `get4`
  - `count_slot`
  - `read_count`
  - `check_count`
  - `collect_array`
  - `collect_array_from_count`
  - `collect_mapped_array`
  - `collect_mapped_array_from_count`
- 已决定：`get2 / get3 / get4` 采用异构泛型，而不是同构泛型。
- 已决定：第一版保留 `pair / triple / quad`。
- 已决定：第一版保留 `collect_mapped_array`。
- 已决定：`sys/runtime.mbt` 第一版职责包括：
  - 运行时 init / quit 的浅层整理
  - initialized flags 查询
  - app metadata 设置入口
  - 编译期与运行时版本信息读取
  - main-thread 查询
- 已决定：`sys/runtime.mbt` 第一版直接复用 `@raw.SDL_InitFlags`，不新增 `SysInitFlags`。
- 已决定：`sys/runtime.mbt` 第一版公开接口草案包括：
  - `init`
  - `init_subsystem`
  - `quit_subsystem`
  - `quit_all`
  - `initialized_flags`
  - `is_initialized`
  - `set_app_metadata`
  - `set_app_metadata_property`
  - `SysVersion`
  - `compiled_version`
  - `linked_version`
  - `is_main_thread`
- 已决定：`sys/runtime.mbt` 第一版保留 `set_app_metadata(...)` 与 `set_app_metadata_property(...)` 两个入口，但暂不引入 `SysAppMetadata` 结构体。
- 已决定：`sys/runtime.mbt` 第一版纳入 `is_main_thread()`，但暂不纳入 `run_on_main_thread(...)`。
- 已决定：`sys/runtime.mbt` 当前保持函数式浅层接口，不在模块内部维护额外运行时状态。
- 已决定：`sys/events.mbt` 第一版职责包括：
  - `SDL_Event` 缓冲与队列读取的浅层整理
  - event union 的低层解释入口
  - 明确区分“没有事件”“超时无事件”“真正错误”三类返回语义
- 已决定：`sys/events.mbt` 第一版公开接口草案包括：
  - `new_event_slot`
  - `poll_event_into`
  - `poll_event`
  - `wait_event_into`
  - `wait_event`
  - `wait_event_timeout_into`
  - `wait_event_timeout`
  - `read_event_type`
  - `expect_event_type`
  - `decode_quit_event`
  - `decode_keyboard_event`
  - `set_event_enabled`
  - `is_event_enabled`
  - `push_event`
  - `register_user_events`
- 已决定：`sys/events.mbt` 第一版同时保留 `poll_event()` 与 `poll_event_into()` 两套接口。
- 已决定：`sys/events.mbt` 第一版纳入 `push_event(...)` 与 `register_user_events(...)`。
- 已决定：`sys/events.mbt` 第一版暂不纳入 filter / watch / peep_events。
- 已决定：`sys/events.mbt` 中事件类型不匹配或 payload 解码失败时，应抛出 `SysError(DecodeFailure, ...)`。
- 已决定：稳定层 `Event` 采用按领域分组的一层 ADT。
- 已决定：稳定层 `Event` 顶层第一版分组草案包括：
  - `App`
  - `Display`
  - `Window`
  - `Keyboard`
  - `Text`
  - `Mouse`
  - `Joystick`
  - `Gamepad`
  - `Touch`
  - `Clipboard`
  - `Drop`
  - `AudioDevice`
  - `Sensor`
  - `Pen`
  - `Camera`
  - `User`
  - `Unknown`
- 已决定：第一批优先细化的事件组包括：
  - `AppEvent`
  - `WindowEvent`
  - `KeyboardEvent`
  - `TextEvent`
  - `MouseEvent`
  - `UserEvent`
  - `UnknownEvent`
- 已决定：`AppEvent` 第一版采用共享的 `AppEventInfo`。
- 已决定：`WindowEvent` 第一版采用：
  - `WindowEventInfo`
  - `WindowMovedEvent`
  - `WindowResizedEvent`
  - `WindowDisplayChangedEvent`
- 已决定：`WindowEvent` 第一批建议支持的变体包括：
  - `Shown`
  - `Hidden`
  - `Exposed`
  - `Moved`
  - `Resized`
  - `PixelSizeChanged`
  - `Minimized`
  - `Maximized`
  - `Restored`
  - `MouseEnter`
  - `MouseLeave`
  - `FocusGained`
  - `FocusLost`
  - `CloseRequested`
  - `DisplayChanged`
  - `Occluded`
  - `EnterFullscreen`
  - `LeaveFullscreen`
  - `Destroyed`
- 已决定：`KeyboardEvent` 第一版采用：
  - `KeyEvent`
  - `KeyboardDeviceEvent`
  - `KeyboardSystemEvent`
- 已决定：`TextEvent` 第一版采用：
  - `TextInputEvent`
  - `TextEditingEvent`
  - `TextEditingCandidatesEvent`
- 已决定：`MouseEvent` 第一版采用：
  - `MouseDeviceEvent`
  - `MouseMotionEvent`
  - `MouseButtonEvent`
  - `MouseWheelEvent`
- 已决定：`UserEvent` 与 `UnknownEvent` 必须分开。
- 已决定：`UserEvent` 中若保留 `data1 / data2`，必须包裹在显式 `unsafe` 命名的结构中。
- 已决定：事件系统中的几何命名当前采用：
  - 浮点族：`Point / Size / Rect / Offset`
  - 像素族：`PixelPoint / PixelSize / PixelRect`
- 已决定：`WindowEvent` 使用 `PixelPoint / PixelSize`。
- 已决定：`MouseEvent` 使用 `Point / Offset`。

### 待补充

- TODO：后续按日期补充更详细的决议记录。

## 下一轮讨论建议

- 先讨论 `MouseButtons`、`MouseWheelDirection`、`WindowId? / MouseId? / KeyboardId?` 这些输入事件细节。
- 然后讨论稳定层资源释放策略。
- 最后讨论渲染状态模型。
