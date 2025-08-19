///|
fn main_err() -> Unit raise {
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
    renderer.setDrawColor(Black)
    //renderer.point(400, 300)
    //renderer.line((100, 100), (700, 500))
    renderer.setDrawColor(Red)
    //renderer.lines([(100, 100), (100, 500), (500, 500), (500, 100), (100, 100)])
    //let rect = ctx.createRect(anchor=(200, 200), width=300, height=300)
    //renderer.drawRect(rect, fill=true)
    //renderer.rect(@sdl3.Rect::)
    let tri = ctx.createTriangle(
      (400, 100), (300, 500), (500, 500), color=Green
    )
    renderer.drawTriangle(tri)
    renderer.present()
    renderer.clear()
    timer.delay(16)
  }
  println("loop finished, cleaning up resources...")
  ctx.quit()
}

///|
fn main {
  match (try? main_err()) {
    Ok(_) => ()
    Err(e) => println(e)
  }
}
