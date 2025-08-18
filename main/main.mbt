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
    renderer.setDrawColor(Black)
    renderer.clear()
    renderer.present()
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
