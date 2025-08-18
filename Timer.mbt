///|
pub struct Timer {}

///|
/// Delay for a certain amount of time.
/// ## Parameters
/// - `ms`: The number of milliseconds to delay.
pub fn Timer::delay(self : Self, ms : Int) -> Unit {
  ignore(self)
  let ms = if ms < 0 { 0 } else { ms }
  @lib.sdl_Delay(ms.reinterpret_as_uint())
}
