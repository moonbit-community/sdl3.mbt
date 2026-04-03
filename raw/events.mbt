/// Simple DirectMedia Layer
/// Copyright (C) 1997-2025 Sam Lantinga <slouken@libsdl.org>
/// 
/// This software is provided 'as-is', without any express or implied
/// warranty.  In no event will the authors be held liable for any damages
/// arising from the use of this software.
/// 
/// Permission is granted to anyone to use this software for any purpose,
/// including commercial applications, and to alter it and redistribute it
/// freely, subject to the following restrictions:
/// 
/// 1. The origin of this software must not be misrepresented; you must not
///    claim that you wrote the original software. If you use this software
///    in a product, an acknowledgment in the product documentation would be
///    appreciated but is not required.
/// 2. Altered source versions must be plainly marked as such, and must not be
///    misrepresented as being the original software.
/// 3. This notice may not be removed or altered from any source distribution.

/// # CategoryEvents
/// 
/// Event queue management.
/// 
/// It's extremely common--often required--that an app deal with SDL's event
/// queue. Almost all useful information about interactions with the real world
/// flow through here: the user interacting with the computer and app, hardware
/// coming and going, the system changing in some way, etc.
/// 
/// An app generally takes a moment, perhaps at the start of a new frame, to
/// examine any events that have occured since the last time and process or
/// ignore them. This is generally done by calling SDL_PollEvent() in a loop
/// until it returns false (or, if using the main callbacks, events are
/// provided one at a time in calls to SDL_AppEvent() before the next call to
/// SDL_AppIterate(); in this scenario, the app does not call SDL_PollEvent()
/// at all).
/// 
/// There is other forms of control, too: SDL_PeepEvents() has more
/// functionality at the cost of more complexity, and SDL_WaitEvent() can block
/// the process until something interesting happens, which might be beneficial
/// for certain types of programs on low-power hardware. One may also call
/// SDL_AddEventWatch() to set a callback when new events arrive.
/// 
/// The app is free to generate their own events, too: SDL_PushEvent allows the
/// app to put events onto the queue for later retrieval; SDL_RegisterEvents
/// can guarantee that these events have a type that isn't in use by other
/// parts of the system.

///|
/// The types of events that can be delivered.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_EventType
/// {
///     SDL_EVENT_FIRST     = 0,     /**< Unused (do not remove) */
/// 
///     /* Application events */
///     SDL_EVENT_QUIT           = 0x100, /**< User-requested quit */
/// 
///     /* ... many more events ... */
/// 
/// } SDL_EventType;
/// ```
pub(all) enum SDL_EventType {
  ///< Unused (do not remove)
  SDL_EVENT_FIRST = 0

  // Application events
  ///< User-requested quit
  ///< The application is being terminated by the OS
  ///< The application is low on memory, free memory if possible
  ///< The application is about to enter the background
  ///< The application did enter the background and may not get CPU for some time
  ///< The application is about to enter the foreground
  ///< The application is now interactive
  ///< The user's locale preferences have changed
  ///< The system theme changed
  SDL_EVENT_QUIT = 0x100
  SDL_EVENT_TERMINATING
  SDL_EVENT_LOW_MEMORY
  SDL_EVENT_WILL_ENTER_BACKGROUND
  SDL_EVENT_DID_ENTER_BACKGROUND
  SDL_EVENT_WILL_ENTER_FOREGROUND
  SDL_EVENT_DID_ENTER_FOREGROUND
  SDL_EVENT_LOCALE_CHANGED
  SDL_EVENT_SYSTEM_THEME_CHANGED

  // Display events
  ///< Display orientation has changed to data1
  ///< Display has been added to the system
  ///< Display has been removed from the system
  ///< Display has changed position
  ///< Display has changed desktop mode
  ///< Display has changed current mode
  ///< Display has changed content scale
  SDL_EVENT_DISPLAY_ORIENTATION = 0x151
  SDL_EVENT_DISPLAY_ADDED
  SDL_EVENT_DISPLAY_REMOVED
  SDL_EVENT_DISPLAY_MOVED
  SDL_EVENT_DISPLAY_DESKTOP_MODE_CHANGED
  SDL_EVENT_DISPLAY_CURRENT_MODE_CHANGED
  SDL_EVENT_DISPLAY_CONTENT_SCALE_CHANGED

