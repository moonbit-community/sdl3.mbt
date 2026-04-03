///|
fn draw_demo(renderer : @sdl3.Renderer) -> Unit raise {
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
}

///|
fn main_err() -> Unit raise {
  let output = "/tmp/sdl3-main2-frame.png"
  let ctx = @sdl3.Context::new()
  let window = ctx.createWindow("single frame export", width=800, height=600)
  let renderer = window.createRenderer()
  draw_demo(renderer)
  renderer.savePNG(output)
  renderer.present()
  println("saved frame to \{output}")
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
