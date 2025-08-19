///|
pub struct Renderer(@lib.SDL_Renderer)

///|
pub suberror SetDrawColorError String derive(Show)

///|
/// Set the draw color for the renderer.
///
/// ## Parameters
///
/// - `color`: The color to set.
/// - `alpha`: The alpha value of the color.
pub fn Renderer::setDrawColor(
  self : Renderer,
  color : Color,
  alpha~ : Int = 255
) -> Unit raise SetDrawColorError {
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
pub fn Renderer::clear(self : Renderer) -> Unit raise ClearRendererError {
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
pub fn Renderer::present(self : Renderer) -> Unit raise RenderPresentError {
  let res = @lib.sdl_RenderPresent(self.inner())
  if !res {
    let msg = @lib.sdl_GetError()
    raise RenderPresentError(msg)
  }
}

pub suberror RenderRendError String derive(Show)

pub fn Renderer::point(self: Self, x: Double, y: Double) -> Unit raise {
  let res = @lib.sdl_RenderPoint(self.inner(), x.to_float(), y.to_float())
  if !res {
    let msg = @lib.sdl_GetError()
    raise RenderRendError(msg)
  }
}

pub fn Renderer::drawPoint(self: Self, p: Point) -> Unit raise {
  let res = @lib.sdl_RenderPoint(self.inner(), p.x.to_float(), p.y.to_float())
  if !res {
    let msg = @lib.sdl_GetError()
    raise RenderRendError(msg)
  }
}

pub fn Renderer::drawPoints(self: Self, points: Array[Point], connect?: Bool = false) -> Unit raise {
  //points.each(p => self.drawPoint(p))
  let len = points.length();
  let pts : FixedArray[Float] = FixedArray::make(len * 2, 0)
  let mut i = 0;
  for p in points {
    pts[i] = p.x.to_float()
    pts[i + 1] = p.y.to_float()
    i += 2;
  }
  let res = if connect {
    @lib.sdl_RenderLines(
      self.inner(),
      pts,
      len
    )
  } else {
    @lib.sdl_RenderPoints(
      self.inner(),
      pts,
      len
    )
  }
  if !res {
    let msg = @lib.sdl_GetError()
    raise RenderRendError(msg)
  }
}

pub fn Renderer::drawLine(self: Self, line: Line) -> Unit raise {
  let res = @lib.sdl_RenderLine(
    self.inner(),
    line.start.x.to_float(), line.start.y.to_float(),
    line.end.x.to_float(), line.end.y.to_float()
  )
  if !res {
    let msg = @lib.sdl_GetError()
    raise RenderRendError(msg)
  }
}

pub fn Renderer::lines(self: Self, lines: Array[(Double, Double)]) -> Unit raise {
  let len = lines.length();
  let pts : FixedArray[Float] = FixedArray::make(len * 2, 0)
  let mut i = 0;
  for p in lines {
    pts[i] = p.0.to_float()
    pts[i + 1] = p.1.to_float()
    i += 2;
  }
  let res = @lib.sdl_RenderLines(
    self.inner(),
    pts,
    len
  )
  if !res {
    let msg = @lib.sdl_GetError()
    raise RenderRendError(msg)
  }
}

pub fn Renderer::drawLines(self: Self, lines: Array[Line]) -> Unit raise {
  lines.each(l => self.drawLine(l))
}

pub fn Renderer::drawRect(self: Self, rect: Rect, fill?: Bool = false) -> Unit raise {
  let res = if fill {
    @lib.sdl_RenderFillRect(self.inner(), rect.to_sdl_frect())
  } else {
    @lib.sdl_RenderRect(self.inner(), rect.to_sdl_frect())
  }
  if !res {
    let msg = @lib.sdl_GetError()
    raise RenderRendError(msg)
  }
}

pub fn Renderer::drawRects(self: Self, rects: Array[Rect], fill?: Bool = false) -> Unit raise {
  let len = rects.length();
  let sdl_rects : FixedArray[Float] = FixedArray::make(len * 4, 0)
  let mut i = 0;
  for r in rects {
    sdl_rects[i] = r.anchor.x.to_float()
    sdl_rects[i + 1] = r.anchor.y.to_float()
    sdl_rects[i + 2] = r.width.to_float()
    sdl_rects[i + 3] = r.height.to_float()
    i += 4;
  }
  let res = if fill {
    @lib.sdl_RenderFillRects(self.inner(), sdl_rects, len)
  } else {
    @lib.sdl_RenderRects(self.inner(), sdl_rects, len)
  }
  if !res {
    let msg = @lib.sdl_GetError()
    raise RenderRendError(msg)
  }
}

pub fn Renderer::drawTriangle(self: Self, tri: Triangle, fill?: Bool = false) -> Unit raise {
  // if not fill, just draw three lines
  if !fill {
    let (p1, p2, p3) = (tri.v1.pos, tri.v2.pos, tri.v3.pos)
    let p1 = Point::{ x: p1.0, y: p1.1 }
    let p2 = Point::{ x: p2.0, y: p2.1 }
    let p3 = Point::{ x: p3.0, y: p3.1 }
    self.drawPoints([p1, p2, p3, p1], connect=true)
    return
  }
  let texture : @lib.SDL_Texture = @lib.nullptr()
  let indices : FixedArray[Int] = @lib.nullptr()
  let data = tri.to_float_array()
  let res = @lib.sdl_RenderGeometry(
    self.inner(),
    texture,
    data, 3, indices, 0
  )
  if !res {
    let msg = @lib.sdl_GetError()
    raise RenderRendError(msg)
  }
}

pub fn[T: Geometry] Renderer::draw(self: Self, g: T) -> Unit raise {
  match g.as_geometry_enum() {
    Point(p) => self.drawPoint(p)
    Line(l) => self.drawLine(l)
    Rect(r) => self.drawRect(r)
  }
}