  // Window events
  ///< Window has been shown
  ///< Window has been hidden
  ///< Window has been exposed and should be redrawn
  ///< Window has been moved to data1, data2
  ///< Window has been resized to data1xdata2
  ///< The pixel size of the window has changed to data1xdata2
  ///< The pixel size of a Metal view associated with the window has changed
  ///< Window has been minimized
  ///< Window has been maximized
  ///< Window has been restored to normal size and position
  ///< Window has gained mouse focus
  ///< Window has lost mouse focus
  ///< Window has gained keyboard focus
  ///< Window has lost keyboard focus
  ///< The window manager requests that the window be closed
  ///< Window had a hit test that wasn't SDL_HITTEST_NORMAL
  ///< The ICC profile of the window's display has changed
  ///< Window has been moved to display data1
  ///< Window display scale has been changed
  ///< The window safe area has been changed
  ///< The window has been occluded
  ///< The window has entered fullscreen mode
  ///< The window has left fullscreen mode
  ///< The window with the associated ID is being or has been destroyed
  ///< Window HDR properties have changed
  SDL_EVENT_WINDOW_SHOWN = 0x202
  SDL_EVENT_WINDOW_HIDDEN
  SDL_EVENT_WINDOW_EXPOSED
  SDL_EVENT_WINDOW_MOVED
  SDL_EVENT_WINDOW_RESIZED
  SDL_EVENT_WINDOW_PIXEL_SIZE_CHANGED
  SDL_EVENT_WINDOW_METAL_VIEW_RESIZED
  SDL_EVENT_WINDOW_MINIMIZED
  SDL_EVENT_WINDOW_MAXIMIZED
  SDL_EVENT_WINDOW_RESTORED
  SDL_EVENT_WINDOW_MOUSE_ENTER
  SDL_EVENT_WINDOW_MOUSE_LEAVE
  SDL_EVENT_WINDOW_FOCUS_GAINED
  SDL_EVENT_WINDOW_FOCUS_LOST
  SDL_EVENT_WINDOW_CLOSE_REQUESTED
  SDL_EVENT_WINDOW_HIT_TEST
  SDL_EVENT_WINDOW_ICCPROF_CHANGED
  SDL_EVENT_WINDOW_DISPLAY_CHANGED
  SDL_EVENT_WINDOW_DISPLAY_SCALE_CHANGED
  SDL_EVENT_WINDOW_SAFE_AREA_CHANGED
  SDL_EVENT_WINDOW_OCCLUDED
  SDL_EVENT_WINDOW_ENTER_FULLSCREEN
  SDL_EVENT_WINDOW_LEAVE_FULLSCREEN
  SDL_EVENT_WINDOW_DESTROYED
  SDL_EVENT_WINDOW_HDR_STATE_CHANGED

  // Keyboard events
  ///< Key pressed
  ///< Key released
  ///< Keyboard text editing (composition)
  ///< Keyboard text input
  ///< Keymap changed due to a system event
  ///< A new keyboard has been inserted into the system
  ///< A keyboard has been removed
  ///< Keyboard text editing candidates
  SDL_EVENT_KEY_DOWN = 0x300
  SDL_EVENT_KEY_UP
  SDL_EVENT_TEXT_EDITING
  SDL_EVENT_TEXT_INPUT
  SDL_EVENT_KEYMAP_CHANGED
  SDL_EVENT_KEYBOARD_ADDED
  SDL_EVENT_KEYBOARD_REMOVED
  SDL_EVENT_TEXT_EDITING_CANDIDATES

  // Mouse events
  ///< Mouse moved
  ///< Mouse button pressed
  ///< Mouse button released
  ///< Mouse wheel motion
  ///< A new mouse has been inserted into the system
  ///< A mouse has been removed
  SDL_EVENT_MOUSE_MOTION = 0x400
  SDL_EVENT_MOUSE_BUTTON_DOWN
  SDL_EVENT_MOUSE_BUTTON_UP
  SDL_EVENT_MOUSE_WHEEL
  SDL_EVENT_MOUSE_ADDED
  SDL_EVENT_MOUSE_REMOVED

  // Joystick events
  ///< Joystick axis motion
  ///< Joystick trackball motion
  ///< Joystick hat position change
  ///< Joystick button pressed
  ///< Joystick button released
  ///< A new joystick has been inserted into the system
  ///< An opened joystick has been removed
  ///< Joystick battery level change
  ///< Joystick update is complete
  SDL_EVENT_JOYSTICK_AXIS_MOTION = 0x600
  SDL_EVENT_JOYSTICK_BALL_MOTION
  SDL_EVENT_JOYSTICK_HAT_MOTION
  SDL_EVENT_JOYSTICK_BUTTON_DOWN
  SDL_EVENT_JOYSTICK_BUTTON_UP
  SDL_EVENT_JOYSTICK_ADDED
  SDL_EVENT_JOYSTICK_REMOVED
  SDL_EVENT_JOYSTICK_BATTERY_UPDATED
  SDL_EVENT_JOYSTICK_UPDATE_COMPLETE

