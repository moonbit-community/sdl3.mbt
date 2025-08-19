///|
//pub struct Renderer(@lib.SDL_Renderer)

pub struct Renderer {
  base: @lib.SDL_Renderer
  mut r: Byte
  mut g: Byte
  mut b: Byte
  mut a: Byte
}

fn Renderer::inner(self: Self) -> @lib.SDL_Renderer {
  self.base
}

pub fn Renderer::setDefaultColor(self: Self) -> Unit {
  self.r = 0
  self.g = 0
  self.b = 0
  self.a = 255
}

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
  let a = alpha.to_byte()
  let (r, g, b) = color.to_rgb()
  self.r = r
  self.g = g
  self.b = b
  self.a = a
  let res = @lib.sdl_SetRenderDrawColor(self.inner(), r, g, b, a)
  if !res {
    let msg = @lib.sdl_GetError()
    raise SetDrawColorError(msg)
  }
}

fn Renderer::setRGBA(self: Self, r: Byte, g: Byte, b: Byte, a: Byte) -> Unit {
  self.r = r
  self.g = g
  self.b = b
  self.a = a
  let _ = @lib.sdl_SetRenderDrawColor(self.inner(), r, g, b, a)
}

pub fn Renderer::setDrawAlpha(
  self : Renderer,
  alpha : Int,
) -> Unit raise SetDrawColorError {
  let alpha = if alpha < 0 { 0 } else if alpha > 255 { 255 } else { alpha }
  self.a = alpha.to_byte()
  let { r, g, b, a, .. } = self
  let res = @lib.sdl_SetRenderDrawColor(self.inner(), r, g, b, a)
  if !res {
    let msg = @lib.sdl_GetError()
    raise SetDrawColorError(msg)
  }
}

///|
pub suberror ClearRendererError String derive(Show)

pub fn Renderer::refreshBackGround(self: Self, color: Color) -> Unit raise {
  let { r, g, b, a, .. } = self
  self.setDrawColor(color)
  let res = @lib.sdl_RenderClear(self.inner())
  if !res {
    let msg = @lib.sdl_GetError()
    raise ClearRendererError(msg)
  }
  self.setRGBA(r, g, b, a)
}

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

pub fn Renderer::drawPoint(self: Self, x: Double, y: Double, color? : Color, alpha?: Int) -> Unit raise {
  let {r, g, b, a, ..} = self
  match (color, alpha) {
    (Some(c), Some(a)) => self.setDrawColor(c, alpha=a)
    (Some(c), None) => self.setDrawColor(c)
    (None, Some(a)) => self.setDrawAlpha(a)
    (None, None) => ()
  }
  match color {
    Some(c) => self.setDrawColor(c)
    None => ()
  }
  match alpha {
    Some(a) => self.setDrawAlpha(a)
    None => ()
  }
  let res = @lib.sdl_RenderPoint(self.inner(), x.to_float(), y.to_float())
  self.setRGBA(r, g, b, a)
  if !res {
    let msg = @lib.sdl_GetError()
    raise RenderRendError(msg)
  }
}

pub fn Renderer::drawPoints(
  self: Self,
  points: Array[(Double, Double)],
  color?: Color, alpha?: Int
) -> Unit raise {
  let {r, g, b, a, ..} = self
  match (color, alpha) {
    (Some(c), Some(a)) => self.setDrawColor(c, alpha=a)
    (Some(c), None) => self.setDrawColor(c)
    (None, Some(a)) => self.setDrawAlpha(a)
    (None, None) => ()
  }
  let len = points.length();
  let pts : FixedArray[Float] = FixedArray::make(len * 2, 0)
  let mut i = 0;
  for p in points {
    let (x, y) = p
    pts[i] = x.to_float()
    pts[i + 1] = y.to_float()
    i += 2;
  }
  let res = @lib.sdl_RenderPoints(self.inner(), pts, len)
  if !res {
    let msg = @lib.sdl_GetError()
    raise RenderRendError(msg)
  }
  self.setRGBA(r, g, b, a)
}

