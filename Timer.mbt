///|
pub struct Timer {}

///|
pub fn Timer::delay(self : Self, ms : Int) -> Unit {
  ignore(self)
  let ms = if ms < 0 { 0 } else { ms }
  @lib.sdl_Delay(ms.reinterpret_as_uint())
}