  // Gamepad events
  ///< Gamepad axis motion
  ///< Gamepad button pressed
  ///< Gamepad button released
  ///< A new gamepad has been inserted into the system
  ///< A gamepad has been removed
  ///< The gamepad mapping was updated
  ///< Gamepad touchpad was touched
  ///< Gamepad touchpad finger was moved
  ///< Gamepad touchpad finger was lifted
  ///< Gamepad sensor was updated
  ///< Gamepad update is complete
  ///< Gamepad Steam handle has changed
  SDL_EVENT_GAMEPAD_AXIS_MOTION = 0x650
  SDL_EVENT_GAMEPAD_BUTTON_DOWN
  SDL_EVENT_GAMEPAD_BUTTON_UP
  SDL_EVENT_GAMEPAD_ADDED
  SDL_EVENT_GAMEPAD_REMOVED
  SDL_EVENT_GAMEPAD_REMAPPED
  SDL_EVENT_GAMEPAD_TOUCHPAD_DOWN
  SDL_EVENT_GAMEPAD_TOUCHPAD_MOTION
  SDL_EVENT_GAMEPAD_TOUCHPAD_UP
  SDL_EVENT_GAMEPAD_SENSOR_UPDATE
  SDL_EVENT_GAMEPAD_UPDATE_COMPLETE
  SDL_EVENT_GAMEPAD_STEAM_HANDLE_UPDATED

  // Touch events
  ///< Finger touched down on the touch surface
  ///< Finger lifted up from the touch surface
  ///< Finger moved along the touch surface
  ///< Finger touch canceled
  SDL_EVENT_FINGER_DOWN = 0x700
  SDL_EVENT_FINGER_UP
  SDL_EVENT_FINGER_MOTION
  SDL_EVENT_FINGER_CANCELED

  // Clipboard events
  ///< The clipboard or primary selection changed
  SDL_EVENT_CLIPBOARD_UPDATE = 0x900

  // Drag and drop events
  ///< The system requests a file open
  ///< text/plain drag-and-drop event
  ///< A new set of drops is beginning
  ///< Current set of drops is now complete
  ///< Position while moving over the window
  SDL_EVENT_DROP_FILE = 0x1000
  SDL_EVENT_DROP_TEXT
  SDL_EVENT_DROP_BEGIN
  SDL_EVENT_DROP_COMPLETE
  SDL_EVENT_DROP_POSITION

  // Audio hotplug events
  ///< A new audio device is available
  ///< An audio device has been removed
  ///< An audio device's format has been changed by the system
  SDL_EVENT_AUDIO_DEVICE_ADDED = 0x1100
  SDL_EVENT_AUDIO_DEVICE_REMOVED
  SDL_EVENT_AUDIO_DEVICE_FORMAT_CHANGED

  // Sensor events
  ///< A sensor was updated
  SDL_EVENT_SENSOR_UPDATE = 0x1200

  // Pressure-sensitive pen events
  ///< Pressure-sensitive pen has become available
  ///< Pressure-sensitive pen has become unavailable
  ///< Pressure-sensitive pen touched drawing surface
  ///< Pressure-sensitive pen stopped touching drawing surface
  ///< Pressure-sensitive pen button pressed
  ///< Pressure-sensitive pen button released
  ///< Pressure-sensitive pen is moving on the tablet
  ///< Pressure-sensitive pen angle/pressure/etc changed
  SDL_EVENT_PEN_PROXIMITY_IN = 0x1300
  SDL_EVENT_PEN_PROXIMITY_OUT
  SDL_EVENT_PEN_DOWN
  SDL_EVENT_PEN_UP
  SDL_EVENT_PEN_BUTTON_DOWN
  SDL_EVENT_PEN_BUTTON_UP
  SDL_EVENT_PEN_MOTION
  SDL_EVENT_PEN_AXIS

  // Camera hotplug events
  ///< A new camera device is available
  ///< A camera device has been removed
  ///< A camera device has been approved for use by the user
  ///< A camera device has been denied for use by the user
  SDL_EVENT_CAMERA_DEVICE_ADDED = 0x1400
  SDL_EVENT_CAMERA_DEVICE_REMOVED
  SDL_EVENT_CAMERA_DEVICE_APPROVED
  SDL_EVENT_CAMERA_DEVICE_DENIED

