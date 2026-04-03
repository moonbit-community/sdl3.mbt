# Finalizer 实现机制说明

## 文档状态

- 状态：草案
- 负责人：TODO
- 最后更新：TODO

## 目的

- 说明本项目中“finalizer 兜底”这一策略在 MoonBit 里的实际实现约束。
- 提醒后续 AI 工程师和人类贡献者：finalizer 不是只在 MoonBit 侧写一点类型声明就能稳定完成的。
- 为后续实现 `Window`、`Canvas`、`Texture`、`Surface`、`Font` 等资源的自动兜底回收提供统一注意事项。

## 背景

MoonBit 当前对外部对象生命周期的管理，并不是一个“只靠 MoonBit 侧写少量代码就能完全解决”的问题。

在当前项目里，后续如果要为 SDL 资源加入 finalizer 兜底，通常会涉及：

- `moonbit_make_external_object(...)`
- MoonBit 抽象类型或外部对象的布局
- FFI 参数上的 `#borrow` / `#owned` 标记
- `wrap.c` 或等价 C 胶水中的持有、释放、回调逻辑
- MoonBit 编译产物中生成的 C 代码

因此，本项目必须把 finalizer 视为“需要经过实现级验证的机制”，而不是只在设计文档里口头约定。

## MoonBit 侧的关键机制摘要

### 外部对象

MoonBit 提供：

```c
void *moonbit_make_external_object(
  void (*finalize)(void *self),
  uint32_t payload_size
);
```

这个函数会创建一个由 MoonBit 运行时管理的对象，并在对象生命周期结束时调用 `finalize(self)`。

需要特别注意：

- `finalize` 只能释放对象持有的外部资源。
- `finalize` 绝对不能释放对象自身内存，这部分由 MoonBit 运行时负责。
- `moonbit_make_external_object(...)` 返回的指针，语义上是“指向 payload 的指针”，可以直接作为外部数据区域使用。

### 引用计数约定

MoonBit 当前默认采用“被调用者持有所有权”的约定。

这意味着：

- 普通 FFI 参数默认按 `#owned` 语义看待时，被调用方需要负责 `decref`
- `#borrow` 表示该参数只借用，不需要在 C 侧 `decref`
- `#owned` 表示该参数后续会被保存，并需要稍后手动管理其引用计数

这类约定在“只读参数”与“注册回调/保存闭包”场景中的行为差异很大。

## 本项目对 finalizer 的总体态度

- finalizer 只允许作为兜底清理机制。
- finalizer 绝不应作为主要资源释放模型。
- 稳定层资源仍然以显式 `close()` 为主。
- finalizer 的实现必须与显式 `close()` 共用同一套底层释放逻辑，避免双份实现逐渐漂移。

## 为什么本项目必须单独写这份文档

原因不是“finalizer 很高级”，而是它在 MoonBit 里涉及实现级细节：

- 哪些值是堆对象
- 哪些参数需要 `#borrow`
- 哪些参数需要 `#owned`
- C 胶水里什么时候 `incref`
- C 胶水里什么时候 `decref`
- 外部对象 payload 里到底存什么
- finalizer 收到的 `self` 指针到底对应哪段布局

这些问题如果只靠直觉实现，非常容易出错。

## 强制提醒：实施时必须检查 `_build` 里的生成 C 代码

这是本项目对后续实现者的硬性提醒：

- 在为 SDL 资源实现 finalizer 机制时，必须检查 `_build/` 目录下编译出来的 C 代码。
- 尤其要检查：
  - MoonBit 编译器为相关抽象类型生成的布局
  - 相关 FFI 函数的调用约定
  - `#borrow` / `#owned` 标记是否在生成代码中体现为预期的引用计数行为
  - `wrap.c` 中的持有、释放、回调和返回值处理是否与生成代码匹配

原因：

- 仅从 MoonBit 源码很难完全判断最终 C 层的引用计数行为是否正确。
- 资源泄漏、重复释放、悬垂引用这类问题，经常只能在生成 C 代码层面看清楚。

因此，后续 AI 工程师在落地 finalizer 时，不能只改 `.mbt` 和 `wrap.c`，还必须阅读 `_build/` 中对应产物。

## 本项目建议的实现检查清单

在为某个资源类型实现 finalizer 兜底时，建议至少检查以下事项：

1. 明确资源的拥有型包装类型是什么。
2. 明确 native handle 存在 payload 的哪个位置。
3. 明确显式 `close()` 与 finalizer 是否共用同一个底层释放 helper。
4. 明确释放 helper 是否幂等。
5. 明确释放 helper 在“父资源已关闭”时是否还能安全调用。
6. 明确涉及 MoonBit 对象保存时是否需要 `#owned`。
7. 明确只读参数是否可以改成 `#borrow`。
8. 检查 `_build/` 中生成的 C 代码，确认 `incref / decref` 行为符合预期。
9. 检查 finalizer 是否错误释放了对象自身。
10. 检查重复关闭、父先关子后关、子先关父后关三类路径。

## 资源释放路径建议

后续实现时，建议采用这种结构：

```text
公开 close()
  -> 内部 close_impl(...)
     -> 如果尚未关闭，释放 native resource 并标记 closed
     -> 如果已经关闭，直接返回

finalizer(self)
  -> close_impl(...)
```

说明：

- `close()` 与 finalizer 共享一套释放逻辑。
- `close_impl(...)` 必须幂等。
- finalizer 只负责 best-effort cleanup，不承担时序保证。

## 当前不建议在 finalizer 第一版里做的事

- 不建议把 finalizer 设计成主要释放路径。
- 不建议让 finalizer 依赖复杂的 MoonBit 侧对象图遍历。
- 不建议在没有检查 `_build/` 生成代码前就假设 `#borrow` / `#owned` 是正确的。
- 不建议在第一版就做过重的“自动递归关闭整棵资源树”机制。

## 关联文档

- 总架构文档：`docs/architecture/sdl3-abstraction-plan.md`
- 资源生命周期草案：`docs/architecture/resource-lifetime-plan.md`
- `sys` 层草案：`docs/architecture/sys-layer-plan.md`
