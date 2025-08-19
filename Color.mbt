///|
/// Color representation supporting both predefined colors and custom RGB/RGBA values
pub(all) enum Color {
  Red
  Green
  Blue
  Yellow
  Cyan
  Magenta
  Black
  White
  Gray
  LightGray
  DarkGray
  Orange
  Purple
  Pink
  Brown
  Lime
  Navy
  Maroon
  Olive
  Teal
  Silver
  Crimson
  FireBrick
  DarkRed
  LightPink
  HotPink
  DeepPink
  MediumVioletRed
  PaleVioletRed
  DarkOrange
  OrangeRed
  Tomato
  Coral
  LightSalmon
  Salmon
  DarkSalmon
  LightCoral
  Gold
  LightYellow
  LemonChiffon
  LightGoldenrodYellow
  PapayaWhip
  Moccasin
  PeachPuff
  PaleGoldenrod
  Khaki
  DarkKhaki
  LightGreen
  DarkGreen
  ForestGreen
  SeaGreen
  MediumSeaGreen
  LightSeaGreen
  DarkSeaGreen
  YellowGreen
  OliveDrab
  LawnGreen
  Chartreuse
  GreenYellow
  SpringGreen
  MediumSpringGreen
  LimeGreen
  LightBlue
  DarkBlue
  MediumBlue
  SkyBlue
  LightSkyBlue
  DeepSkyBlue
  DodgerBlue
  CornflowerBlue
  SteelBlue
  LightSteelBlue
  PowderBlue
  LightCyan
  CadetBlue
  Turquoise
  DarkTurquoise
  MediumTurquoise
  PaleTurquoise
  Aqua
  DarkCyan
  Violet
  Plum
  Thistle
  Lavender
  MediumOrchid
  MediumPurple
  BlueViolet
  DarkViolet
  DarkOrchid
  DarkMagenta
  Indigo
  SlateBlue
  DarkSlateBlue
  MediumSlateBlue
  SaddleBrown
  Sienna
  Chocolate
  Peru
  SandyBrown
  BurlyWood
  Tan
  RosyBrown
  Goldenrod
  DarkGoldenrod
  Gainsboro
  DimGray
  SlateGray
  LightSlateGray
  DarkSlateGray
  Beige
  Bisque
  BlanchedAlmond
  Cornsilk
  Ivory
  FloralWhite
  Snow
  GhostWhite
  MintCream
  Azure
  AliceBlue
  Lavenderblush
  Seashell
  Honeydew
  Transparent
  RGB(Byte, Byte, Byte)
} derive(Eq, Show)

