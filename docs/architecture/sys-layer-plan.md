# `sys` 层设计草案

## 文档状态

- 状态：草案
- 负责人：TODO
- 最后更新：TODO
- 本文档用于细化 `sys/` 层的模块拆分与职责边界。

## 背景

- `raw/` 已承担 SDL 原始绑定职责。
- 当前仓库需要一个位于 `raw` 与稳定包之间的内部浅层改造层。
- 这个层不直接面向最终用户承诺稳定性，但会成为后续 `runtime`、`video`、`events`、`render2d` 等稳定包的直接底座。

## 已决定的原则

- `sys/` 当前不新增子目录，只新增平铺的 `.mbt` 文件和模块。
- `sys` 不按 SDL 全量镜像 `raw`。
- `sys` 按“浅层改造的实际需求”拆模块。
- `sys` 负责整理 `raw`，不负责直接变成最终的 MoonBit 高层 API。
- 建立 `sys` 时，不要求先把 `raw` 全面重构为最纯粹的 1:1 绑定。
- 推荐路线是：一边建立 `sys`，一边只做一轮最小必要的 `raw` 边界清理。

## `sys` 的职责范围

`sys` 应主要承接以下工作：

- 统一 `Bool/null + SDL_GetError()` 风格的错误路径
- 整理 `count + FixedArray` 和常见 out 参数模式
- 整理事件缓冲、event union 解码和 typed event 的低层入口
- 整理底层资源获取/销毁规则
- 提供跨多个 `raw` API 的浅层组合

`sys` 不应承担以下职责：

- 不直接提供最终用户风格的高层 API
- 不重做一套完整 SDL 分类目录
- 不先造一个泛化很强但职责模糊的 `utils/common` 大文件

## 第一批模块草案

### `sys/error.mbt`

职责：

- 统一处理 `Bool` 返回值失败后的错误提升
- 统一处理空指针返回值失败后的错误提升
- 提供低层 operation 上下文到错误信息的拼接策略
- 提供 `sys` 层统一的低层错误类型

适合放入：

- 最基础的低层错误类型
- `check_bool` / `check_ptr` 之类的检查函数
- 统一抓取 SDL last error 的薄层逻辑

不适合放入：

- 领域专用错误类型
- 面向最终用户的文案包装

当前第一版设计草案：

```moonbit
pub(all) enum SysErrorKind {
  BoolFailure
  NullFailure
  NegativeFailure
  ValidationFailure
  DecodeFailure
  Uncategorized
}

pub suberror SysError {
  SysError(SysErrorKind, operation~ : String, msg~ : String)
} derive(Show, Eq)
```

说明：

- `kind` 必须存在，用于区分错误的判定来源和低层语义类别。
- `operation` 和 `msg` 先保持为 `String`，避免过早做成过重的封闭建模。
- `operation` 与 `msg` 必须使用 label argument，避免在调用点混淆两个字符串。
- 当前不建议把 `operation` 做成大型 enum。
- 当前也不建议一开始就在 `SysError` 中加入更多字段。

`SysErrorKind` 当前含义：

- `BoolFailure`
  用于 SDL 风格“返回 `Bool`，`false` 表示失败”的场景。
- `NullFailure`
  用于返回指针或句柄，空值表示失败的场景。
- `NegativeFailure`
  用于返回 `Int` 且负数表示失败的场景。
- `ValidationFailure`
  用于 `sys` 在浅层整理时主动发现输入、中间结果或返回值形状不满足约定。
- `DecodeFailure`
  用于 reinterpret、union 解码、底层 payload 解释失败等场景。
- `Uncategorized`
  作为早期兜底项使用。它表示错误真实存在，但当前 taxonomy 尚未给出更精确类别。

当前建议的第一批函数形状：

```moonbit
pub fn last_error_message() -> String

pub fn take_last_error_message() -> String

pub fn make_error(
  kind : SysErrorKind,
  operation~ : String,
  msg~ : String,
) -> SysError

pub fn make_last_error(
  kind : SysErrorKind,
  operation~ : String,
) -> SysError

pub fn raise_error(
  kind : SysErrorKind,
  operation~ : String,
  msg~ : String,
) -> Unit raise SysError

pub fn raise_last_error(
  kind : SysErrorKind,
  operation~ : String,
) -> Unit raise SysError

pub fn expect_ok(
  operation~ : String,
  ok : Bool,
) -> Unit raise SysError

pub fn[T] expect_not_null(
  operation~ : String,
  value : T,
) -> T raise SysError

pub fn expect_non_negative(
  operation~ : String,
  value : Int,
) -> Int raise SysError
```

补充说明：

- 以上函数形状是当前推荐草案，不代表所有命名都已经最终冻结。
- `expect_ok`、`expect_not_null`、`expect_non_negative` 对应 `BoolFailure`、`NullFailure`、`NegativeFailure` 三类最常见 SDL 失败模式。
- `make_error`、`make_last_error`、`raise_error`、`raise_last_error` 用于让其他 `sys` 模块在需要时直接构造或抛出 `SysError`。
- 当前优先把 `sys/error.mbt` 设计成 `raise` 风格 API，而不是 `Result` 风格 API。

