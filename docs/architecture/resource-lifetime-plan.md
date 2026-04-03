# 资源生命周期策略草案

## 文档状态

- 状态：草案
- 负责人：TODO
- 最后更新：TODO

## 目的

- 明确稳定层 SDL 资源的释放策略。
- 明确显式 `close()` 与 finalizer 的角色分工。
- 为 `Window`、`Canvas`、`Texture`、`Surface`、`Font` 等资源建立统一的生命周期语言。

## 当前已决定的总体策略

- 稳定层资源释放以显式 `close()` 为主。
- 允许 finalizer 作为兜底机制。
- 绝不把 finalizer 作为主要释放模型。
- 所有拥有型资源统一提供 `is_closed()`。

换句话说：

- 资源的正常使用路径必须依赖显式关闭。
- finalizer 只是在调用方忘记关闭时尽量做 best-effort cleanup。
- API 文档不能把 finalizer 描述成“稳定、确定、推荐的释放方式”。

## 资源类型上的倾向

当前建议对以下资源都提供显式 `close()`：

- `Window`
- `Canvas`
- `Texture`
- `Surface`
- `Font`

其中，UI / 渲染相关资源应更强烈要求显式关闭：

- `Window`
- `Canvas`
- `Texture`

原因：

- 这些资源更可能涉及父子依赖和平台/线程约束
- 释放不及时的成本更高

## 当前建议的统一规则

1. 所有拥有型资源统一提供显式 `close()`。
2. 所有拥有型资源统一提供 `is_closed()`。
3. `close()` 必须幂等。
4. 关闭后，只有 `close()` 与 `is_closed()` 这类生命周期方法继续保证可用。
5. 其他依赖底层 native handle 的方法，在对象关闭后应抛统一的“资源已关闭”生命周期错误，而不是 silent no-op。
6. 不建议在关闭后保留零散 getter 的可用性；第一版除生命周期方法外，一律视为不可再用。
7. finalizer 如果存在，必须与 `close()` 共用底层释放逻辑。
8. 文档必须明确说明：finalizer 只作兜底，不保证时机、顺序、线程。
9. 资源拥有关系和关闭顺序不能建立在“finalizer 会自动帮忙收尾”的假设上。

## 关闭后访问的错误体系

当前建议：

- 不为每种资源分别定义独立的 closed error 类型。
- 不把“资源已关闭”伪装成普通 SDL backend error。
- 对外维持一套统一主错误体系，但在其中保留明确的生命周期错误分支。

推荐方向：

- 主错误体系仍由稳定层统一拥有，例如 `SdlError`
- 生命周期相关问题归入 `Lifecycle(...)` 分支
- “资源已关闭”是生命周期错误中的明确变体，而不是散落的独立错误类型

这样做的原因：

- 用户只需要理解一套主错误体系
- 但“后端 SDL 调用失败”和“对象生命周期已失效”不会混在一起
- 后续如果增加其他生命周期错误，也有统一归属

当前不建议：

- 为 `Window`、`Canvas`、`Texture`、`Surface`、`Font` 分别定义独立的 closed error 类型
- 用纯字符串消息承担所有生命周期语义

## 父子资源失效规则

当前建议采用“父资源关闭，子资源立即失效”的规则：

- `Texture` 依赖 `Canvas`
- `Canvas` 依赖 `Window`

因此：

- 关闭 `Window` 后，其上的 `Canvas` 与 `Texture` 都视为 closed
- 关闭 `Canvas` 后，其上的 `Texture` 都视为 closed

补充约定：

- 子资源在父资源关闭后，再调用自身的 `close()` 必须是安全幂等的 no-op。
- 文档应推荐“显式 child-first close”作为最佳实践，因为释放时机更清楚。
- 但 child-first close 不应成为 correctness 的硬前提。

## 当前仍待继续讨论的问题

- 是否需要统一的 closed-state 错误类型或生命周期错误类型。
- 是否需要为关闭后访问记录更多调试信息。

## 关联文档

- 总架构文档：`docs/architecture/sdl3-abstraction-plan.md`
- finalizer 机制说明：`docs/architecture/finalizer-implementation-notes.md`
- 开放问题列表：`docs/roadmap/sdl3-open-questions.md`