///|
/// Convert color to RGB bytes (red, green, blue)
pub fn Color::to_rgb(self : Color) -> (Byte, Byte, Byte) {
  match self {
    Red => (255, 0, 0)
    Green => (0, 128, 0)
    Blue => (0, 0, 255)
    Yellow => (255, 255, 0)
    Cyan => (0, 255, 255)
    Magenta => (255, 0, 255)
    Black => (0, 0, 0)
    White => (255, 255, 255)
    Gray => (128, 128, 128)
    LightGray => (211, 211, 211)
    DarkGray => (169, 169, 169)
    Orange => (255, 165, 0)
    Purple => (128, 0, 128)
    Pink => (255, 192, 203)
    Brown => (165, 42, 42)
    Lime => (0, 255, 0)
    Navy => (0, 0, 128)
    Maroon => (128, 0, 0)
    Olive => (128, 128, 0)
    Teal => (0, 128, 128)
    Silver => (192, 192, 192)
    Crimson => (220, 20, 60)
    FireBrick => (178, 34, 34)
    DarkRed => (139, 0, 0)
    LightPink => (255, 182, 193)
    HotPink => (255, 105, 180)
    DeepPink => (255, 20, 147)
    MediumVioletRed => (199, 21, 133)
    PaleVioletRed => (219, 112, 147)
    DarkOrange => (255, 140, 0)
    OrangeRed => (255, 69, 0)
    Tomato => (255, 99, 71)
    Coral => (255, 127, 80)
    LightSalmon => (255, 160, 122)
    Salmon => (250, 128, 114)
    DarkSalmon => (233, 150, 122)
    LightCoral => (240, 128, 128)
    Gold => (255, 215, 0)
    LightYellow => (255, 255, 224)
    LemonChiffon => (255, 250, 205)
    LightGoldenrodYellow => (250, 250, 210)
    PapayaWhip => (255, 239, 213)
    Moccasin => (255, 228, 181)
    PeachPuff => (255, 218, 185)
    PaleGoldenrod => (238, 232, 170)
    Khaki => (240, 230, 140)
    DarkKhaki => (189, 183, 107)
    LightGreen => (144, 238, 144)
    DarkGreen => (0, 100, 0)
    ForestGreen => (34, 139, 34)
    SeaGreen => (46, 139, 87)
    MediumSeaGreen => (60, 179, 113)
    LightSeaGreen => (32, 178, 170)
    DarkSeaGreen => (143, 188, 143)
    YellowGreen => (154, 205, 50)
    OliveDrab => (107, 142, 35)
    LawnGreen => (124, 252, 0)
    Chartreuse => (127, 255, 0)
    GreenYellow => (173, 255, 47)
    SpringGreen => (0, 255, 127)
    MediumSpringGreen => (0, 250, 154)
    LimeGreen => (50, 205, 50)
    LightBlue => (173, 216, 230)
    DarkBlue => (0, 0, 139)
    MediumBlue => (0, 0, 205)
    SkyBlue => (135, 206, 235)
    LightSkyBlue => (135, 206, 250)
    DeepSkyBlue => (0, 191, 255)
    DodgerBlue => (30, 144, 255)
    CornflowerBlue => (100, 149, 237)
    SteelBlue => (70, 130, 180)
    LightSteelBlue => (176, 196, 222)
    PowderBlue => (176, 224, 230)
    LightCyan => (224, 255, 255)
    CadetBlue => (95, 158, 160)
    Turquoise => (64, 224, 208)
    DarkTurquoise => (0, 206, 209)
    MediumTurquoise => (72, 209, 204)
    PaleTurquoise => (175, 238, 238)
    Aqua => (0, 255, 255)
    DarkCyan => (0, 139, 139)
    Violet => (238, 130, 238)
    Plum => (221, 160, 221)
    Thistle => (216, 191, 216)
    Lavender => (230, 230, 250)
    MediumOrchid => (186, 85, 211)
    MediumPurple => (147, 112, 219)
    BlueViolet => (138, 43, 226)
    DarkViolet => (148, 0, 211)
    DarkOrchid => (153, 50, 204)
    DarkMagenta => (139, 0, 139)
    Indigo => (75, 0, 130)
    SlateBlue => (106, 90, 205)
    DarkSlateBlue => (72, 61, 139)
    MediumSlateBlue => (123, 104, 238)
    SaddleBrown => (139, 69, 19)
    Sienna => (160, 82, 45)
    Chocolate => (210, 105, 30)
    Peru => (205, 133, 63)
    SandyBrown => (244, 164, 96)
    BurlyWood => (222, 184, 135)
    Tan => (210, 180, 140)
    RosyBrown => (188, 143, 143)
    Goldenrod => (218, 165, 32)
    DarkGoldenrod => (184, 134, 11)
    Gainsboro => (220, 220, 220)
    DimGray => (105, 105, 105)
    SlateGray => (112, 128, 144)
    LightSlateGray => (119, 136, 153)
    DarkSlateGray => (47, 79, 79)
    Beige => (245, 245, 220)
    Bisque => (255, 228, 196)
    BlanchedAlmond => (255, 235, 205)
    Cornsilk => (255, 248, 220)
    Ivory => (255, 255, 240)
    FloralWhite => (255, 250, 240)
    Snow => (255, 250, 250)
    GhostWhite => (248, 248, 255)
    MintCream => (245, 255, 250)
    Azure => (240, 255, 255)
    AliceBlue => (240, 248, 255)
    Lavenderblush => (255, 240, 245)
    Seashell => (255, 245, 238)
    Honeydew => (240, 255, 240)
    Transparent => (0, 0, 0)
    RGB(r, g, b) => (r, g, b)
  }
}
