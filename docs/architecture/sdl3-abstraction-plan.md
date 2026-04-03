# SDL3 抽象方案

## 文档状态

- 状态：草案
- 负责人：TODO
- 最后更新：TODO
- 本文档是当前“目标包架构”的主参考文档。

## 目标

- 明确这个仓库的长期目录与包结构。
- 把 SDL 原始绑定问题与 MoonBit 面向用户的 API 设计问题分开处理。
- 在正式重构开始前，为人类贡献者和 AI 工程师提供统一的架构参考。

## 非目标

- 本文档不要求立即执行大规模目录迁移。
- 本文档不逐个描述所有 SDL 符号。
- 本文档不替代后续稳定后的包级 API 文档。

## 当前仓库快照

- `raw/` 当前承载 SDL 相关的原始 MoonBit FFI 绑定，以及部分底层 glue code。
- 仓库根目录当前仍承载一批更高层、直接面向用户的抽象。
- `main/` 和 `main2/` 当前仍是实验和 smoke test 场所。
- `c/` 中的 SDL 头文件仅供参考；实际链接使用的是系统上的 SDL。

## 术语

- `raw`
  指尽量接近 SDL 原型的原始绑定层，追求覆盖面和可追踪性，不追求 MoonBit 风格。
- `sys`
  指位于 `raw` 与稳定包之间的内部适配层，负责字符串转换、out 参数处理、所有权帮助函数、event union 解码等底层整理工作。
- `稳定包`
  指面向 MoonBit 用户、具有明确设计意图和长期维护目标的包。
- `facade`
  指仓库根包的门面导出层，只负责精选 re-export 和少量入口，不承担大型实现。

## 目标分层

1. `raw` 层
   已存在，负责 SDL 原始绑定。
2. `sys` 层
   计划拆出，负责内部低层适配。
3. 稳定公开包
   包括 `base`、`runtime`、`time`、`video`、`input`、`events`、`surface`、`render2d`、`image`、`ttf`、`app`。

## 目标目录草案

```text
/
  raw/                # 已存在：原始 SDL 绑定层
  sys/                # 计划新增：内部适配层；当前约定先只放平铺的 .mbt 文件，不新增子目录
  base/               # 纯值类型
  runtime/            # SDL 生命周期与初始化
  time/               # Duration、Timestamp、帧节奏
  video/              # display 与 window
  input/              # keyboard / mouse / gamepad / joystick
  events/             # typed event queue 与事件解码
  surface/            # SDL_Surface 与软件像素操作
  render2d/           # SDL_Renderer、SDL_Texture 与 2D 绘制
  image/              # SDL_image
  ttf/                # SDL_ttf
  app/                # 可选的高层应用 facade
  experimental/       # 不稳定或尚未成型的子系统
  docs/
    architecture/
    roadmap/
  examples/           # 面向文档和集成测试的示例
  scratch/            # 替代零散实验场的目录，后续再落地
```

## `raw` 与 `sys` 的边界约定

- `raw` 是公开的低层 API，不是内部私有目录。
- `raw` 的目标是尽量接近 SDL C 接口，追求 1:1 映射与覆盖面。
- `raw` 允许保留“绑定所必需的薄包装”，例如：
  - C 字符串与 MoonBit 字符串之间的最基础转换
  - 空指针与基础指针帮助函数
  - 为 MoonBit 调用 C 所必需的最小 glue code
- `raw` 不应继续增长新的“解释型”“策略型”“整理型” helper。
- `sys` 是内部浅层改造层，建立在 `raw` 之上。
- `sys` 的职责不是重做一遍 SDL，而是把 `raw` 整理成稳定包可以消费的低层接口。
- `sys` 负责的典型内容包括：
  - `Bool/null + SDL_GetError()` 这类统一错误路径
  - `count + FixedArray` 的整理
  - 事件缓冲、event union 解码和 typed event 的低层入口
  - 资源拥有与 destroy 规则的低层整理
  - 跨多个 `raw` API 的浅层组合
- 建立 `sys` 时，不要求先把 `raw` 彻底“洗纯”。
- 当前推荐策略是：
  - 立即开始建设 `sys`
  - 同时只做一轮最小必要的 `raw` 边界清理
  - 优先迁出那些会直接污染 `sys` 边界的 helper

## `sys` 层模块组织约定

