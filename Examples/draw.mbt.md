
```mbt
test "Draw A Point" {
  let ctx = @sdl3.Context::new()
  let window = ctx.createWindow("simple black window", width=800, height=600)
  let renderer = window.createRenderer()
  let timer = ctx.getTimer()
  println("window and renderer created successfully")
  let mut quit = false
  while !quit {
    let events = ctx.getEvents()
    if events.iter().any(e => e.getType() is Quit) {
      quit = true
    }
    renderer.setDrawColor(White)
    renderer.clear()
    renderer.drawPoint(400, 300, color=Black)
    renderer.present()
    timer.delay(16)
  }
  println("loop finished, cleaning up resources...")
  ctx.quit()
}
```

## Draw Line and Lines

```mbt
test "Draw A Point" {
  let ctx = @sdl3.Context::new()
  let window = ctx.createWindow("simple black window", width=800, height=600)
  let renderer = window.createRenderer()
  let timer = ctx.getTimer()
  println("window and renderer created successfully")
  let mut quit = false
  while !quit {
    let events = ctx.getEvents()
    if events.iter().any(e => e.getType() is Quit) {
      quit = true
    }
    renderer.setDrawColor(White)
    renderer.clear()
    renderer.setDrawColor(Red)
    renderer.drawPoint(400, 300, color=Black)
    renderer.drawLine((100, 100), (700, 500))
    renderer.drawLines([
      (100, 100), (100, 500), (500, 500), (500, 100), (100, 100)
    ])
    renderer.setDrawColor(Lime)
    renderer.drawRect((200, 200), 300, 300, fill=true)
    renderer.drawTriangle(
      (400, 100), (300, 500), (500, 500), color=Yellow, fill=true
    )
    renderer.present()
    timer.delay(16)
  }
  println("loop finished, cleaning up resources...")
  ctx.quit()
}
```

## Draw Line and Lines

```mbt
test "Draw A Point" {
  let ctx = @sdl3.Context::new()
  let window = ctx.createWindow("simple black window", width=800, height=600)
  let renderer = window.createRenderer()
  let timer = ctx.getTimer()
  println("window and renderer created successfully")
  let mut quit = false
  while !quit {
    let events = ctx.getEvents()
    if events.iter().any(e => e.getType() is Quit) {
      quit = true
    }
    renderer.setDrawColor(White)
    renderer.clear()
    renderer.setDrawColor(Red)
    renderer.drawPoint(400, 300, color=Black)
    renderer.drawLine((100, 100), (700, 500))
    renderer.drawLines([
      (100, 100), (100, 500), (500, 500), (500, 100), (100, 100)
    ])
    renderer.setDrawColor(Lime)
    renderer.drawRect((200, 200), 300, 300, fill=true)
    renderer.drawTriangle(
      (400, 100), (300, 500), (500, 500), color=Yellow, fill=true
    )
    renderer.present()
    timer.delay(16)
  }
  println("loop finished, cleaning up resources...")
  ctx.quit()
}
```