  // Render events
  ///< The render targets have been reset and their contents need to be updated
  ///< The device has been reset and all textures need to be recreated
  ///< The device has been lost and can't be recovered
  SDL_EVENT_RENDER_TARGETS_RESET = 0x2000
  SDL_EVENT_RENDER_DEVICE_RESET
  SDL_EVENT_RENDER_DEVICE_LOST

  // Reserved events for private platforms
  SDL_EVENT_PRIVATE0 = 0x4000
  SDL_EVENT_PRIVATE1
  SDL_EVENT_PRIVATE2
  SDL_EVENT_PRIVATE3

  // Internal events
  ///< Signals the end of an event poll cycle
  SDL_EVENT_POLL_SENTINEL = 0x7F00

  // User events
  ///< Events SDL_EVENT_USER through SDL_EVENT_LAST are for your use
  SDL_EVENT_USER = 0x8000

  // This last event is only for bounding internal arrays
  SDL_EVENT_LAST = 0xFFFF
} derive(Eq)

///|
pub fn[T] unsafe_from_sdl_event(event : SDL_Event) -> T = "%identity"

///|
/// The "quit requested" event 
///
/// @since This struct is available since SDL 3.2.0.
///
/// ```c
/// typedef struct SDL_QuitEvent
/// {
///     SDL_EventType type; /**< SDL_EVENT_QUIT */
///     Uint32 reserved;
///     Uint64 timestamp;   /**< In nanoseconds, populated using SDL_GetTicksNS() */
/// } SDL_QuitEvent;
/// ```
pub struct SDL_QuitEvent {
  /// Must be SDL_EVENT_QUIT
  event_type : SDL_EventType
  reserved : UInt
  /// In nanoseconds, populated using SDL_GetTicksNS()
  ///< In nanoseconds, populated using SDL_GetTicksNS()
  timestamp : UInt64
} derive(Eq)

///|
/// Keyboard button event structure (event.key.*)
/// 
/// The `key` is the base SDL_Keycode generated by pressing the `scancode`
/// using the current keyboard layout, applying any options specified in
/// SDL_HINT_KEYCODE_OPTIONS. You can get the SDL_Keycode corresponding to the
/// event scancode and modifiers directly from the keyboard layout, bypassing
/// SDL_HINT_KEYCODE_OPTIONS, by calling SDL_GetKeyFromScancode().
/// 
/// @since This struct is available since SDL 3.2.0.
/// 
/// @sa SDL_GetKeyFromScancode
/// @sa SDL_HINT_KEYCODE_OPTIONS
/// 
/// ```c
/// typedef struct SDL_KeyboardEvent
/// {
///     SDL_EventType type;     /**< SDL_EVENT_KEY_DOWN or SDL_EVENT_KEY_UP */
///     Uint32 reserved;
///     Uint64 timestamp;       /**< In nanoseconds, populated using SDL_GetTicksNS() */
///     SDL_WindowID windowID;  /**< The window with keyboard focus, if any */
///     SDL_KeyboardID which;   /**< The keyboard instance id, or 0 if unknown or virtual */
///     SDL_Scancode scancode;  /**< SDL physical key code */
///     SDL_Keycode key;        /**< SDL virtual key code */
///     SDL_Keymod mod;         /**< current key modifiers */
///     Uint16 raw;             /**< The platform dependent scancode for this event */
///     bool down;              /**< true if the key is pressed */
///     bool repeat;            /**< true if this is a key repeat */
/// } SDL_KeyboardEvent;
/// ```
pub struct SDL_KeyboardEvent {
  /// Must be SDL_EVENT_KEY_DOWN or SDL_EVENT_KEY_UP
  event_type : SDL_EventType
  reserved : UInt
  /// In nanoseconds, populated using SDL_GetTicksNS()
  ///< In nanoseconds, populated using SDL_GetTicksNS()
  /// The window with keyboard focus, if any
  timestamp : UInt64
  windowID : SDL_WindowID
  /// The keyboard instance id, or 0 if unknown or virtual
  which : SDL_KeyboardID
  /// SDL physical key code
  scancode : SDL_Scancode
  /// SDL virtual key code
  key : SDL_Keycode
  /// current key modifiers
  mod : SDL_Keymod
  /// The platform dependent scancode for this event
  raw : UInt16
  /// true if the key is pressed
  down : Bool
  /// true if this is a key repeat
  repeat : Bool
} derive(Eq)

