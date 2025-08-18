///|
pub struct Renderer(@lib.SDL_Renderer)

///|
pub suberror SetDrawColorError String derive(Show)

///|
/// Set the draw color for the renderer.
/// ## Parameters
/// - `color`: The color to set.
/// - `alpha`: The alpha value of the color.
pub fn Renderer::setDrawColor(
  self : Renderer,
  color : Color,
  alpha~ : Int = 255
) -> Unit raise {
  let alpha = if alpha < 0 { 0 } else if alpha > 255 { 255 } else { alpha }
  let alpha = alpha.to_byte()
  let (r, g, b) = color.to_rgb()
  let res = @lib.sdl_SetRenderDrawColor(self.inner(), r, g, b, alpha)
  if !res {
    let msg = @lib.sdl_GetError()
    raise SetDrawColorError(msg)
  }
}

///|
pub suberror ClearRendererError String derive(Show)

///|
/// Clear the renderer.
pub fn Renderer::clear(self : Renderer) -> Unit raise {
  let res = @lib.sdl_RenderClear(self.inner())
  if !res {
    let msg = @lib.sdl_GetError()
    raise ClearRendererError(msg)
  }
}

///|
pub suberror RenderPresentError String derive(Show)

///|
/// Present the renderer.
pub fn Renderer::present(self : Renderer) -> Unit raise {
  let res = @lib.sdl_RenderPresent(self.inner())
  if !res {
    let msg = @lib.sdl_GetError()
    raise RenderPresentError(msg)
  }
}
