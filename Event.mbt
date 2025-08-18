///|
pub struct Event(@lib.SDL_Event)

///|
pub(all) enum EventType {
  /// Normal Events
  /// User-requested quit
  Quit
  /// The application is being terminated by the OS
  Terminating
  /// The application is low on memory, free memory if possible
  LowMemory
  /// The application is about to enter the background
  WILL_ENTER_BACKGROUND
  /// The application did enter the background and may not get CPU for some time
  DID_ENTER_BACKGROUND
  /// The application is about to enter the foreground
  WILL_ENTER_FOREGROUND
  /// The application is now interactive
  DID_ENTER_FOREGROUND
  /// The user's locale preferences have changed
  LOCALE_CHANGED
  /// The system theme changed
  SYSTEM_THEME_CHANGED
  /// Display events
  /// Display orientation has changed to data1
  DISPLAY_ORIENTATION
  /// Display has been added to the system
  DISPLAY_ADDED
  /// Display has been removed from the system
  DISPLAY_REMOVED
  /// Display has changed position
  DISPLAY_MOVED
  /// Display has changed desktop mode
  DISPLAY_DESKTOP_MODE_CHANGED
  /// Display has changed current mode
  DISPLAY_CURRENT_MODE_CHANGED
  /// Display has changed content scale
  DISPLAY_CONTENT_SCALE_CHANGED
  /// Window events
  /// Window has been shown
  WINDOW_SHOWN
  /// Window has been hidden
  WINDOW_HIDDEN
  /// Window has been exposed and should be redrawn
  WINDOW_EXPOSED
  /// Window has been moved to data1, data2
  WINDOW_MOVED
  /// Window has been resized to data1xdata2
  WINDOW_RESIZED
  /// The pixel size of the window has changed to data1xdata2
  WINDOW_PIXEL_SIZE_CHANGED
  /// The pixel size of a Metal view associated with the window has changed
  WINDOW_METAL_VIEW_RESIZED
  /// Window has been minimized
  WINDOW_MINIMIZED
  /// Window has been maximized
  WINDOW_MAXIMIZED
  /// Window has been restored to normal size and position
  WINDOW_RESTORED
  /// Window has gained mouse focus
  WINDOW_MOUSE_ENTER
  /// Window has lost mouse focus
  WINDOW_MOUSE_LEAVE
  /// Window has gained keyboard focus
  WINDOW_FOCUS_GAINED
  /// Window has lost keyboard focus
  WINDOW_FOCUS_LOST
  /// The window manager requests that the window be closed
  WINDOW_CLOSE_REQUESTED
  /// Window had a hit test that wasn't SDL_HITTEST_NORMAL
  WINDOW_HIT_TEST
  /// The ICC profile of the window's display has changed
  WINDOW_ICCPROF_CHANGED
  /// Window has been moved to display data1
  WINDOW_DISPLAY_CHANGED
  /// Window display scale has been changed
  WINDOW_DISPLAY_SCALE_CHANGED
  /// The window safe area has been changed
  WINDOW_SAFE_AREA_CHANGED
  /// The window has been occluded
  WINDOW_OCCLUDED
  /// The window has entered fullscreen mode
  WINDOW_ENTER_FULLSCREEN
  /// The window has left fullscreen mode
  WINDOW_LEAVE_FULLSCREEN
  /// The window with the associated ID is being or has been destroyed
  WINDOW_DESTROYED
  /// Window HDR properties have changed
  WINDOW_HDR_STATE_CHANGED
  /// Keyboard events
  /// Key pressed
  KEY_DOWN
  /// Key released
  KEY_UP
  /// Keyboard text editing (composition)
  TEXT_EDITING
  /// Keyboard text input
  TEXT_INPUT
  /// Keymap changed due to a system event
  KEYMAP_CHANGED
  /// A new keyboard has been inserted into the system
  KEYBOARD_ADDED
  /// A keyboard has been removed
  KEYBOARD_REMOVED
  /// Keyboard text editing candidates
  TEXT_EDITING_CANDIDATES
  /// Mouse events
  /// Mouse moved
  MOUSE_MOTION
  /// Mouse button pressed
  MOUSE_BUTTON_DOWN
  /// Mouse button released
  MOUSE_BUTTON_UP
  /// Mouse wheel motion
  MOUSE_WHEEL
  /// A new mouse has been inserted into the system
  MOUSE_ADDED
  /// A mouse has been removed
  MOUSE_REMOVED
  /// Joystick events
  /// Joystick axis motion
  JOYSTICK_AXIS_MOTION
  /// Joystick trackball motion
  JOYSTICK_BALL_MOTION
  /// Joystick hat position change
  JOYSTICK_HAT_MOTION
  /// Joystick button pressed
  JOYSTICK_BUTTON_DOWN
  /// Joystick button released
  JOYSTICK_BUTTON_UP
  /// A new joystick has been inserted into the system
  JOYSTICK_ADDED
  /// An opened joystick has been removed
  JOYSTICK_REMOVED
  /// Joystick battery level change
  JOYSTICK_BATTERY_UPDATED
  /// Joystick update is complete
  JOYSTICK_UPDATE_COMPLETE
  /// Gamepad events
  /// Gamepad axis motion
  GAMEPAD_AXIS_MOTION
  /// Gamepad button pressed
  GAMEPAD_BUTTON_DOWN
  /// Gamepad button released
  GAMEPAD_BUTTON_UP
  /// A new gamepad has been inserted into the system
  GAMEPAD_ADDED
  /// A gamepad has been removed
  GAMEPAD_REMOVED
  /// The gamepad mapping was updated
  GAMEPAD_REMAPPED
  /// Gamepad touchpad was touched
  GAMEPAD_TOUCHPAD_DOWN
  /// Gamepad touchpad finger was moved
  GAMEPAD_TOUCHPAD_MOTION
  /// Gamepad touchpad finger was lifted
  GAMEPAD_TOUCHPAD_UP
  /// Gamepad sensor was updated
  GAMEPAD_SENSOR_UPDATE
  /// Gamepad update is complete
  GAMEPAD_UPDATE_COMPLETE
  /// Gamepad Steam handle has changed
  GAMEPAD_STEAM_HANDLE_UPDATED
  /// Touch events
  /// Finger touched down on the touch surface
  FINGER_DOWN
  /// Finger lifted up from the touch surface
  FINGER_UP
  /// Finger moved along the touch surface
  FINGER_MOTION
  /// Finger touch canceled
  FINGER_CANCELED
  /// Clipboard events
  /// The clipboard or primary selection changed
  CLIPBOARD_UPDATE
  /// Drag and drop events
  /// The system requests a file open
  DROP_FILE
  /// text/plain drag-and-drop event
  DROP_TEXT
  /// A new set of drops is beginning
  DROP_BEGIN
  /// Current set of drops is now complete
  DROP_COMPLETE
  /// Position while moving over the window
  DROP_POSITION
  /// Audio hotplug events
  /// A new audio device is available
  AUDIO_DEVICE_ADDED
  /// An audio device has been removed
  AUDIO_DEVICE_REMOVED
  /// An audio device's format has been changed by the system
  AUDIO_DEVICE_FORMAT_CHANGED
  /// Sensor events
  /// A sensor was updated
  SENSOR_UPDATE
  /// Pressure-sensitive pen events
  /// Pressure-sensitive pen has become available
  PEN_PROXIMITY_IN
  /// Pressure-sensitive pen has become unavailable
  PEN_PROXIMITY_OUT
  /// Pressure-sensitive pen touched drawing surface
  PEN_DOWN
  /// Pressure-sensitive pen stopped touching drawing surface
  PEN_UP
  /// Pressure-sensitive pen button pressed
  PEN_BUTTON_DOWN
  /// Pressure-sensitive pen button released
  PEN_BUTTON_UP
  /// Pressure-sensitive pen is moving on the tablet
  PEN_MOTION
  /// Pressure-sensitive pen angle/pressure/etc changed
  PEN_AXIS
  /// Camera hotplug events
  /// A new camera device is available
  CAMERA_DEVICE_ADDED
  /// A camera device has been removed
  CAMERA_DEVICE_REMOVED
  /// A camera device has been approved for use by the user
  CAMERA_DEVICE_APPROVED
  /// A camera device has been denied for use by the user
  CAMERA_DEVICE_DENIED
  /// Render events
  /// The render targets have been reset and their contents need to be updated
  RENDER_TARGETS_RESET
  /// The device has been reset and all textures need to be recreated
  RENDER_DEVICE_RESET
  /// The device has been lost and can't be recovered
  RENDER_DEVICE_LOST
  /// Reserved events for private platforms
  PRIVATE0
  PRIVATE1
  PRIVATE2
  PRIVATE3
  /// Internal events
  /// Signals the end of an event poll cycle
  POLL_SENTINEL
  /// User events
  /// Events SDL_EVENT_USER through SDL_EVENT_LAST are for your use
  USER
  InValidEventType
}