### `sys/result_shape.mbt`

职责：

- 整理 SDL 常见 out 参数模式
- 整理 `count + FixedArray` 结果
- 为其他 `sys` 模块提供统一的低层结果提取工具

适合放入：

- 单值 out 参数读取 helper
- 双值或多值 out 参数读取 helper
- 长度配合数组返回值的整理 helper

不适合放入：

- 特定领域的业务语义
- 与错误路径强耦合的高层策略

当前第一版设计草案：

```moonbit
pub fn[T] slot(init : T) -> FixedArray[T]

pub fn[T] pair(init : T) -> (FixedArray[T], FixedArray[T])

pub fn[T] triple(init : T) -> (
  FixedArray[T],
  FixedArray[T],
  FixedArray[T],
)

pub fn[T] quad(init : T) -> (
  FixedArray[T],
  FixedArray[T],
  FixedArray[T],
  FixedArray[T],
)

pub fn[T] get(slot : FixedArray[T]) -> T

pub fn[A, B] get2(
  a : FixedArray[A],
  b : FixedArray[B],
) -> (A, B)

pub fn[A, B, C] get3(
  a : FixedArray[A],
  b : FixedArray[B],
  c : FixedArray[C],
) -> (A, B, C)

pub fn[A, B, C, D] get4(
  a : FixedArray[A],
  b : FixedArray[B],
  c : FixedArray[C],
  d : FixedArray[D],
) -> (A, B, C, D)

pub fn count_slot() -> FixedArray[Int]

pub fn read_count(
  operation~ : String,
  count : FixedArray[Int],
) -> Int raise SysError

pub fn check_count(
  operation~ : String,
  count : Int,
) -> Int raise SysError

pub fn[T] collect_array(
  operation~ : String,
  values : FixedArray[T],
  count : Int,
) -> Array[T] raise SysError

pub fn[T] collect_array_from_count(
  operation~ : String,
  values : FixedArray[T],
  count : FixedArray[Int],
) -> Array[T] raise SysError

pub fn[T, U] collect_mapped_array(
  operation~ : String,
  values : FixedArray[T],
  count : Int,
  f : (T) -> U,
) -> Array[U] raise SysError

pub fn[T, U] collect_mapped_array_from_count(
  operation~ : String,
  values : FixedArray[T],
  count : FixedArray[Int],
  f : (T) -> U,
) -> Array[U] raise SysError
```

说明：

- `slot / pair / triple / quad` 用于创建最常见的同构 out 参数槽位。
- `get` 用于读取单槽值。
- `get2 / get3 / get4` 采用异构泛型，而不是同构泛型。
- 保持 `get2 / get3 / get4` 为异构形式的原因是：SDL 的多个 out 参数不一定同类型。
- `count_slot()` 用于为 `count + array` 类接口准备计数槽位。
- `read_count(...)` 用于从 `FixedArray[Int]` 形式的计数槽位中读取并校验 count。
- `check_count(...)` 用于在 count 已经是 `Int` 时做统一校验。
- `collect_array(...)` 与 `collect_array_from_count(...)` 负责把 `count + FixedArray[T]` 整理成 `Array[T]`。
- `collect_mapped_array(...)` 与 `collect_mapped_array_from_count(...)` 允许在收集阶段直接做映射，避免在各 `sys` 模块中重复写遍历转换逻辑。

当前约定：

- `read_count(...)` 与 `check_count(...)` 在遇到负数计数时，应抛出 `SysError(ValidationFailure, ...)`。
- 第一版保留 `pair / triple / quad`。
- 第一版保留 `collect_mapped_array`，不推迟到后续版本。
- 当前不建议在 `sys/result_shape.mbt` 中继续加入更多公开函数，避免它膨胀成泛化工具箱。

### `sys/runtime.mbt`

职责：

- 在 `raw/init`、`raw/version` 与相关基础 API 上做运行时级浅层适配
- 统一处理 SDL 初始化/退出相关的低层错误提升
- 提供运行时初始化状态、版本信息与应用元数据的低层入口
- 服务未来的稳定 `runtime` 包，但不在 `sys` 层提前固化最终 `Runtime` 对象设计

适合放入：

- init / quit 的低层整理
- initialized flags 的浅层查询
- metadata / version 的浅层入口
- runtime 级 capability 检查

不适合放入：

- 最终公开 `Runtime` 对象的高层语义
- `run_on_main_thread(...)` 这类会引入 callback 与线程策略的问题
- 自动 quit guard、引用计数、全局状态缓存

当前第一版设计草案：

