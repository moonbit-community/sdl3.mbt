priv enum GeometryEnum {
  Point(Point)
  Line(Line)
  Rect(Rect)
}

trait Geometry {
  as_geometry_enum(self: Self) -> GeometryEnum;
}

pub struct Point {
  x: Double;
  y: Double;
} derive(Show, Eq)

pub impl Geometry for Point with as_geometry_enum(self) {
  GeometryEnum::Point(self)
}

pub struct Line {
  start: Point;
  end: Point;
} derive(Show, Eq)

pub impl Geometry for Line with as_geometry_enum(self) {
  GeometryEnum::Line(self)
}

pub struct Rect {
  anchor: Point;
  width: Double;
  height: Double;
} derive(Show, Eq)

pub impl Geometry for Rect with as_geometry_enum(self) {
  GeometryEnum::Rect(self)
}

fn Rect::to_sdl_frect(self: Self) -> @lib.SDL_FRect {
  @lib.SDL_FRect::{
    x: self.anchor.x.to_float(),
    y: self.anchor.y.to_float(),
    w: self.width.to_float(),
    h: self.height.to_float(),
  };
}

pub struct Vertex {
  pos: (Double, Double);
  color: Color;
  tex_coord: (Double, Double);
} derive(Show, Eq)

pub struct Triangle {
  v1: Vertex
  v2: Vertex
  v3: Vertex
}

fn Triangle::to_float_array(self: Self) -> FixedArray[Float] {
  let arr : FixedArray[Float] = FixedArray::make(24, 0.0);
  let (r, g, b, a) = self.v1.color.to_rgba()
  arr[0] = self.v1.pos.0.to_float();
  arr[1] = self.v1.pos.1.to_float();
  arr[2] = r.to_float();
  arr[3] = g.to_float();
  arr[4] = b.to_float();
  arr[5] = a.to_float();
  arr[6] = self.v1.tex_coord.0.to_float();
  arr[7] = self.v1.tex_coord.1.to_float();

  let (r, g, b, a) = self.v2.color.to_rgba()
  arr[8] = self.v2.pos.0.to_float();
  arr[9] = self.v2.pos.1.to_float();
  arr[10] = r.to_float();
  arr[11] = g.to_float();
  arr[12] = b.to_float();
  arr[13] = a.to_float();
  arr[14] = self.v2.tex_coord.0.to_float();
  arr[15] = self.v2.tex_coord.1.to_float();

  let (r, g, b, a) = self.v3.color.to_rgba()
  arr[16] = self.v3.pos.0.to_float();
  arr[17] = self.v3.pos.1.to_float();
  arr[18] = r.to_float();
  arr[19] = g.to_float();
  arr[20] = b.to_float();
  arr[21] = a.to_float();
  arr[22] = self.v3.tex_coord.0.to_float();
  arr[23] = self.v3.tex_coord.1.to_float();

  arr
}
