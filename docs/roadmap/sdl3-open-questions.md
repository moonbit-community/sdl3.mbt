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

### Q1. `sys/out.mbt` 应提供哪些函数形状？

- 状态：`open`
- 为什么重要：
  - `sys/out.mbt` 会成为多个 `sys` 模块共享的低层结果整理基础
  - 如果这里的接口不稳，后续 `sys/events`、`sys/video`、`sys/render` 都会返工
- 当前需要讨论的方向：
  - `sys/out.mbt` 如何统一单值、多值、数组类 out 参数
  - 低层 helper 应该多泛型，还是适度重复、保持直接
- 先讨论单值 out 参数
- 再讨论多值和数组类 out 参数

### Q2. 稳定 API 是否必须显式持有 `Runtime` token？

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

### Q3. 稳定层资源释放策略是什么？

- 状态：`open`
- 为什么重要：
  - 影响 `Window`、`Canvas`、`Texture`、`Surface`、`Font` 以及设备句柄
- 当前备选：
  - 仅显式 `close()`
  - 显式 `close()` + finalizer 兜底
  - 主要依赖 finalizer，显式释放作为提前回收
- TODO：
  - 记录对 MoonBit 用户体验的利弊分析

### Q4. `events.Event` 应如何建模？

- 状态：`open`
- 为什么重要：
  - 影响发现性
  - 影响 typed event 的使用体验
- 当前备选：
  - 一个完全扁平的 `Event` ADT
  - 分组层级，如 `Event::Window(WindowEvent)`
  - 混合设计：按大类分组，同时保留少数顶层快捷构造
- TODO：
  - 先用几个代表性事件做原型比较

### Q5. 稳定 2D 渲染状态模型如何设计？

- 状态：`open`
- 为什么重要：
  - 影响 `render2d` 中几乎所有绘制调用
- 当前备选：
  - 每次 draw call 显式传入 `Paint`
  - `Canvas` 持有可变“当前状态”，通过 setter 更新
  - 提供 `with_paint` 之类的作用域状态 helper
- TODO：
  - 比较简单 demo 与较大绘制代码中的可读性差异

### Q6. `base` 层几何模型如何确定？

- 状态：`open`
- 为什么重要：
  - 影响 `base`、`video`、`surface`、`render2d`
- 当前备选：
  - 默认使用浮点类型，同时显式提供 `Pixel*` 类型
  - 默认以像素/整数为主，额外提供浮点渲染几何
  - 在所有场景中完全显式区分
- TODO：
  - 选出一套更自然的 MoonBit 命名方式

### Q7. `image` 和 `ttf` 是否只与 `Surface` 交互？

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
  - `sys/out.mbt`
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

### 待补充

- TODO：后续按日期补充更详细的决议记录。

## 下一轮讨论建议

- 先讨论 `sys/out.mbt` 的函数形状。
- 然后讨论 `Runtime` 模型。
- 然后讨论事件 ADT 形状。
- 最后讨论渲染状态模型。
