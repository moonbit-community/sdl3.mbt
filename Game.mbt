///|
pub struct Game {
  windows : Array[Window]
}

///|
pub suberror InitializeSDLError String derive(Show)

///|
pub fn Game::new() -> Game raise {
  let res = @lib.sdl_Init(@lib.SDL_INIT_VIDEO)
  if !res {
    raise InitializeSDLError("Failed to initialize SDL")
  }
  Game::{ windows: [] }
}

///|
pub suberror CreateWindowError String derive(Show)

///|
pub fn Game::createWindow(
  self : Self,
  title : String,
  width : Int,
  height : Int
) -> Window raise {
  let window = @lib.sdl_CreateWindow(title, width, height, 0UL)
  if window.is_null() {
    raise CreateWindowError("Failed to create SDL window")
  }
  self.windows.push(window)
  window
}

///|
fn Game::has_event(self : Self) -> Bool {
  ignore(self)
  let event = @lib.nullptr()
  @lib.sdl_PollEvent(event)
}

///|
pub fn Game::getEvents(self : Self) -> Array[Event] {
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
pub fn Game::getTimer(self : Self) -> Timer {
  ignore(self)
  Timer::{  }
}

///|
pub fn Game::quit(self : Self) -> Unit {
  self.windows.each(w => @lib.sdl_DestroyWindow(w.inner()))
  @lib.sdl_Quit()
}
