
** Template **

```mbt
test {
  let ctx = @sdl3.Context::new()
  let window = ctx.createWindow("simple black window", width=800, height=600)
  let renderer = window.createRenderer()
  let timer = ctx.getTimer()
  println("window and renderer created successfully")
  let mut quit = false
  fn check_quit() {
    let events = ctx.getEvents()
    if events.iter().any(e => e.getType() is Quit) {
      quit = true
    }
  }
  while !quit {
    check_quit()
    renderer.refreshBackGround(White)
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

# How to draw

## Draw a Point

```mbt
test {
  let ctx = @sdl3.Context::new()
  let window = ctx.createWindow("simple black window", width=800, height=600)
  let renderer = window.createRenderer()
  let timer = ctx.getTimer()
  println("window and renderer created successfully")
  let mut quit = false
  fn check_quit() {
    let events = ctx.getEvents()
    if events.iter().any(e => e.getType() is Quit) {
      quit = true
    }
  }
  while !quit {
    check_quit()
    renderer.refreshBackGround(White)
    renderer.setDrawColor(Red)
    renderer.drawPoint(400, 300, color=Black)
    renderer.present()
    timer.delay(16)
  }
  println("loop finished, cleaning up resources...")
  ctx.quit()
}

```

## Draw a Line

```mbt
test {
  let ctx = @sdl3.Context::new()
  let window = ctx.createWindow("simple black window", width=800, height=600)
  let renderer = window.createRenderer()
  let timer = ctx.getTimer()
  println("window and renderer created successfully")
  let mut quit = false
  fn check_quit() {
    let events = ctx.getEvents()
    if events.iter().any(e => e.getType() is Quit) {
      quit = true
    }
  }
  while !quit {
    check_quit()
    renderer.refreshBackGround(White)
    renderer.setDrawColor(Red)
    renderer.drawLine((100, 100), (700, 500))
    renderer.present()
    timer.delay(16)
  }
  println("loop finished, cleaning up resources...")
  ctx.quit()
}
```

## Draw Mutiple lines

用`drawLines`，输入是多个点，将各个点进行连接。

```mbt
test {
  let ctx = @sdl3.Context::new()
  let window = ctx.createWindow("simple black window", width=800, height=600)
  let renderer = window.createRenderer()
  let timer = ctx.getTimer()
  println("window and renderer created successfully")
  let mut quit = false
  fn check_quit() {
    let events = ctx.getEvents()
    if events.iter().any(e => e.getType() is Quit) {
      quit = true
    }
  }
  while !quit {
    check_quit()
    renderer.refreshBackGround(White)
    renderer.setDrawColor(Red)
    renderer.drawLines([
      (100, 100), (100, 500), (500, 500), (500, 100), (100, 100)
    ])
    renderer.present()
    timer.delay(16)
  }
  println("loop finished, cleaning up resources...")
  ctx.quit()
}
```

## Draw a Rectangle

```mbt
test {
  let ctx = @sdl3.Context::new()
  let window = ctx.createWindow("simple black window", width=800, height=600)
  let renderer = window.createRenderer()
  let timer = ctx.getTimer()
  println("window and renderer created successfully")
  let mut quit = false
  fn check_quit() {
    let events = ctx.getEvents()
    if events.iter().any(e => e.getType() is Quit) {
      quit = true
    }
  }
  while !quit {
    check_quit()
    renderer.refreshBackGround(White)
    renderer.setDrawColor(Red)
    renderer.drawRect((200, 200), 300, 300, fill=true)
    renderer.present()
    timer.delay(16)
  }
  println("loop finished, cleaning up resources...")
  ctx.quit()
}
```

## Draw a Triangle

sdl提供了方便的底层绘图接口，但没有复杂的绘图功能，对于一些复杂的图形，你必须手动实现这些绘图逻辑。

```mbt
fn drawTriangle(
  renderer: @sdl3.Renderer,
  v1: (Double, Double),
  v2: (Double, Double),
  v3: (Double, Double),
  color: @sdl3.Color, alpha: Int,
  fill: Bool
) -> Unit raise {
  if !fill {
    renderer.drawLines([v1, v2, v3, v1], color=color)
    return
  }
  let vertexes: Array[(Double, Double)] = Array::new()
  vertexes..push(v1) .. push(v2) .. push(v3)
  let alpha = alpha.to_byte()
  let color_alpha = [(color, alpha)]
  renderer.drawGeometry(
    vertexes,
    color_alpha=color_alpha
  )
}

