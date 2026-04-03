///|
fn main_err() -> Unit raise {
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
    for event in events {
      if event.getType() is KEY_DOWN {
        let kevent : @raw.SDL_KeyboardEvent = @raw.unsafe_from_sdl_event(
          event.0,
        )
        println(kevent.key)
      }
    }
  }
  while !quit {
    check_quit()
    renderer.refreshBackGround(White)
    renderer.setDrawColor(Red)
    renderer.drawPoint(400, 300, color=Black)
    renderer.drawLine((100, 100), (700, 500))
    renderer.drawLines([
      (100, 100),
      (100, 500),
      (500, 500),
      (500, 100),
      (100, 100),
    ])
    renderer.setDrawColor(Lime)
    renderer.drawRect((200, 200), 300, 300, fill=true)
    //renderer.drawTriangle(
    //  (400, 100), (300, 500), (500, 500), color=Yellow, fill=true
    //)
    //renderer.drawCircle((400, 300), 100, color=Blue)
    //renderer.drawPolygon([
    //  (600, 100), (700, 200), (800, 100), (800, 300), (700, 400), (600, 300)
    //], color=Blue, fill=true)
    renderer.present()
    timer.delay(16)
  }
  println("loop finished, cleaning up resources...")
  ctx.quit()
}

///|
fn main {
  try main_err() catch {
    e => println(e)
  } noraise {
    _ => ()
  }
}