- `sys/` 目前不新增子目录，只新增平铺的 `.mbt` 文件和模块。
- `sys` 不应按 SDL 分类全量镜像 `raw/`。
- `sys` 应按“稳定包马上会用到的浅层改造能力”来拆模块。
- 当前第一批建议模块：
  - `sys/error.mbt`
  - `sys/result_shape.mbt`
  - `sys/runtime.mbt`
  - `sys/events.mbt`
  - `sys/video.mbt`
  - `sys/render.mbt`
  - `sys/surface.mbt`
- 第二批按需新增：
  - `sys/input.mbt`
  - `sys/image.mbt`
  - `sys/ttf.mbt`
- 当前不建议先建立：
  - `sys/utils.mbt`
  - `sys/common.mbt`
  - `sys/resource.mbt`
  - `sys/string.mbt`
- 相关模块职责草案见：
  `docs/architecture/sys-layer-plan.md`
- 当前已收敛的 `sys/runtime.mbt` 第一版边界包括：
  - 直接复用 `@raw.SDL_InitFlags`
  - 提供 `init / init_subsystem / quit_subsystem / quit_all`
  - 提供 `initialized_flags / is_initialized`
  - 提供 `set_app_metadata / set_app_metadata_property`
  - 提供 `SysVersion / compiled_version / linked_version`
  - 提供 `is_main_thread()`
  - 暂不纳入 `run_on_main_thread(...)`
  - 暂不引入 `SysAppMetadata` 结构体

## 包职责

### `base`

- 负责跨包共享的纯值类型。
- 不依赖 SDL 句柄，不依赖运行时状态。
- 第一批候选类型：
  - `Color`
  - `Colors`
  - `Point`
  - `Size`
  - `Rect`
  - `PixelPoint`
  - `PixelSize`
  - `PixelRect`
  - `Vertex2`

### `runtime`

- 负责 SDL 的初始化、退出、元数据与全局运行时信息。
- 负责稳定层统一错误模型的入口。
- 第一批候选类型：
  - `Runtime`
  - `InitSpec`
  - `Subsystem`
  - `AppMetadata`
  - `RuntimeInfo`
  - `SdlError`

### `time`

- 负责时间值与帧节奏工具。
- 第一批候选类型：
  - `Duration`
  - `TimestampNs`
  - `Clock`
  - `FramePacer`

### `video`

- 负责 display 和 window 的生命周期。
- 稳定层中，只有它应当拥有 `SDL_Window`。
- 第一批候选类型：
  - `DisplayId`
  - `Display`
  - `DisplayMode`
  - `WindowId`
  - `Window`
  - `WindowSpec`
  - `WindowMode`
  - `WindowPosition`
  - `WindowStateSnapshot`

### `input`

- 负责设备 ID、按键/按钮枚举以及实时输入状态查询。
- 第一批候选类型：
  - `Key`
  - `Scancode`
  - `KeyMods`
  - `MouseButton`
  - `MouseState`
  - `KeyboardId`
  - `MouseId`
  - `GamepadId`
  - `Gamepad`
  - `GamepadButton`
  - `GamepadAxis`
  - `JoystickId`
  - `Joystick`

### `events`

- 负责事件轮询、等待、drain，以及 typed event 解码。
- 稳定层用户不应再需要 `unsafe_from_sdl_event`。
- 第一批候选类型：
  - `EventPump`
  - `Event`
  - `AppEvent`
  - `WindowEvent`
  - `KeyboardEvent`
  - `TextEvent`
  - `MouseEvent`
  - `GamepadEvent`
  - `DropEvent`
  - `UnknownEvent`
  - `UserEventId`

### `surface`

- 负责 `SDL_Surface` 生命周期与软件像素操作。
- 同时作为 `image` 和 `ttf` 的桥接层。
- 第一批候选类型：
  - `Surface`
  - `PixelFormat`
  - `SurfaceLock`
  - `BlitOptions`

### `render2d`

- 负责 `SDL_Renderer` 与 `SDL_Texture`。
- 提供 MoonBit 风格的 2D 绘制 API。
- 第一批候选类型：
  - `Canvas`
  - `CanvasSpec`
  - `Texture`
  - `TextureSpec`
  - `Paint`
  - `BlendMode`
  - `ScaleMode`
  - `GeometryBatch`

### `image`

