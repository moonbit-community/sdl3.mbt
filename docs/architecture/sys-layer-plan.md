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

适合放入：

- 最基础的低层错误类型
- `check_bool` / `check_ptr` 之类的检查函数
- 统一抓取 SDL last error 的薄层逻辑

不适合放入：

- 领域专用错误类型
- 面向最终用户的文案包装

### `sys/out.mbt`

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

### `sys/runtime.mbt`

职责：

- 在 `raw/init` 和相关基础 API 上做运行时级浅层适配
- 服务未来的稳定 `runtime` 包

适合放入：

- init / quit 的低层整理
- metadata / version 的浅层入口
- runtime 级 capability 检查

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
2. `sys/out.mbt`
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
2. `sys/out.mbt`

原因：

- 它们是其他 `sys` 模块的共同基础
- 如果这两个文件的接口形状不稳，后续 `sys/events`、`sys/video`、`sys/render` 都会返工

## TODO

- TODO：补充一份 `raw` 现有函数到 `sys` 目标模块的映射清单。
- TODO：明确 `sys/error.mbt` 的错误类型和检查函数命名。
- TODO：明确 `sys/out.mbt` 对单值、多值、数组类 out 参数的统一形状。
