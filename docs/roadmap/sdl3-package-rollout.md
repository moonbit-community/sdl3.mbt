# SDL3 包推进路线

## 文档状态

- 状态：草案
- 负责人：TODO
- 最后更新：TODO

## 目的

- 把架构方案转化成实际可执行的推进顺序。
- 给贡献者和 AI 工程师一条按包拆分的工作队列。
- 避免把无关重构混进一次过大的迁移。

## 关联文档

- 架构主文档：`docs/architecture/sdl3-abstraction-plan.md`
- `sys` 层模块草案：`docs/architecture/sys-layer-plan.md`
- 未决问题列表：`docs/roadmap/sdl3-open-questions.md`

## 推进原则

- 优先按包推进，而不是一次性全仓迁移。
- 先冻结设计，再推进实现。
- 不要让一次“总改名”或“总迁移”阻塞所有其他工作。
- 推进过程中，尽量保持仓库仍然可运行、可验证。

## 阶段总览

1. 文档与现状盘点
2. 共用基础层
3. 运行时与窗口系统
4. 输入与事件系统
5. Surface 与 2D 渲染
6. 卫星库接入
7. 根包 facade 清理与迁移

## 第 0 阶段：文档与现状盘点

### 目标

- 冻结一版架构草案。
- 盘点当前 `raw/` 的 FFI 覆盖情况。
- 列出主要未决设计问题。

### 交付物

- `docs/architecture/` 下的架构草案
- `docs/roadmap/` 下的推进路线
- `docs/roadmap/` 下的开放问题清单

### 退出条件

- 新增一个 API 时，贡献者能判断它属于哪个目标包。
- 贡献者能分清一个任务是在做 `raw`、`sys` 还是稳定包。

## 第 1 阶段：共用基础层

### 目标包

- `base`
- `sys`
- `runtime`
- `time`

### 目标

- 先建立共享值类型、生命周期规则和统一错误处理。
- 停止继续把新的大型抽象堆进根目录或 `Context` 风格对象。

### 建议工作项

- 定义 `SdlError`
- 定义 `InitSpec`
- 定义共享几何与颜色值类型
- 定义 duration / timestamp 值类型
- 建立第一批 `sys` 模块：
  - `sys/error.mbt`
  - `sys/out.mbt`
  - `sys/runtime.mbt`
  - `sys/events.mbt`
  - `sys/video.mbt`
  - `sys/render.mbt`
  - `sys/surface.mbt`
- 明确 `sys` 采用平铺文件结构，不新增子目录
- 只做一轮最小必要的 `raw` 边界清理，不等待 `raw` 全面纯化后再开始 `sys`

### 退出条件

- 新的稳定代码可以不依赖裸 tuple 和临时错误包装。
- 第一批稳定包的底层依赖不必直接面向 `raw` 写重复整理逻辑。

## 第 2 阶段：运行时与窗口系统

### 目标包

- `video`

### 目标

- 在独立包中建立 `Window` 和 display 的所有权模型。
- 摆脱把根目录 `Context` 当作长期主入口的设计。

### 建议工作项

- `WindowSpec`
- display 枚举
- window 生命周期规则
- fullscreen / resizable / position 的建模

### 退出条件

- Window 的创建与销毁明确归属 `video`。
- 新的公开 API 默认不再沿用当前根目录的 window 持有方式。

## 第 3 阶段：输入与事件系统

### 目标包

- `input`
- `events`

### 目标

- 用 typed event 解码替换“事件类型判断 + 手工 unsafe cast”。
- 定义可复用的键盘、鼠标、手柄枚举与 ID 类型。

### 建议工作项

- `Key` 与 `Scancode` 抽象
- 鼠标按钮与移动值对象
- `EventPump`
- typed `Event` ADT
- `poll` / `wait` / `drain`

### 退出条件

- 示例代码可以在不 import `@raw` 的情况下处理退出与键盘事件。

## 第 4 阶段：Surface 与 2D 渲染

### 目标包

- `surface`
- `render2d`

### 目标

- 为 `Surface`、`Canvas`、`Texture` 建立明确的资源所有权模型。
- 用更可扩展的 2D 绘制设计替换当前 renderer 风格抽象。

### 建议工作项

- `Surface` 生命周期
- `Canvas` 生命周期
- `Texture` 创建路径
- `Paint` 模型
- 几何图元绘制
- 截图/导出整合点

### 退出条件

- 基本绘图 demo 不再依赖当前根目录 renderer 的状态性 hack。
- `render2d` 成为稳定公开 2D 渲染 API 的拥有者。

## 第 5 阶段：卫星库接入

### 目标包

- `image`
- `ttf`
- `experimental`

### 目标

- 通过稳定的边界接入 SDL_image 和 SDL_ttf。
- 把不成熟子系统隔离在 `experimental` 中。

### 建议工作项

- 基于 `Surface` 的 image load/save
- 基于 `Surface` 的 font load/measure/render
- 将未成熟能力移入 `experimental`

### 退出条件

- SDL_image 和 SDL_ttf 能接入稳定包体系，同时不把低层细节泄漏到无关包中。

## 第 6 阶段：根包 facade 清理与迁移

### 目标区域

- 根包导出
- 示例
- 弃用兼容层

### 目标

- 把根目录逐步收敛为有意设计的 facade。
- 逐步收缩或包装旧的根级 API。

### 建议工作项

- 根包 re-export 策略
- deprecated 标记
- 迁移示例
- 实验目录整理

### 退出条件

- 根包主要承担 facade 角色，而不是继续承载大量实现。

## 每个包开始动手前的检查清单

- 从架构文档确认该任务的所属包。
- 确认任务是在做 `raw`、`sys`，还是稳定包。
- 先列出候选公开类型，再写实现。
- 先明确资源拥有者与 destroy 路径。
- 先判断这次修改是否会影响 `.mbti`。
- 先列出需要补的测试和示例。

## 每个 PR 的检查清单

- 范围限制在一个阶段或一个连贯切片内。
- 新增公开 API 与目标包边界一致。
- 稳定层没有无意义地暴露 `@raw` 类型。
- 如果设计假设变化，相关文档或 TODO 已同步更新。
- 在任务末尾运行 `moon info`、`moon fmt` 以及相关测试/检查。

## 风险

- 如果过早做大范围目录迁移，可能把真正的 API 设计问题淹没掉。
- 容易把“raw 绑定正确性”和“稳定抽象质量”混为一谈。
- 示例代码可能静默依赖低层 API，而稳定包尚未正式暴露这些能力。

## 跟踪项

- TODO：补充各目标包负责人。
- TODO：实现开始后补充阶段进度表。
- TODO：补充与具体 issue 或任务的关联。
