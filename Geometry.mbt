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

impl Geometry for Point with as_geometry_enum(self) {
  GeometryEnum::Point(self)
}

pub struct Line {
  start: Point;
  end: Point;
} derive(Show, Eq)

impl Geometry for Line with as_geometry_enum(self) {
  GeometryEnum::Line(self)
}

pub struct Rect {
  anchor: Point;
  width: Double;
  height: Double;
} derive(Show, Eq)

impl Geometry for Rect with as_geometry_enum(self) {
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
