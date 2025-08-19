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

pub suberror DrawGeometryError String derive(Show)

pub fn Renderer::drawGeometry(
  self: Self,
  vertexes: Array[(Double, Double)],
  color_alpha?: Array[(Color, Byte)] = [],
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
  if vertexes.length() % 3 != 0 {
    raise DrawGeometryError("vertexes length must be a multiple of 3.")
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
        let (color, a) = c
        let (r, g, b) = color.to_rgb()
        (r.to_float(), g.to_float(), b.to_float(), a.to_float())
      }
      _ => {
        let (color, a) = color_alpha[i]
        let (r, g, b) = color.to_rgb()
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

//pub fn Renderer::drawTriangle(
//  self: Self,
//  v1: (Double, Double),
//  v2: (Double, Double),
//  v3: (Double, Double),
//  color?: Color, alpha?: Int,
//  fill~: Bool = false
//) -> Unit raise {
//  if !fill {
//    self.drawLines([v1, v2, v3, v1], color?=color)
//    return
//  }
//  let vertexes: Array[(Double, Double)] = Array::new()
//  vertexes..push(v1) .. push(v2) .. push(v3)
//  let color = match color {
//    Some(c) => c
//    None => Color::RGB(self.r, self.g, self.b)
//  }
//  let alpha = match alpha {
//    Some(a) => if a < 0 { 0 } else if a > 255 { 255 } else { a }
//    None => self.a.to_int()
//  }
//  let alpha = alpha.to_byte()
//  let color_alpha = [(color, alpha)]
//  self.drawGeometry(
//    vertexes,
//    color_alpha=color_alpha
//  )
//}

//// draw a circle, use drawGeometry
//pub fn Renderer::drawCircle(
//  self: Self,
//  center: (Double, Double),
//  radius: Double,
//  color?: Color, alpha?: Int, fill~: Bool = false
//) -> Unit raise {
//  let segments = match radius.to_int() {
//    _..<10 => 8 // For small circles, use fewer segments
//    10..<20 => 16 // For medium circles, use more segments
//    20..=50 => 32 // For larger circles, use even more segments
//    50..<100 => 64 // For very large circles, use the maximum segments
//    100..<200 => 128 // For extremely large circles, use even more segments
//    200..<500 => 256 // For huge circles, use a very high number of segments
//    500..<_ => 512
//  }
//  // if not fill, use draw lines
//  if !fill {
//    let angle_step = (2.0 * @math.PI) / segments.to_double()
//    let vertexes: Array[(Double, Double)] = Array::new()
//    for i in 0..<segments {
//      let angle = i.to_double() * angle_step
//      let x = center.0 + radius * @math.cos(angle)
//      let y = center.1 + radius * @math.sin(angle)
//      vertexes.push((x, y))
//    }
//    vertexes.push(vertexes[0]) // Close the circle
//    self.drawLines(vertexes, color?=color, alpha?=alpha)
//    return
//  }
//  let angle_step = (2.0 * @math.PI) / segments.to_double()
//  let vertexes: Array[(Double, Double)] = Array::new()
//  vertexes.push(center)
//  vertexes.push((center.0 + radius, center.1)) // Start point on the right side of the circle
//  vertexes.push((center.0 + radius * @math.cos(angle_step), center.1 + @math.sin(angle_step))) // Start point on the right side of the circle
//  for i in 2..<(segments + 1) {
//    let last = vertexes.last().unwrap()
//    let angle = i.to_double() * angle_step
//    let x = center.0 + radius * @math.cos(angle)
//    let y = center.1 + radius * @math.sin(angle)
//    vertexes.push(center)
//    vertexes.push(last)
//    vertexes.push((x, y))
//  }
//  let color = match color {
//    Some(c) => c
//    None => Color::RGB(self.r, self.g, self.b)
//  }
//  let alpha = match alpha {
//    Some(a) => if a < 0 { 0 } else if a > 255 { 255 } else { a }
//    None => self.a.to_int()
//  }
//  let alpha = alpha.to_byte()
//  let color_alpha = [(color, alpha)]
//
//  self.drawGeometry(vertexes, color_alpha=color_alpha)
//}