pub fn Renderer::drawLine(
  self: Self,
  start: (Double, Double),
  end: (Double, Double),
  color?: Color, alpha?: Int
) -> Unit raise {
  let {r, g, b, a, ..} = self
  match (color, alpha) {
    (Some(c), Some(a)) => self.setDrawColor(c, alpha=a)
    (Some(c), None) => self.setDrawColor(c)
    (None, Some(a)) => self.setDrawAlpha(a)
    (None, None) => ()
  }
  let (x1, y1) = start
  let (x2, y2) = end
  let res = @lib.sdl_RenderLine(
    self.inner(),
    x1.to_float(), y1.to_float(),
    x2.to_float(), y2.to_float()
  )
  self.setRGBA(r, g, b, a)
  if !res {
    let msg = @lib.sdl_GetError()
    raise RenderRendError(msg)
  }
}

pub fn Renderer::drawLines(self: Self, points: Array[(Double, Double)], color?:Color, alpha?:Int) -> Unit raise {
  let {r, g, b, a, ..} = self
  match (color, alpha) {
    (Some(c), Some(a)) => self.setDrawColor(c, alpha=a)
    (Some(c), None) => self.setDrawColor(c)
    (None, Some(a)) => self.setDrawAlpha(a)
    (None, None) => ()
  }
  let len = points.length();
  let pts : FixedArray[Float] = FixedArray::make(len * 2, 0)
  let mut i = 0;
  for p in points {
    let (x, y) = p
    pts[i] = x.to_float()
    pts[i + 1] = y.to_float()
    i += 2;
  }
  let res = @lib.sdl_RenderLines(
    self.inner(),
    pts, len
  )
  if !res {
    let msg = @lib.sdl_GetError()
    raise RenderRendError(msg)
  }
  self.setRGBA(r, g, b, a)
}

pub fn Renderer::drawRect(
  self: Self,
  anchor: (Double, Double),
  width: Double, height: Double,
  color?: Color, alpha?: Int,
  fill?: Bool = false
) -> Unit raise {
  let {r, g, b, a, ..} = self
  match (color, alpha) {
    (Some(c), Some(a)) => self.setDrawColor(c, alpha=a)
    (Some(c), None) => self.setDrawColor(c)
    (None, Some(a)) => self.setDrawAlpha(a)
    (None, None) => ()
  }
  let rect = @lib.SDL_FRect::{
    x: anchor.0.to_float(),
    y: anchor.1.to_float(),
    w: width.to_float(),
    h: height.to_float(),
  }
  let res = if fill {
    @lib.sdl_RenderFillRect(self.inner(), rect)
  } else {
    @lib.sdl_RenderRect(self.inner(), rect)
  }
  if !res {
    let msg = @lib.sdl_GetError()
    raise RenderRendError(msg)
  }
  self.setRGBA(r, g, b, a)
}

