///|
pub(all) enum Color {
  Red
  Green
  Blue
  Yellow
  Black
  White
  RGB(Int, Int, Int)
}

///|
fn Color::to_rgb(self : Color) -> (Byte, Byte, Byte) {
  match self {
    Red => (255, 0, 0)
    Green => (0, 255, 0)
    Blue => (0, 0, 255)
    Yellow => (255, 255, 0)
    Black => (0, 0, 0)
    White => (255, 255, 255)
    RGB(r, g, b) => (r.to_byte(), g.to_byte(), b.to_byte())
  }
}