test {
  let ctx = @sdl3.Context::new()
  let window = ctx.createWindow("simple black window", width=800, height=600)
  let renderer = window.createRenderer()
  let timer = ctx.getTimer()
  println("window and renderer created successfully")
  let mut quit = false
  fn check_quit() {
    let events = ctx.getEvents()
    if events.iter().any(e => e.getType() is Quit) {
      quit = true
    }
  }
  while !quit {
    check_quit()
    renderer.refreshBackGround(White)
    renderer.setDrawColor(Red)
    drawTriangle(
      renderer, (400, 100), (300, 500), (500, 500), Yellow, 255, true
    )
    renderer.present()
    timer.delay(16)
  }
  println("loop finished, cleaning up resources...")
  ctx.quit()
}

```


## Draw a Circle

```mbt
fn drawCircle(
  renderer: @sdl3.Renderer,
  center: (Double, Double),
  radius: Double,
  color: @sdl3.Color, alpha: Int, fill: Bool
) -> Unit raise {
  let segments = match radius.to_int() {
    _..<10 => 8 // For small circles, use fewer segments
    10..<20 => 16 // For medium circles, use more segments
    20..=50 => 32 // For larger circles, use even more segments
    50..<100 => 64 // For very large circles, use the maximum segments
    100..<200 => 128 // For extremely large circles, use even more segments
    200..<500 => 256 // For huge circles, use a very high number of segments
    500..<_ => 512
  }
  // if not fill, use draw lines
  if !fill {
    let angle_step = (2.0 * @math.PI) / segments.to_double()
    let vertexes: Array[(Double, Double)] = Array::new()
    for i in 0..<segments {
      let angle = i.to_double() * angle_step
      let x = center.0 + radius * @math.cos(angle)
      let y = center.1 + radius * @math.sin(angle)
      vertexes.push((x, y))
    }
    vertexes.push(vertexes[0]) // Close the circle
    renderer.drawLines(vertexes, color=color, alpha=alpha)
    return
  }
  let angle_step = (2.0 * @math.PI) / segments.to_double()
  let vertexes: Array[(Double, Double)] = Array::new()
  vertexes.push(center)
  vertexes.push((center.0 + radius, center.1)) // Start point on the right side of the circle
  vertexes.push((center.0 + radius * @math.cos(angle_step), center.1 + @math.sin(angle_step))) // Start point on the right side of the circle
  for i in 2..<(segments + 1) {
    let last = vertexes.last().unwrap()
    let angle = i.to_double() * angle_step
    let x = center.0 + radius * @math.cos(angle)
    let y = center.1 + radius * @math.sin(angle)
    vertexes.push(center)
    vertexes.push(last)
    vertexes.push((x, y))
  }
  let alpha = alpha.to_byte()
  let color_alpha = [(color, alpha)]
  
  renderer.drawGeometry(vertexes, color_alpha=color_alpha)
}

test {
  let ctx = @sdl3.Context::new()
  let window = ctx.createWindow("simple black window", width=800, height=600)
  let renderer = window.createRenderer()
  let timer = ctx.getTimer()
  println("window and renderer created successfully")
  let mut quit = false
  fn check_quit() {
    let events = ctx.getEvents()
    if events.iter().any(e => e.getType() is Quit) {
      quit = true
    }
  }
  while !quit {
    check_quit()
    renderer.refreshBackGround(White)
    renderer.setDrawColor(Red)
    drawCircle(renderer, (400, 300), 100, Blue, 255, true)
    renderer.present()
    timer.delay(16)
  }
  println("loop finished, cleaning up resources...")
  ctx.quit()
}
```