pub fn Renderer::drawRects(
  self: Self,
  rects: Array[((Double, Double), Double, Double)],
  color?: Color, alpha?: Int,
  fill~: Bool = false
) -> Unit raise {
  let {r, g, b, a, ..} = self
  match (color, alpha) {
    (Some(c), Some(a)) => self.setDrawColor(c, alpha=a)
    (Some(c), None) => self.setDrawColor(c)
    (None, Some(a)) => self.setDrawAlpha(a)
    (None, None) => ()
  }
  let len = rects.length();
  let sdl_rects: FixedArray[Float] = FixedArray::make(len * 4, 0)
  let mut i = 0;
  for r in rects {
    let ((x, y), w, h) = r
    sdl_rects[i] = x.to_float()
    sdl_rects[i + 1] = y.to_float()
    sdl_rects[i + 2] = w.to_float()
    sdl_rects[i + 3] = h.to_float()
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
  self.setRGBA(r, g, b, a)
}

pub fn Renderer::drawTriangle(
  self: Self,
  v1: (Double, Double),
  v2: (Double, Double),
  v3: (Double, Double),
  color?: Color, alpha?: Int,
  fill~: Bool = false
) -> Unit raise {
  if !fill {
    self.drawLines([v1, v2, v3, v1], color?=color)
    return
  }
  let (r, g, b) = match color {
    Some(c) => c.to_rgb()
    None => (0, 0, 0) // Default to black with full opacity
  }
  let alpha = match alpha {
    Some(a) => if a < 0 { 0 } else if a > 255 { 255 } else { a }
    None => 255 // Default to full opacity
  }
  let (tx, ty) = (0.0, 0.0) // Texture coordinates, not used here
  let (v1x, v1y) = v1
  let (v2x, v2y) = v2
  let (v3x, v3y) = v3
  let data : FixedArray[Float] = FixedArray::make(24, 0.0)
  data[0] = v1x.to_float()
  data[1] = v1y.to_float()
  data[2] = r.to_float()
  data[3] = g.to_float()
  data[4] = b.to_float()
  data[5] = alpha.to_float()
  data[6] = tx.to_float()
  data[7] = ty.to_float()

  data[8] = v2x.to_float()
  data[9] = v2y.to_float()
  data[10] = r.to_float()
  data[11] = g.to_float()
  data[12] = b.to_float()
  data[13] = alpha.to_float()
  data[14] = tx.to_float()
  data[15] = ty.to_float()

  data[16] = v3x.to_float()
  data[17] = v3y.to_float()
  data[18] = r.to_float()
  data[19] = g.to_float()
  data[20] = b.to_float()
  data[21] = alpha.to_float()
  data[22] = tx.to_float()
  data[23] = ty.to_float()

  let texture : @lib.SDL_Texture = @lib.nullptr() // No texture used
  let indices : FixedArray[Int] = @lib.nullptr()
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

pub suberror DrawGeometryError String derive(Show)

pub fn Renderer::drawGeometry(
  self: Self,
  vertexes: Array[(Double, Double)],
  color_alpha?: Array[(Color, Int)] = [],
  texture_coords?: Array[(Double, Double)] = [],
  indices?: Array[Int] = [],
) -> Unit raise {
  if vertexes.length() < 3 {
    raise DrawGeometryError("At least 3 vertexes are required to draw a geometry.")
  }
  if not(color_alpha.length() is (0 | 1)) && color_alpha.length() != vertexes.length() {
    raise DrawGeometryError("color_alpha length must be 0, 1, or equal to vertexes length.")
  }
  if not(texture_coords.length() is (0 | 1)) && texture_coords.length() != vertexes.length() {
    raise DrawGeometryError("texture_coords length must be 0, 1, or equal to vertexes length.")
  }
  if indices.length() != 0 && indices.length() != vertexes.length() {
    raise DrawGeometryError("indices length must be 0, or equal to vertexes length.")
  }

  let len_of_vertexes = vertexes.length()
  let sdl_vertexes_data : FixedArray[Float] = FixedArray::make(len_of_vertexes * 8, 0.0)
  let mut idx = 0
  for i, v in vertexes {
    let (x, y) = v
    sdl_vertexes_data[idx] = x.to_float()
    sdl_vertexes_data[idx + 1] = y.to_float()
    let (r, g, b, a) = match color_alpha {
      [] => {
        let { r, g, b, a, ..} = self
        (r.to_float(), g.to_float(), b.to_float(), a.to_float())
      }
      [c] => {
        let (color, alpha) = c
        let (r, g, b) = color.to_rgb()
        let a = if alpha < 0 { 0 } else if alpha > 255 { 255 } else { alpha }
        (r.to_float(), g.to_float(), b.to_float(), a.to_float())
      }
      _ => {
        let (color, alpha) = color_alpha[i]
        let (r, g, b) = color.to_rgb()
        let a = if alpha < 0 { 0 } else if alpha > 255 { 255 } else { alpha }
        (r.to_float(), g.to_float(), b.to_float(), a.to_float())
      }
    }
    sdl_vertexes_data[idx + 2] = r
    sdl_vertexes_data[idx + 3] = g
    sdl_vertexes_data[idx + 4] = b
    sdl_vertexes_data[idx + 5] = a
    let (tx, ty) = match texture_coords {
      [] => (0.0, 0.0)
      [c] => c
      _ => texture_coords[i]
    }
    sdl_vertexes_data[idx + 6] = tx.to_float()
    sdl_vertexes_data[idx + 7] = ty.to_float()
    idx += 8
  }

  let indices_data : FixedArray[Int] = if indices.length() == 0 {
    @lib.nullptr()
  } else {
    FixedArray::from_array(indices)
  }
  let indices_len = indices.length()
  let texture : @lib.SDL_Texture = @lib.nullptr() // No texture used

  let res = @lib.sdl_RenderGeometry(
    self.inner(),
    texture,
    sdl_vertexes_data, len_of_vertexes,
    indices_data, indices_len
  )

  if !res {
    let msg = @lib.sdl_GetError()
    raise DrawGeometryError(msg)
  }
}