///|
fn _touch_event_structs() -> Unit {
  ignore(SDL_QuitEvent::{
    event_type: SDL_EVENT_QUIT,
    reserved: 0U,
    timestamp: 0UL,
  })
  ignore(SDL_KeyboardEvent::{
    event_type: SDL_EVENT_KEY_DOWN,
    reserved: 0U,
    timestamp: 0UL,
    windowID: 0U,
    which: 0U,
    scancode: SDL_Scancode(0U),
    key: SDL_Keycode(0U),
    mod: SDL_Keymod(Int::to_uint16(0)),
    raw: Int::to_uint16(0),
    down: false,
    repeat: false,
  })
}

///|
/// SDL Event structure
/// 
/// The main SDL event structure. This is an opaque type in our binding
/// since the C structure is a union with many different event types.
/// 
/// @since This struct is available since SDL 3.2.0.
/// 
/// ```c
/// typedef union SDL_Event {
///     Uint32 type;
///     SDL_CommonEvent common;
///     // ... many different event structures ...
/// } SDL_Event;
/// ```
pub type SDL_Event

///|
pub fn SDL_Event::is_null(self : Self) -> Bool {
  is_nullptr(self)
}

///|
pub extern "C" fn new_sdl_event() -> SDL_Event = "new_sdl_event"

///|
#owned(self)
pub extern "C" fn SDL_Event::get_type(self : SDL_Event) -> SDL_EventType = "sdl_event_get_type"

///|
/// Event filter function type
/// 
/// @param userdata what was passed as `userdata` to SDL_SetEventFilter()
///                 or SDL_AddEventWatch, etc.
/// @param event the event that triggered the callback.
/// @return 1 to permit event to be added to the queue, and 0 to disallow
///         it. When used with SDL_AddEventWatch, the return value is ignored.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// @see SDL_SetEventFilter
/// @see SDL_AddEventWatch
/// 
/// ```c
/// typedef int (SDLCALL *SDL_EventFilter)(void *userdata, SDL_Event *event);
/// ```
pub type SDL_EventFilter = FuncRef[(VoidPtr, SDL_Event) -> Int]

///|
/// Pump the event loop, gathering events from the input devices.
/// 
/// This function updates the event queue and internal input device state.
/// 
/// **WARNING**: This should only be run in the thread that initialized the
/// video subsystem, and for extra safety, you should consider only doing those
/// things on the main thread in any case.
/// 
/// SDL_PumpEvents() gathers all the pending input information from devices and
/// places it in the event queue. Without calls to SDL_PumpEvents() no events
/// would ever be placed on the queue. Often the need for calls to
/// SDL_PumpEvents() is hidden from the user since SDL_PollEvent() and
/// SDL_WaitEvent() implicitly call SDL_PumpEvents(). However, if you are not
/// polling or waiting for events (e.g. you are filtering them), then you must
/// call SDL_PumpEvents() to force an event queue update.
/// 
/// @threadsafety This should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_PollEvent
/// @see SDL_WaitEvent
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_PumpEvents(void);
/// ```
pub extern "C" fn sdl_PumpEvents() = "SDL_PumpEvents"

///|
/// Check the event queue for messages and optionally return them.
/// 
/// `action` may be any of the following:
/// 
/// - `SDL_ADDEVENT`: up to `numevents` events will be added to the back of the
///   event queue.
/// - `SDL_PEEKEVENT`: `numevents` events at the front of the event queue,
///   within the specified minimum and maximum type, will be returned to the
///   caller and will _not_ be removed from the queue.
/// - `SDL_GETEVENT`: up to `numevents` events at the front of the event queue,
///   within the specified minimum and maximum type, will be returned to the
///   caller and will be removed from the queue.
/// 
/// You may have to call SDL_PumpEvents() before calling this function.
/// Otherwise, the events may not be ready to be filtered when you call
/// SDL_PeepEvents().
/// 
/// This function is thread-safe.
/// 
/// @param events destination buffer for the retrieved events, may be NULL to
///               leave the events on the queue and return the number of events
///               that would have been stored.
/// @param numevents if action is SDL_ADDEVENT, the number of events to add
///                  back to the event queue; if action is SDL_PEEKEVENT or
///                  SDL_GETEVENT, the maximum number of events to retrieve.
/// @param action action to take; see [[#action|Remarks]] for details.
/// @param minType minimum value of the event type to be considered;
///                SDL_EVENT_FIRST is a safe choice.
/// @param maxType maximum value of the event type to be considered;
///                SDL_EVENT_LAST is a safe choice.
/// @return the number of events actually stored or a negative error code on
///         failure; call SDL_GetError() for more information.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_PollEvent
/// @see SDL_PumpEvents
/// @see SDL_PushEvent
/// 
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_PeepEvents(SDL_Event *events, int numevents, SDL_EventAction action, Uint32 minType, Uint32 maxType);
/// ```
#owned(events)
pub extern "C" fn sdl_PeepEvents(
  events : FixedArray[SDL_Event],
  numevents : Int,
  action : Int,
  minType : UInt,
  maxType : UInt,
) -> Int = "SDL_PeepEvents"