```moonbit
pub(all) struct SysVersion {
  major : Int
  minor : Int
  micro : Int
} derive(Show, Eq)

pub fn init(
  flags : @raw.SDL_InitFlags,
) -> Unit raise SysError

pub fn init_subsystem(
  flags : @raw.SDL_InitFlags,
) -> Unit raise SysError

pub fn quit_subsystem(
  flags : @raw.SDL_InitFlags,
) -> Unit

pub fn quit_all() -> Unit

pub fn initialized_flags() -> @raw.SDL_InitFlags

pub fn is_initialized(
  flags : @raw.SDL_InitFlags,
) -> Bool

pub fn set_app_metadata(
  name~ : String,
  version~ : String,
  identifier~ : String = "",
) -> Unit raise SysError

pub fn set_app_metadata_property(
  name : String,
  value : String,
) -> Unit raise SysError

pub fn compiled_version() -> SysVersion

pub fn linked_version() -> SysVersion

pub fn is_main_thread() -> Bool
```

说明：

- 第一版直接复用 `@raw.SDL_InitFlags`，不再新增 `SysInitFlags` 同义类型。
- `initialized_flags()` 与 `is_initialized(...)` 两个接口都保留：
  - 前者提供低层完整查询
  - 后者提供更直接的调用点判断
- `set_app_metadata(...)` 与 `set_app_metadata_property(...)` 都保留：
  - 前者是设置应用基础元数据的便捷入口
  - 后者是设置单条 metadata property 的通用入口
- 当前不建议在 `sys/runtime.mbt` 中引入 `SysAppMetadata` 结构体。
- `SysVersion` 第一版保留，以显式区分编译期头文件版本和运行时链接库版本。
- 第一版纳入 `is_main_thread()`，但暂不纳入 `run_on_main_thread(...)`。
- `sys/runtime.mbt` 当前应保持为函数式浅层接口，不在模块内部持有额外状态。

### `sys/events.mbt`

职责：

- 承接 event buffer、poll/wait/drain 的低层整理
- 承接 event union 的低层解释入口
- 服务未来稳定的 `events` 包

适合放入：

- 事件对象缓冲分配
- 事件类型读取与底层解码入口
- 从 `raw` 迁出的明显越界 helper

候选迁移目标：

- `new_sdl_event`
- `unsafe_from_sdl_event`

说明：

- 是否最终把这些 helper 从 `raw` 实体迁走，需要按实现细节再定。
- 但语义归属应先视为 `sys/events`。

### `sys/video.mbt`

职责：

- 在 `raw/video` 上做窗口与 display 相关的浅层整理
- 服务未来稳定的 `video` 包

适合放入：

- 创建窗口时的低层错误提升
- 多 out 参数窗口查询整理
- display / window 查询的浅层结果整理

### `sys/render.mbt`

职责：

- 在 `raw/render` 上做 renderer / texture 相关的浅层整理
- 服务未来稳定的 `render2d` 包

适合放入：

- renderer 创建与查询的低层整理
- texture 查询和常见组合
- read pixels 一类常见路径的浅层适配

### `sys/surface.mbt`

职责：

- 在 `raw/surface` 上做 `SDL_Surface` 的低层整理
- 服务未来稳定的 `surface` 包，并作为 `image` / `ttf` 的桥接底座

适合放入：

- surface 生命周期相关的浅层帮助函数
- 锁定/解锁和像素访问的浅层整理
- 与图像、字体栅格化相关的桥接入口

## 第二批模块草案

这些文件不必现在就建立，等稳定包建设推进到对应阶段时再补：

- `sys/input.mbt`
- `sys/image.mbt`
- `sys/ttf.mbt`

## 当前不建议建立的模块

### `sys/utils.mbt`

- 风险过大，极易演变成无边界堆积。

### `sys/common.mbt`

- 语义过泛，后续很容易让所有东西都往里面塞。

### `sys/resource.mbt`

- 目前时机还早。Window、Canvas、Texture、Surface、Font 的资源模型尚未完全定型。

### `sys/string.mbt`

- 当前很多最低层字符串 glue 仍自然属于 `raw` 的绑定基础设施。
- 不建议为了“层次纯化”过早拆走。

## 当前推荐建设顺序

1. `sys/error.mbt`
2. `sys/result_shape.mbt`
3. `sys/runtime.mbt`
4. `sys/events.mbt`
5. `sys/video.mbt`
6. `sys/render.mbt`
7. `sys/surface.mbt`

## 与 `raw` 的迁移关系

- 先把 `raw` 当作“可用但不完美”的低层底座。
- 不要求先对 `raw` 做一次彻底纯化。
- 优先迁出那些会直接污染 `sys` 边界的 helper。
- 后续等 `sys` 稳定后，再进行第二轮 `raw` 纯化。

## 下一轮讨论建议

建议优先细化以下两个模块中的函数形状：

1. `sys/error.mbt`
2. `sys/result_shape.mbt`

原因：

- 它们是其他 `sys` 模块的共同基础
- 如果这两个文件的接口形状不稳，后续 `sys/events`、`sys/video`、`sys/render` 都会返工

## TODO

- TODO：补充一份 `raw` 现有函数到 `sys` 目标模块的映射清单。
- TODO：视实际实现反馈，确认 `take_last_error_message()` 是否应清空 SDL last error。
- TODO：视实际使用反馈，确认 `expect_ok` / `expect_not_null` / `expect_non_negative` 的最终命名。
- TODO：视实际实现反馈，确认 `read_count` / `check_count` 的最终命名是否稳定。
