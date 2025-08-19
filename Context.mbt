///|
pub struct Context {
  windows : Array[Window]
}

///|
pub suberror InitializeSDLError String derive(Show)

///|
/// Create a new context.
/// This function initializes the SDL library.
/// It returns a new `Context` instance.
pub fn Context::new() -> Context raise {
  let res = @lib.sdl_Init(@lib.SDL_INIT_VIDEO)
  if !res {
    raise InitializeSDLError("Failed to initialize SDL")
  }
  Context::{ windows: [] }
}

///|
pub suberror CreateWindowError String derive(Show)

///|
/// Create a new window.
/// ## Parameters
/// - `title`: The title of the window.
/// - `width`: The width of the window.
/// - `height`: The height of the window.
///
/// It returns a new `Window` instance.
pub fn Context::createWindow(
  self : Self,
  title : String,
  width~ : Int,
  height~ : Int
) -> Window raise {
  let window = @lib.sdl_CreateWindow(title, width, height, 0UL)
  if window.is_null() {
    raise CreateWindowError("Failed to create SDL window")
  }
  let window = Window::{ base: window, renderer: None }
  self.windows.push(window)
  window
}

///|
fn Context::has_event(self : Self) -> Bool {
  ignore(self)
  let event = @lib.nullptr()
  @lib.sdl_PollEvent(event)
}

///|
/// Get all events from the event queue.
///
/// It returns an array of `Event` instances.
pub fn Context::getEvents(self : Self) -> Array[Event] {
  ignore(self)
  let events : Array[Event] = []
  while self.has_event() {
    let event = @lib.new_sdl_event()
    let _ = @lib.sdl_PollEvent(event)
    events.push(event)
  }
  events
}

///|
/// Get a timer instance.
///
/// It returns a `Timer` instance.
pub fn Context::getTimer(self : Self) -> Timer {
  ignore(self)
  Timer::{  }
}

///|
/// Quit the SDL library.
/// This function should be called before the program exits.
pub fn Context::quit(self : Self) -> Unit {
  self.windows.each(w => @lib.sdl_DestroyWindow(w.inner()))
  @lib.sdl_Quit()
}

//pub fn Context::createPoint(x: Double, y: Double) -> Point {
//  Point::{ x, y }
//}
//
//pub fn Context::createLine(start: Point, end: Point) -> Line {
//  Line::{ start, end }
//}
//
//pub fn Context::createRect(self: Self, anchor~: (Double, Double), width~: Double, height~: Double) -> Rect {
//  ignore(self)
//  let anchor = Point::{ x: anchor.0, y: anchor.1 }
//  Rect::{ anchor, width, height }
//}
//
//pub fn Context::createVertex(self: Self, pos: (Double, Double), color~: Color = Black, tex_coord~: (Double, Double) = (0, 0)) -> Vertex {
//  ignore(self)
//  Vertex::{
//    pos,
//    color,
//    tex_coord,
//  }
//}
//
//pub fn Context::createTriangle(self: Self, p1: (Double, Double), p2: (Double, Double), p3: (Double, Double), color~: Color = Black, tex_coord~: (Double, Double)=(0, 0)) -> Triangle {
//  ignore(self)
//  Triangle::{
//    v1: self.createVertex(p1, color~, tex_coord~),
//    v2: self.createVertex(p2, color~, tex_coord~),
//    v3: self.createVertex(p3, color~, tex_coord~)
//  }
//}
