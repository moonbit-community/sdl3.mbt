///|
pub struct Window {
  base : @raw.SDL_Window
  mut renderer : Renderer?
}

///|
fn Window::inner(self : Window) -> @raw.SDL_Window {
  self.base
}

///|
/// Create a new renderer for the window.
///
/// It returns a new `Renderer` instance.
pub fn Window::createRenderer(self : Window) -> Renderer raise {
  let renderer = @raw.sdl_CreateRenderer(self.inner(), "")
  if renderer.is_null() {
    raise CreateWindowError("Failed to create SDL renderer")
  }
  let (r, g, b, a) : (Byte, Byte, Byte, Byte) = (0, 0, 0, 255)
  let renderer = Renderer::{ base: renderer, r, g, b, a }
  self.renderer = Some(renderer)
  renderer
}

///|
/// Get the renderer for the window.
///
/// It returns a `Renderer` instance if it exists, otherwise `None`.
pub fn Window::getRenderer(self : Window) -> Renderer? {
  self.renderer
}