///|
pub fn Event::getType(self : Self) -> EventType {
  match self.inner().get_type() {
    SDL_EVENT_QUIT => Quit
    SDL_EVENT_TERMINATING => Terminating
    SDL_EVENT_LOW_MEMORY => LowMemory
    SDL_EVENT_WILL_ENTER_BACKGROUND => WILL_ENTER_BACKGROUND
    SDL_EVENT_DID_ENTER_BACKGROUND => DID_ENTER_BACKGROUND
    SDL_EVENT_WILL_ENTER_FOREGROUND => WILL_ENTER_FOREGROUND
    SDL_EVENT_DID_ENTER_FOREGROUND => DID_ENTER_FOREGROUND
    SDL_EVENT_LOCALE_CHANGED => LOCALE_CHANGED
    SDL_EVENT_SYSTEM_THEME_CHANGED => SYSTEM_THEME_CHANGED
    SDL_EVENT_DISPLAY_ORIENTATION => DISPLAY_ORIENTATION
    SDL_EVENT_DISPLAY_ADDED => DISPLAY_ADDED
    SDL_EVENT_DISPLAY_REMOVED => DISPLAY_REMOVED
    SDL_EVENT_DISPLAY_MOVED => DISPLAY_MOVED
    SDL_EVENT_DISPLAY_DESKTOP_MODE_CHANGED => DISPLAY_DESKTOP_MODE_CHANGED
    SDL_EVENT_DISPLAY_CURRENT_MODE_CHANGED => DISPLAY_CURRENT_MODE_CHANGED
    SDL_EVENT_DISPLAY_CONTENT_SCALE_CHANGED => DISPLAY_CONTENT_SCALE_CHANGED
    SDL_EVENT_WINDOW_SHOWN => WINDOW_SHOWN
    SDL_EVENT_WINDOW_HIDDEN => WINDOW_HIDDEN
    SDL_EVENT_WINDOW_EXPOSED => WINDOW_EXPOSED
    SDL_EVENT_WINDOW_MOVED => WINDOW_MOVED
    SDL_EVENT_WINDOW_RESIZED => WINDOW_RESIZED
    SDL_EVENT_WINDOW_PIXEL_SIZE_CHANGED => WINDOW_PIXEL_SIZE_CHANGED
    SDL_EVENT_WINDOW_METAL_VIEW_RESIZED => WINDOW_METAL_VIEW_RESIZED
    SDL_EVENT_WINDOW_MINIMIZED => WINDOW_MINIMIZED
    SDL_EVENT_WINDOW_MAXIMIZED => WINDOW_MAXIMIZED
    SDL_EVENT_WINDOW_RESTORED => WINDOW_RESTORED
    SDL_EVENT_WINDOW_MOUSE_ENTER => WINDOW_MOUSE_ENTER
    SDL_EVENT_WINDOW_MOUSE_LEAVE => WINDOW_MOUSE_LEAVE
    SDL_EVENT_WINDOW_FOCUS_GAINED => WINDOW_FOCUS_GAINED
    SDL_EVENT_WINDOW_FOCUS_LOST => WINDOW_FOCUS_LOST
    SDL_EVENT_WINDOW_CLOSE_REQUESTED => WINDOW_CLOSE_REQUESTED
    SDL_EVENT_WINDOW_HIT_TEST => WINDOW_HIT_TEST
    SDL_EVENT_WINDOW_ICCPROF_CHANGED => WINDOW_ICCPROF_CHANGED
    SDL_EVENT_WINDOW_DISPLAY_CHANGED => WINDOW_DISPLAY_CHANGED
    SDL_EVENT_WINDOW_DISPLAY_SCALE_CHANGED => WINDOW_DISPLAY_SCALE_CHANGED
    SDL_EVENT_WINDOW_SAFE_AREA_CHANGED => WINDOW_SAFE_AREA_CHANGED
    SDL_EVENT_WINDOW_OCCLUDED => WINDOW_OCCLUDED
    SDL_EVENT_WINDOW_ENTER_FULLSCREEN => WINDOW_ENTER_FULLSCREEN
    SDL_EVENT_WINDOW_LEAVE_FULLSCREEN => WINDOW_LEAVE_FULLSCREEN
    SDL_EVENT_WINDOW_DESTROYED => WINDOW_DESTROYED
    SDL_EVENT_WINDOW_HDR_STATE_CHANGED => WINDOW_HDR_STATE_CHANGED
    SDL_EVENT_KEY_DOWN => KEY_DOWN
    SDL_EVENT_KEY_UP => KEY_UP
    SDL_EVENT_TEXT_EDITING => TEXT_EDITING
    SDL_EVENT_TEXT_INPUT => TEXT_INPUT
    SDL_EVENT_KEYMAP_CHANGED => KEYMAP_CHANGED
    SDL_EVENT_KEYBOARD_ADDED => KEYBOARD_ADDED
    SDL_EVENT_KEYBOARD_REMOVED => KEYBOARD_REMOVED
    SDL_EVENT_TEXT_EDITING_CANDIDATES => TEXT_EDITING_CANDIDATES
    SDL_EVENT_MOUSE_MOTION => MOUSE_MOTION
    SDL_EVENT_MOUSE_BUTTON_DOWN => MOUSE_BUTTON_DOWN
    SDL_EVENT_MOUSE_BUTTON_UP => MOUSE_BUTTON_UP
    SDL_EVENT_MOUSE_WHEEL => MOUSE_WHEEL
    SDL_EVENT_MOUSE_ADDED => MOUSE_ADDED
    SDL_EVENT_MOUSE_REMOVED => MOUSE_REMOVED
    SDL_EVENT_JOYSTICK_AXIS_MOTION => JOYSTICK_AXIS_MOTION
    SDL_EVENT_JOYSTICK_BALL_MOTION => JOYSTICK_BALL_MOTION
    SDL_EVENT_JOYSTICK_HAT_MOTION => JOYSTICK_HAT_MOTION
    SDL_EVENT_JOYSTICK_BUTTON_DOWN => JOYSTICK_BUTTON_DOWN
    SDL_EVENT_JOYSTICK_BUTTON_UP => JOYSTICK_BUTTON_UP
    SDL_EVENT_JOYSTICK_ADDED => JOYSTICK_ADDED
    SDL_EVENT_JOYSTICK_REMOVED => JOYSTICK_REMOVED
    SDL_EVENT_JOYSTICK_BATTERY_UPDATED => JOYSTICK_BATTERY_UPDATED
    SDL_EVENT_JOYSTICK_UPDATE_COMPLETE => JOYSTICK_UPDATE_COMPLETE
    SDL_EVENT_GAMEPAD_AXIS_MOTION => GAMEPAD_AXIS_MOTION
    SDL_EVENT_GAMEPAD_BUTTON_DOWN => GAMEPAD_BUTTON_DOWN
    SDL_EVENT_GAMEPAD_BUTTON_UP => GAMEPAD_BUTTON_UP
    SDL_EVENT_GAMEPAD_ADDED => GAMEPAD_ADDED
    SDL_EVENT_GAMEPAD_REMOVED => GAMEPAD_REMOVED
    SDL_EVENT_GAMEPAD_REMAPPED => GAMEPAD_REMAPPED
    SDL_EVENT_GAMEPAD_TOUCHPAD_DOWN => GAMEPAD_TOUCHPAD_DOWN
    SDL_EVENT_GAMEPAD_TOUCHPAD_MOTION => GAMEPAD_TOUCHPAD_MOTION
    SDL_EVENT_GAMEPAD_TOUCHPAD_UP => GAMEPAD_TOUCHPAD_UP
    SDL_EVENT_GAMEPAD_SENSOR_UPDATE => GAMEPAD_SENSOR_UPDATE
    SDL_EVENT_GAMEPAD_UPDATE_COMPLETE => GAMEPAD_UPDATE_COMPLETE
    SDL_EVENT_GAMEPAD_STEAM_HANDLE_UPDATED => GAMEPAD_STEAM_HANDLE_UPDATED
    SDL_EVENT_FINGER_DOWN => FINGER_DOWN
    SDL_EVENT_FINGER_UP => FINGER_UP
    SDL_EVENT_FINGER_MOTION => FINGER_MOTION
    SDL_EVENT_FINGER_CANCELED => FINGER_CANCELED
    SDL_EVENT_CLIPBOARD_UPDATE => CLIPBOARD_UPDATE
    SDL_EVENT_DROP_FILE => DROP_FILE
    SDL_EVENT_DROP_TEXT => DROP_TEXT
    SDL_EVENT_DROP_BEGIN => DROP_BEGIN
    SDL_EVENT_DROP_COMPLETE => DROP_COMPLETE
    SDL_EVENT_DROP_POSITION => DROP_POSITION
    SDL_EVENT_AUDIO_DEVICE_ADDED => AUDIO_DEVICE_ADDED
    SDL_EVENT_AUDIO_DEVICE_REMOVED => AUDIO_DEVICE_REMOVED
    SDL_EVENT_AUDIO_DEVICE_FORMAT_CHANGED => AUDIO_DEVICE_FORMAT_CHANGED
    SDL_EVENT_SENSOR_UPDATE => SENSOR_UPDATE
    SDL_EVENT_PEN_PROXIMITY_IN => PEN_PROXIMITY_IN
    SDL_EVENT_PEN_PROXIMITY_OUT => PEN_PROXIMITY_OUT
    SDL_EVENT_PEN_DOWN => PEN_DOWN
    SDL_EVENT_PEN_UP => PEN_UP
    SDL_EVENT_PEN_BUTTON_DOWN => PEN_BUTTON_DOWN
    SDL_EVENT_PEN_BUTTON_UP => PEN_BUTTON_UP
    SDL_EVENT_PEN_MOTION => PEN_MOTION
    SDL_EVENT_PEN_AXIS => PEN_AXIS
    SDL_EVENT_CAMERA_DEVICE_ADDED => CAMERA_DEVICE_ADDED
    SDL_EVENT_CAMERA_DEVICE_REMOVED => CAMERA_DEVICE_REMOVED
    SDL_EVENT_CAMERA_DEVICE_APPROVED => CAMERA_DEVICE_APPROVED
    SDL_EVENT_CAMERA_DEVICE_DENIED => CAMERA_DEVICE_DENIED
    SDL_EVENT_RENDER_TARGETS_RESET => RENDER_TARGETS_RESET
    SDL_EVENT_RENDER_DEVICE_RESET => RENDER_DEVICE_RESET
    SDL_EVENT_RENDER_DEVICE_LOST => RENDER_DEVICE_LOST
    SDL_EVENT_PRIVATE0 => PRIVATE0
    SDL_EVENT_PRIVATE1 => PRIVATE1
    SDL_EVENT_PRIVATE2 => PRIVATE2
    SDL_EVENT_PRIVATE3 => PRIVATE3
    SDL_EVENT_POLL_SENTINEL => POLL_SENTINEL
    SDL_EVENT_USER => USER
    _ => InValidEventType
  }
}
