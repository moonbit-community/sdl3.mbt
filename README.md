# SDL3 MoonBit Binding

## ⚠️ 开发中项目警告

**此项目仍在积极开发中，API 可能会发生重大变化。不建议在生产环境中使用。**

## 项目简介

这是一个为 [SDL3](https://www.libsdl.org/) 图形库提供的 MoonBit 语言绑定，允许开发者在 MoonBit 中使用 SDL3 的各种功能，包括窗口管理、渲染、事件处理等。

### 示例代码

以下是一个简单的示例，创建一个黑色窗口并绘制一些基本图形：

```moonbit
fn main {
  match (try? main_err()) {
    Ok(_) => ()
    Err(e) => println(e)
  }
}

fn main_err() -> Unit raise {
  let ctx = @sdl3.Context::new()
  let window = ctx.createWindow("Simple Black Window", width=800, height=600)
  let renderer = window.createRenderer()
  let timer = ctx.getTimer()
  
  let mut quit = false
  while !quit {
    let events = ctx.getEvents()
    if events.iter().any(e => e.getType() is Quit) {
      quit = true
    }
    
    // 清除屏幕为白色
    renderer.setDrawColor(White)
    renderer.clear()
    
    // 绘制黑色点和线
    renderer.setDrawColor(Black)
    renderer.point(400, 300)
    renderer.line((100, 100), (700, 500))
    
    // 绘制红色矩形
    renderer.setDrawColor(Red)
    let rect = ctx.createRect(anchor=(200, 200), width=300, height=300)
    renderer.drawRect(rect)
    
    renderer.present()
    timer.delay(16)
  }
  
  ctx.quit()
}
```

## 许可证

本项目采用 Apache-2.0 许可证。