///|
/// Check for the existence of a certain event type in the event queue.
/// 
/// If you need to check for a range of event types, use SDL_HasEvents()
/// instead.
/// 
/// @param type the type of event to be queried; see SDL_EventType for details.
/// @return true if events matching `type` are present, or false if events
///         matching `type` are not present.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_HasEvents
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasEvent(Uint32 type);
/// ```
pub extern "C" fn sdl_HasEvent(event_type : UInt) -> Bool = "SDL_HasEvent"

///|
/// Check for the existence of certain event types in the event queue.
/// 
/// If you need to check for a single event type, use SDL_HasEvent() instead.
/// 
/// @param minType the low end of event type to be queried, inclusive; see
///                SDL_EventType for details.
/// @param maxType the high end of event type to be queried, inclusive; see
///                SDL_EventType for details.
/// @return true if events with type >= `minType` and <= `maxType` are
///         present, or false otherwise.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_HasEvent
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasEvents(Uint32 minType, Uint32 maxType);
/// ```
pub extern "C" fn sdl_HasEvents(minType : UInt, maxType : UInt) -> Bool = "SDL_HasEvents"

///|
/// Clear events of a specific type from the event queue.
/// 
/// This will unconditionally remove any events from the queue that match
/// `type`. If you need to remove a range of event types, use SDL_FlushEvents()
/// instead.
/// 
/// It's also normal to just ignore events you don't care about in your event
/// loop without calling this function.
/// 
/// This function only affects currently queued events. If you want to make
/// sure that all pending OS events are flushed, call SDL_PumpEvents() on the
/// main thread first.
/// 
/// @param type the type of event to be cleared; see SDL_EventType for details.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_FlushEvents
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_FlushEvent(Uint32 type);
/// ```
pub extern "C" fn sdl_FlushEvent(event_type : UInt) = "SDL_FlushEvent"

///|
/// Clear events of a range of types from the event queue.
/// 
/// This will unconditionally remove any events from the queue that are in the
/// range of `minType` to `maxType`, inclusive. If you need to remove a single
/// event type, use SDL_FlushEvent() instead.
/// 
/// It's also normal to just ignore events you don't care about in your event
/// loop without calling this function.
/// 
/// This function only affects currently queued events. If you want to make
/// sure that all pending OS events are flushed, call SDL_PumpEvents() on the
/// main thread first.
/// 
/// @param minType the low end of event type to be cleared, inclusive; see
///                SDL_EventType for details.
/// @param maxType the high end of event type to be cleared, inclusive; see
///                SDL_EventType for details.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_FlushEvent
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_FlushEvents(Uint32 minType, Uint32 maxType);
/// ```
pub extern "C" fn sdl_FlushEvents(minType : UInt, maxType : UInt) = "SDL_FlushEvents"

///|
/// Poll for currently pending events.
/// 
/// If `event` is not NULL, the next event is removed from the queue and stored
/// in the SDL_Event structure pointed to by `event`. The 1 returned refers to
/// this event, immediately stored in the SDL Event structure -- not an event
/// to follow.
/// 
/// If `event` is NULL, it simply returns 1 if there is an event in the queue,
/// but will not remove it from the queue.
/// 
/// As this function may implicitly call SDL_PumpEvents(), you can only call
/// this function in the thread that set the video mode.
/// 
/// SDL_PollEvent() is the favored way of receiving system events since it can
/// be done from the main loop and does not suspend the main loop while waiting
/// on an event to be posted.
/// 
/// The common practice is to fully process the event queue once every frame,
/// usually as a first step before updating the game's state:
/// 
/// ```c
/// while (game_is_still_running) {
///     SDL_Event e;
///     while (SDL_PollEvent(&e)) {
///         // handle your event here
///     }
///     // do some game logic and rendering here
/// }
/// ```
/// 
/// @param event the SDL_Event structure to be filled with the next event from
///              the queue, or NULL.
/// @return true if this got an event or false if there are none available.
/// 
/// @threadsafety This should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_PushEvent
/// @see SDL_WaitEvent
/// @see SDL_WaitEventTimeout
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_PollEvent(SDL_Event *event);
/// ```
#owned(event)
pub extern "C" fn sdl_PollEvent(event : SDL_Event) -> Bool = "SDL_PollEvent"

