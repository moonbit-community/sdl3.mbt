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

///| The types of events that can be delivered.
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
    SDL_EVENT_FIRST = 0     ///< Unused (do not remove)
    
    // Application events
    SDL_EVENT_QUIT = 0x100                   ///< User-requested quit
    SDL_EVENT_TERMINATING                    ///< The application is being terminated by the OS
    SDL_EVENT_LOW_MEMORY                     ///< The application is low on memory, free memory if possible
    SDL_EVENT_WILL_ENTER_BACKGROUND          ///< The application is about to enter the background
    SDL_EVENT_DID_ENTER_BACKGROUND           ///< The application did enter the background and may not get CPU for some time
    SDL_EVENT_WILL_ENTER_FOREGROUND          ///< The application is about to enter the foreground
    SDL_EVENT_DID_ENTER_FOREGROUND           ///< The application is now interactive
    SDL_EVENT_LOCALE_CHANGED                 ///< The user's locale preferences have changed
    SDL_EVENT_SYSTEM_THEME_CHANGED           ///< The system theme changed
    
    // Display events
    SDL_EVENT_DISPLAY_ORIENTATION = 0x151    ///< Display orientation has changed to data1
    SDL_EVENT_DISPLAY_ADDED                  ///< Display has been added to the system
    SDL_EVENT_DISPLAY_REMOVED                ///< Display has been removed from the system
    SDL_EVENT_DISPLAY_MOVED                  ///< Display has changed position
    SDL_EVENT_DISPLAY_DESKTOP_MODE_CHANGED   ///< Display has changed desktop mode
    SDL_EVENT_DISPLAY_CURRENT_MODE_CHANGED   ///< Display has changed current mode
    SDL_EVENT_DISPLAY_CONTENT_SCALE_CHANGED  ///< Display has changed content scale
    
    // Window events
    SDL_EVENT_WINDOW_SHOWN = 0x202           ///< Window has been shown
    SDL_EVENT_WINDOW_HIDDEN                  ///< Window has been hidden
    SDL_EVENT_WINDOW_EXPOSED                 ///< Window has been exposed and should be redrawn
    SDL_EVENT_WINDOW_MOVED                   ///< Window has been moved to data1, data2
    SDL_EVENT_WINDOW_RESIZED                 ///< Window has been resized to data1xdata2
    SDL_EVENT_WINDOW_PIXEL_SIZE_CHANGED      ///< The pixel size of the window has changed to data1xdata2
    SDL_EVENT_WINDOW_METAL_VIEW_RESIZED      ///< The pixel size of a Metal view associated with the window has changed
    SDL_EVENT_WINDOW_MINIMIZED               ///< Window has been minimized
    SDL_EVENT_WINDOW_MAXIMIZED               ///< Window has been maximized
    SDL_EVENT_WINDOW_RESTORED                ///< Window has been restored to normal size and position
    SDL_EVENT_WINDOW_MOUSE_ENTER             ///< Window has gained mouse focus
    SDL_EVENT_WINDOW_MOUSE_LEAVE             ///< Window has lost mouse focus
    SDL_EVENT_WINDOW_FOCUS_GAINED            ///< Window has gained keyboard focus
    SDL_EVENT_WINDOW_FOCUS_LOST              ///< Window has lost keyboard focus
    SDL_EVENT_WINDOW_CLOSE_REQUESTED         ///< The window manager requests that the window be closed
    SDL_EVENT_WINDOW_HIT_TEST                ///< Window had a hit test that wasn't SDL_HITTEST_NORMAL
    SDL_EVENT_WINDOW_ICCPROF_CHANGED         ///< The ICC profile of the window's display has changed
    SDL_EVENT_WINDOW_DISPLAY_CHANGED         ///< Window has been moved to display data1
    SDL_EVENT_WINDOW_DISPLAY_SCALE_CHANGED   ///< Window display scale has been changed
    SDL_EVENT_WINDOW_SAFE_AREA_CHANGED       ///< The window safe area has been changed
    SDL_EVENT_WINDOW_OCCLUDED                ///< The window has been occluded
    SDL_EVENT_WINDOW_ENTER_FULLSCREEN        ///< The window has entered fullscreen mode
    SDL_EVENT_WINDOW_LEAVE_FULLSCREEN        ///< The window has left fullscreen mode
    SDL_EVENT_WINDOW_DESTROYED               ///< The window with the associated ID is being or has been destroyed
    SDL_EVENT_WINDOW_HDR_STATE_CHANGED       ///< Window HDR properties have changed
    
    // Keyboard events
    SDL_EVENT_KEY_DOWN = 0x300               ///< Key pressed
    SDL_EVENT_KEY_UP                         ///< Key released
    SDL_EVENT_TEXT_EDITING                   ///< Keyboard text editing (composition)
    SDL_EVENT_TEXT_INPUT                     ///< Keyboard text input
    SDL_EVENT_KEYMAP_CHANGED                 ///< Keymap changed due to a system event
    SDL_EVENT_KEYBOARD_ADDED                 ///< A new keyboard has been inserted into the system
    SDL_EVENT_KEYBOARD_REMOVED               ///< A keyboard has been removed
    SDL_EVENT_TEXT_EDITING_CANDIDATES        ///< Keyboard text editing candidates
    
    // Mouse events
    SDL_EVENT_MOUSE_MOTION = 0x400           ///< Mouse moved
    SDL_EVENT_MOUSE_BUTTON_DOWN              ///< Mouse button pressed
    SDL_EVENT_MOUSE_BUTTON_UP                ///< Mouse button released
    SDL_EVENT_MOUSE_WHEEL                    ///< Mouse wheel motion
    SDL_EVENT_MOUSE_ADDED                    ///< A new mouse has been inserted into the system
    SDL_EVENT_MOUSE_REMOVED                  ///< A mouse has been removed
    
    // Joystick events
    SDL_EVENT_JOYSTICK_AXIS_MOTION = 0x600   ///< Joystick axis motion
    SDL_EVENT_JOYSTICK_BALL_MOTION           ///< Joystick trackball motion
    SDL_EVENT_JOYSTICK_HAT_MOTION            ///< Joystick hat position change
    SDL_EVENT_JOYSTICK_BUTTON_DOWN           ///< Joystick button pressed
    SDL_EVENT_JOYSTICK_BUTTON_UP             ///< Joystick button released
    SDL_EVENT_JOYSTICK_ADDED                 ///< A new joystick has been inserted into the system
    SDL_EVENT_JOYSTICK_REMOVED               ///< An opened joystick has been removed
    SDL_EVENT_JOYSTICK_BATTERY_UPDATED       ///< Joystick battery level change
    SDL_EVENT_JOYSTICK_UPDATE_COMPLETE       ///< Joystick update is complete
    
    // Gamepad events
    SDL_EVENT_GAMEPAD_AXIS_MOTION = 0x650    ///< Gamepad axis motion
    SDL_EVENT_GAMEPAD_BUTTON_DOWN            ///< Gamepad button pressed
    SDL_EVENT_GAMEPAD_BUTTON_UP              ///< Gamepad button released
    SDL_EVENT_GAMEPAD_ADDED                  ///< A new gamepad has been inserted into the system
    SDL_EVENT_GAMEPAD_REMOVED                ///< A gamepad has been removed
    SDL_EVENT_GAMEPAD_REMAPPED               ///< The gamepad mapping was updated
    SDL_EVENT_GAMEPAD_TOUCHPAD_DOWN          ///< Gamepad touchpad was touched
    SDL_EVENT_GAMEPAD_TOUCHPAD_MOTION        ///< Gamepad touchpad finger was moved
    SDL_EVENT_GAMEPAD_TOUCHPAD_UP            ///< Gamepad touchpad finger was lifted
    SDL_EVENT_GAMEPAD_SENSOR_UPDATE          ///< Gamepad sensor was updated
    SDL_EVENT_GAMEPAD_UPDATE_COMPLETE        ///< Gamepad update is complete
    SDL_EVENT_GAMEPAD_STEAM_HANDLE_UPDATED   ///< Gamepad Steam handle has changed
    
    // Touch events
    SDL_EVENT_FINGER_DOWN = 0x700            ///< Finger touched down on the touch surface
    SDL_EVENT_FINGER_UP                      ///< Finger lifted up from the touch surface
    SDL_EVENT_FINGER_MOTION                  ///< Finger moved along the touch surface
    SDL_EVENT_FINGER_CANCELED               ///< Finger touch canceled
    
    // Clipboard events
    SDL_EVENT_CLIPBOARD_UPDATE = 0x900       ///< The clipboard or primary selection changed
    
    // Drag and drop events
    SDL_EVENT_DROP_FILE = 0x1000             ///< The system requests a file open
    SDL_EVENT_DROP_TEXT                      ///< text/plain drag-and-drop event
    SDL_EVENT_DROP_BEGIN                     ///< A new set of drops is beginning
    SDL_EVENT_DROP_COMPLETE                  ///< Current set of drops is now complete
    SDL_EVENT_DROP_POSITION                  ///< Position while moving over the window
    
    // Audio hotplug events
    SDL_EVENT_AUDIO_DEVICE_ADDED = 0x1100    ///< A new audio device is available
    SDL_EVENT_AUDIO_DEVICE_REMOVED           ///< An audio device has been removed
    SDL_EVENT_AUDIO_DEVICE_FORMAT_CHANGED    ///< An audio device's format has been changed by the system
    
    // Sensor events
    SDL_EVENT_SENSOR_UPDATE = 0x1200         ///< A sensor was updated
    
    // Pressure-sensitive pen events
    SDL_EVENT_PEN_PROXIMITY_IN = 0x1300      ///< Pressure-sensitive pen has become available
    SDL_EVENT_PEN_PROXIMITY_OUT              ///< Pressure-sensitive pen has become unavailable
    SDL_EVENT_PEN_DOWN                       ///< Pressure-sensitive pen touched drawing surface
    SDL_EVENT_PEN_UP                         ///< Pressure-sensitive pen stopped touching drawing surface
    SDL_EVENT_PEN_BUTTON_DOWN                ///< Pressure-sensitive pen button pressed
    SDL_EVENT_PEN_BUTTON_UP                  ///< Pressure-sensitive pen button released
    SDL_EVENT_PEN_MOTION                     ///< Pressure-sensitive pen is moving on the tablet
    SDL_EVENT_PEN_AXIS                       ///< Pressure-sensitive pen angle/pressure/etc changed
    
    // Camera hotplug events
    SDL_EVENT_CAMERA_DEVICE_ADDED = 0x1400   ///< A new camera device is available
    SDL_EVENT_CAMERA_DEVICE_REMOVED          ///< A camera device has been removed
    SDL_EVENT_CAMERA_DEVICE_APPROVED         ///< A camera device has been approved for use by the user
    SDL_EVENT_CAMERA_DEVICE_DENIED           ///< A camera device has been denied for use by the user
    
    // Render events
    SDL_EVENT_RENDER_TARGETS_RESET = 0x2000  ///< The render targets have been reset and their contents need to be updated
    SDL_EVENT_RENDER_DEVICE_RESET            ///< The device has been reset and all textures need to be recreated
    SDL_EVENT_RENDER_DEVICE_LOST             ///< The device has been lost and can't be recovered
    
    // Reserved events for private platforms
    SDL_EVENT_PRIVATE0 = 0x4000
    SDL_EVENT_PRIVATE1
    SDL_EVENT_PRIVATE2
    SDL_EVENT_PRIVATE3
    
    // Internal events
    SDL_EVENT_POLL_SENTINEL = 0x7F00         ///< Signals the end of an event poll cycle
    
    // User events
    SDL_EVENT_USER = 0x8000                  ///< Events SDL_EVENT_USER through SDL_EVENT_LAST are for your use
    
    // This last event is only for bounding internal arrays
    SDL_EVENT_LAST = 0xFFFF
} derive(Eq)

