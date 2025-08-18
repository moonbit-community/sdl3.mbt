///|
pub struct Window(@lib.SDL_Window)

///|
pub fn Window::createRenderer(self : Window) -> Renderer raise {
  let renderer = @lib.sdl_CreateRenderer(self.inner(), "")
  if renderer.is_null() {
    raise CreateWindowError("Failed to create SDL renderer")
  }
  renderer
}

///|
pub fn Window::getRenderer(self : Window) -> Renderer? {
  let renderer = @lib.sdl_GetRenderer(self.inner())
  if renderer.is_null() {
    return None
  }
  Some(renderer)
}