- 负责 SDL_image 相关的加载与保存能力。
- 优先生产或消费 `Surface`，而不是直接返回 `Texture`。
- 第一批候选类型：
  - `ImageCodec`
  - `ImageFormatSupport`

### `ttf`

- 负责 SDL_ttf 相关的字体加载、测量与文字栅格化。
- 优先产出 `Surface` 或 metrics，而不是直接耦合渲染层。
- 第一批候选类型：
  - `Font`
  - `FontSpec`
  - `FontMetrics`
  - `TextStyle`
  - `TextMetrics`

### `app`

- 可选的高层便利层，用来把 `runtime`、`video`、`events`、`render2d` 串起来。
- 应在底层稳定后再建设。
- 第一批候选类型：
  - `Application`
  - `AppSpec`
  - `Frame`
  - `LoopControl`

## 依赖规则

- 稳定包不应直接 import `raw/`，除非该任务本身就是过渡期重构的一部分，并且范围明确。
- `sys` 应成为稳定包与 `raw` 之间的唯一正式桥梁。
- `raw` 与 `sys` 的关系是“原始绑定层”与“内部浅层改造层”，不是两个并列的稳定公开层。
- `base` 不依赖运行时状态，也不依赖 SDL 句柄。
- `events` 可以依赖 `video` 和 `input` 的值类型与 ID。
- `video` 不得依赖 `render2d`。
- `render2d` 可以依赖 `video`、`surface`、`base`。
- `image` 与 `ttf` 应依赖 `surface`，不应直接依赖 `render2d`。
- `experimental` 可以依赖稳定包；稳定包不能反向依赖 `experimental`。

## 公开 API 设计原则

- 不再把类似当前 `Context` 这样的“神对象”作为长期 API 中心。
- 对于参数较多的创建流程，优先使用 `WindowSpec`、`CanvasSpec`、`InitSpec` 这类规格对象。
- 稳定层优先使用命名值对象，而不是裸 tuple、裸 `Int`、裸 `UInt`。
- 稳定公开 API 不应泄漏 `@raw` 类型。
- 可以提供面向高级用户的逃生口，但必须显式表明其低层或 unsafe 性质。

## 资源所有权与生命周期

- 每个稳定包都应明确自己拥有的原生资源。
- destroy 规则必须在拥有者包中明确表达。
- TODO：决定稳定层是否允许 finalizer 作为兜底，还是强制显式 `close()`。

## 错误模型

- 稳定层应尽量收敛到统一的 `SdlError` 模型。
- 只有在确实增加领域语义时，才允许包内定义更细的专用错误。
- TODO：确定 `SdlError` 的具体结构。

## 事件模型

- 事件系统应产出 typed ADT，而不是让用户先判断类型再手工 cast。
- 未支持或未知的 SDL 事件仍应可表达。
- TODO：决定 `Event` 是完全扁平 ADT，还是分层嵌套 ADT。

## 渲染模型

- 后续绘制 API 不应以“镜像保存 renderer 当前颜色状态”作为核心抽象。
- 应优先考虑显式绘制参数，或语义清晰的作用域状态工具。
- TODO：决定 `Paint` 是逐调用传入，还是通过作用域状态管理。

## 兼容与迁移

- 根目录现有 API 可以在过渡期保留，但长期应收敛为薄 facade 或被标记为 deprecated 的兼容包装。
- 包迁移与目录重组必须分阶段进行，不能与无关功能混杂。
- TODO：补充 deprecation 策略与迁移说明结构。

## 测试与验证策略

- 原始绑定正确性与高层抽象质量是两类不同目标，必须分开跟踪。
- 每个 SDL 绑定子域最终都应尽量具备：
  - binding smoke test
  - 所有权与生命周期测试
  - 高层 API 测试
  - 至少一个示例或集成场景
- TODO：补充按包划分的测试矩阵。

## 文档策略

- 本文档描述长期架构。
- `docs/roadmap/sdl3-package-rollout.md` 描述推进顺序与阶段验收。
- `docs/roadmap/sdl3-open-questions.md` 记录当前尚未拍板的设计问题。

## 当前 TODO

- TODO：补充一份更细的 `raw -> sys` 按文件/按函数迁移清单。
- TODO：决定 `Runtime` 的 token 模型。
- TODO：决定几何值对象的最终形式。
- TODO：决定稳定包的 MoonBit import 路径命名规则。
- TODO：决定 `examples/` 与 `scratch/` 的最终职责分工。
