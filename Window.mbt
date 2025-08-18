///|
pub struct Window(@lib.SDL_Window)

///|
/// Create a new renderer for the window.
///
/// It returns a new `Renderer` instance.
pub fn Window::createRenderer(self : Window) -> Renderer raise {
  let renderer = @lib.sdl_CreateRenderer(self.inner(), "")
  if renderer.is_null() {
    raise CreateWindowError("Failed to create SDL renderer")
  }
  renderer
}

///|
/// Get the renderer for the window.
///
/// It returns a `Renderer` instance if it exists, otherwise `None`.
pub fn Window::getRenderer(self : Window) -> Renderer? {
  let renderer = @lib.sdl_GetRenderer(self.inner())
  if renderer.is_null() {
    return None
  }
  Some(renderer)
}