///| SDL Event structure
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
#external
pub type SDL_Event

pub fn SDL_Event::is_null(self: Self) -> Bool {
    is_nullptr(self)
}

///|
pub extern "C" fn new_sdl_event() -> SDL_Event = "new_sdl_event"

///|
pub extern "C" fn SDL_Event::get_type(self: SDL_Event) -> SDL_EventType = "sdl_event_get_type"

///| Event filter function type
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
pub typealias FuncRef[(VoidPtr, SDL_Event) -> Int] as SDL_EventFilter

///| Pump the event loop, gathering events from the input devices.
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

///| Check the event queue for messages and optionally return them.
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
pub extern "C" fn sdl_PeepEvents(events: FixedArray[SDL_Event], numevents: Int, action: Int, minType: UInt, maxType: UInt) -> Int = "SDL_PeepEvents"

///| Check for the existence of a certain event type in the event queue.
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
pub extern "C" fn sdl_HasEvent(event_type: UInt) -> Bool = "SDL_HasEvent"

///| Check for the existence of certain event types in the event queue.
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
pub extern "C" fn sdl_HasEvents(minType: UInt, maxType: UInt) -> Bool = "SDL_HasEvents"

///| Clear events of a specific type from the event queue.
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
pub extern "C" fn sdl_FlushEvent(event_type: UInt) = "SDL_FlushEvent"