///|
/// Wait indefinitely for the next available event.
/// 
/// If `event` is not NULL, the next event is removed from the queue and stored
/// in the SDL_Event structure pointed to by `event`.
/// 
/// As this function may implicitly call SDL_PumpEvents(), you can only call
/// this function in the thread that initialized the video subsystem.
/// 
/// @param event the SDL_Event structure to be filled in with the next event
///              from the queue, or NULL.
/// @return true on success or false if there was an error while waiting for
///         events; call SDL_GetError() for more information.
/// 
/// @threadsafety This should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_PollEvent
/// @see SDL_PumpEvents
/// @see SDL_WaitEventTimeout
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_WaitEvent(SDL_Event *event);
/// ```
#owned(event)
pub extern "C" fn sdl_WaitEvent(event : SDL_Event) -> Bool = "SDL_WaitEvent"

///|
/// Wait until the specified timeout (in milliseconds) for the next available
/// event.
/// 
/// If `event` is not NULL, the next event is removed from the queue and stored
/// in the SDL_Event structure pointed to by `event`.
/// 
/// As this function may implicitly call SDL_PumpEvents(), you can only call
/// this function in the thread that initialized the video subsystem.
/// 
/// The timeout is not guaranteed, the actual wait time could be longer due to
/// system scheduling.
/// 
/// @param event the SDL_Event structure to be filled in with the next event
///              from the queue, or NULL.
/// @param timeoutMS the maximum number of milliseconds to wait for the next
///                  available event.
/// @return true if this got an event or false if the timeout elapsed without
///         any events available.
/// 
/// @threadsafety This should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_PollEvent
/// @see SDL_PumpEvents
/// @see SDL_WaitEvent
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_WaitEventTimeout(SDL_Event *event, Sint32 timeoutMS);
/// ```
#owned(event)
pub extern "C" fn sdl_WaitEventTimeout(
  event : SDL_Event,
  timeoutMS : Int,
) -> Bool = "SDL_WaitEventTimeout"

///|
/// Add an event to the event queue.
/// 
/// The event queue can actually be used as a two way communication channel.
/// Not only can events be read from the queue, but the user can also push
/// their own events onto it. `event` is a pointer to the event structure you
/// wish to push onto the queue. The event is copied into the queue, and the
/// caller may dispose of the memory pointed to after SDL_PushEvent() returns.
/// 
/// Note: Pushing device input events onto the queue doesn't modify the state
/// of the device within SDL.
/// 
/// Note: Events pushed onto the queue with SDL_PushEvent() get passed through
/// the event filter but events added with SDL_PeepEvents() do not.
/// 
/// For pushing application-specific events, please use SDL_RegisterEvents() to
/// get an event type that does not conflict with other code that also wants
/// its own custom event types.
/// 
/// @param event the SDL_Event to be added to the queue.
/// @return true on success, false if the event was filtered or on failure;
///         call SDL_GetError() for more information. A common reason for error
///         is the event queue being full.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_PeepEvents
/// @see SDL_PollEvent
/// @see SDL_RegisterEvents
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_PushEvent(SDL_Event *event);
/// ```
#owned(event)
pub extern "C" fn sdl_PushEvent(event : SDL_Event) -> Bool = "SDL_PushEvent"

///|
/// Set up a filter to process all events before they change internal state
/// and are posted to the internal event queue.
/// 
/// If the filter function returns 1 when called, then the event will be added
/// to the internal queue. If it returns 0, then the event will be dropped from
/// the queue, but the internal state will still be updated. This allows
/// selective filtering of dynamically arriving events.
/// 
/// **WARNING**: Be very careful of what you do in the event filter function,
/// as it may run in a different thread!
/// 
/// On platforms that support it, if the quit event is generated by an
/// interrupt signal (e.g. pressing Ctrl-C), it will be delivered to the
/// application at the next event poll.
/// 
/// There is one caveat: if the quit event is generated by an interrupt signal,
/// it will not come through the application's event filter, because the
/// interrupt happens asynchronously.
/// 
/// Note: Disabled events never make it to the event filter function; see
/// SDL_SetEventEnabled().
/// 
/// Note: Events pushed onto the queue with SDL_PushEvent() get passed through
/// the event filter, but events pushed onto the queue with SDL_PeepEvents() do
/// not.
/// 
/// @param filter an SDL_EventFilter function to call when an event happens.
/// @param userdata a pointer that is passed to `filter`.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_AddEventWatch
/// @see SDL_SetEventEnabled
/// @see SDL_GetEventFilter
/// @see SDL_PeepEvents
/// @see SDL_PushEvent
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_SetEventFilter(SDL_EventFilter filter, void *userdata);
/// ```
pub extern "C" fn sdl_SetEventFilter(
  filter : SDL_EventFilter,
  userdata : VoidPtr,
) = "SDL_SetEventFilter"

///|
/// Query the current event filter.
/// 
/// This function can be used to "chain" filters, by saving the existing filter
/// before replacing it with a function that will call that saved filter.
/// 
/// @param filter the current callback function will be stored here.
/// @param userdata the pointer that is passed to the current event filter will
///                 be stored here.
/// @return true on success or false if there is no event filter set.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_SetEventFilter
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetEventFilter(SDL_EventFilter *filter, void **userdata);
/// ```
#owned(filter, userdata)
pub extern "C" fn sdl_GetEventFilter(
  filter : FixedArray[SDL_EventFilter],
  userdata : FixedArray[VoidPtr],
) -> Bool = "SDL_GetEventFilter"

///|
/// Add a callback to be triggered when an event is added to the event queue.
/// 
/// `filter` will be called when an event happens, and its return value is
/// ignored.
/// 
/// **WARNING**: Be very careful of what you do in the event filter function,
/// as it may run in a different thread!
/// 
/// If the quit event is generated by a signal (e.g. SIGINT), it will bypass
/// the internal queue and be delivered to the watch callback immediately, and
/// arrive at the next event poll.
/// 
/// Note: the callback is called for events posted by the user through
/// SDL_PushEvent(), but not for disabled events, nor for events by a filter
/// callback set with SDL_SetEventFilter(), nor for events posted by the user
/// through SDL_PeepEvents().
/// 
/// @param filter an SDL_EventFilter function to call when an event happens.
/// @param userdata a pointer that is passed to `filter`.
/// @return true on success or false on failure; call SDL_GetError() for more
///         information.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_RemoveEventWatch
/// @see SDL_SetEventFilter
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_AddEventWatch(SDL_EventFilter filter, void *userdata);
/// ```
pub extern "C" fn sdl_AddEventWatch(
  filter : SDL_EventFilter,
  userdata : VoidPtr,
) -> Bool = "SDL_AddEventWatch"

///|
/// Remove an event watch callback added with SDL_AddEventWatch().
/// 
/// This function takes the same input as SDL_AddEventWatch() to identify and
/// delete the corresponding callback.
/// 
/// @param filter the function originally passed to SDL_AddEventWatch().
/// @param userdata the pointer originally passed to SDL_AddEventWatch().
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_AddEventWatch
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_RemoveEventWatch(SDL_EventFilter filter, void *userdata);
/// ```
pub extern "C" fn sdl_RemoveEventWatch(
  filter : SDL_EventFilter,
  userdata : VoidPtr,
) = "SDL_RemoveEventWatch"

///|
/// Set the state of processing events by type.
/// 
/// @param type the type of event; see SDL_EventType for details.
/// @param enabled whether to process the event or not.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_EventEnabled
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_SetEventEnabled(Uint32 type, bool enabled);
/// ```
pub extern "C" fn sdl_SetEventEnabled(event_type : UInt, enabled : Bool) = "SDL_SetEventEnabled"

///|
/// Query the state of processing events by type.
/// 
/// @param type the type of event; see SDL_EventType for details.
/// @return true if the event is being processed, false otherwise.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_SetEventEnabled
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_EventEnabled(Uint32 type);
/// ```
pub extern "C" fn sdl_EventEnabled(event_type : UInt) -> Bool = "SDL_EventEnabled"

///|
/// Allocate a set of user-defined events, and return the beginning event
/// number for that set of events.
/// 
/// @param numevents the number of events to be allocated.
/// @return the beginning event number, or 0 if numevents is invalid or if
///          there are not enough user-defined events left.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_PushEvent
/// 
/// ```c
/// extern SDL_DECLSPEC Uint32 SDLCALL SDL_RegisterEvents(int numevents);
/// ```
pub extern "C" fn sdl_RegisterEvents(numevents : Int) -> UInt = "SDL_RegisterEvents"