///| Clear events of a range of types from the event queue.
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
pub extern "C" fn sdl_FlushEvents(minType: UInt, maxType: UInt) = "SDL_FlushEvents"

///| Poll for currently pending events.
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
pub extern "C" fn sdl_PollEvent(event:SDL_Event) -> Bool = "SDL_PollEvent"

///| Wait indefinitely for the next available event.
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
pub extern "C" fn sdl_WaitEvent(event:SDL_Event) -> Bool = "SDL_WaitEvent"

///| Wait until the specified timeout (in milliseconds) for the next available
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
pub extern "C" fn sdl_WaitEventTimeout(event: SDL_Event, timeoutMS: Int) -> Bool = "SDL_WaitEventTimeout"

///| Add an event to the event queue.
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
pub extern "C" fn sdl_PushEvent(event: SDL_Event) -> Bool = "SDL_PushEvent"

///| Set up a filter to process all events before they change internal state
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
pub extern "C" fn sdl_SetEventFilter(filter: SDL_EventFilter, userdata: VoidPtr) = "SDL_SetEventFilter"

///| Query the current event filter.
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
pub extern "C" fn sdl_GetEventFilter(filter: FixedArray[SDL_EventFilter], userdata: FixedArray[VoidPtr]) -> Bool = "SDL_GetEventFilter"

///| Add a callback to be triggered when an event is added to the event queue.
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
pub extern "C" fn sdl_AddEventWatch(filter: SDL_EventFilter, userdata: VoidPtr) -> Bool = "SDL_AddEventWatch"

///| Remove an event watch callback added with SDL_AddEventWatch().
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
pub extern "C" fn sdl_RemoveEventWatch(filter: SDL_EventFilter, userdata: VoidPtr) = "SDL_RemoveEventWatch"

///| Set the state of processing events by type.
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
pub extern "C" fn sdl_SetEventEnabled(event_type: UInt, enabled: Bool) = "SDL_SetEventEnabled"

///| Query the state of processing events by type.
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
pub extern "C" fn sdl_EventEnabled(event_type: UInt) -> Bool = "SDL_EventEnabled"

///| Allocate a set of user-defined events, and return the beginning event
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
pub extern "C" fn sdl_RegisterEvents(numevents: Int) -> UInt = "SDL_RegisterEvents" 
