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

/// # CategoryTimer
/// 
/// SDL provides time management functionality. It is useful for dealing with
/// (usually) small durations of time.
/// 
/// This is not to be confused with _calendar time_ management, which is
/// provided by [CategoryTime](CategoryTime).
/// 
/// This category covers measuring time elapsed (SDL_GetTicks(),
/// SDL_GetPerformanceCounter()), putting a thread to sleep for a certain
/// amount of time (SDL_Delay(), SDL_DelayNS(), SDL_DelayPrecise()), and firing
/// a callback function after a certain amount of time has elasped
/// (SDL_AddTimer(), etc).
/// 
/// There are also useful macros to convert between time units, like
/// SDL_SECONDS_TO_NS() and such.

///|
/// Number of milliseconds in a second.
/// 
/// This is always 1000.
/// 
/// @since This macro is available since SDL 3.2.0.
pub const SDL_MS_PER_SECOND : Int = 1000

///|
/// Number of microseconds in a second.
/// 
/// This is always 1000000.
/// 
/// @since This macro is available since SDL 3.2.0.
pub const SDL_US_PER_SECOND : Int = 1000000

///|
/// Number of nanoseconds in a second.
/// 
/// This is always 1000000000.
/// 
/// @since This macro is available since SDL 3.2.0.
pub const SDL_NS_PER_SECOND : Int64 = 1000000000L

///|
/// Number of nanoseconds in a millisecond.
/// 
/// This is always 1000000.
/// 
/// @since This macro is available since SDL 3.2.0.
pub const SDL_NS_PER_MS : Int = 1000000

///|
/// Number of nanoseconds in a microsecond.
/// 
/// This is always 1000.
/// 
/// @since This macro is available since SDL 3.2.0.
pub const SDL_NS_PER_US : Int = 1000

///|
/// Definition of the timer ID type.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// ```c
/// typedef Uint32 SDL_TimerID;
/// ```
pub type SDL_TimerID = UInt

///|
/// Function prototype for the millisecond timer callback function.
/// 
/// The callback function is passed the current timer interval and returns the
/// next timer interval, in milliseconds. If the returned value is the same as
/// the one passed in, the periodic alarm continues, otherwise a new alarm is
/// scheduled. If the callback returns 0, the periodic alarm is canceled and
/// will be removed.
/// 
/// @param userdata an arbitrary pointer provided by the app through
///                 SDL_AddTimer, for its own use.
/// @param timerID the current timer being processed.
/// @param interval the current callback time interval.
/// @return the new callback time interval, or 0 to disable further runs of
///          the callback.
/// 
/// @threadsafety SDL may call this callback at any time from a background
///               thread; the application is responsible for locking resources
///               the callback touches that need to be protected.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// @see SDL_AddTimer
/// 
/// ```c
/// typedef Uint32 (SDLCALL *SDL_TimerCallback)(void *userdata, SDL_TimerID timerID, Uint32 interval);
/// ```
pub type SDL_TimerCallback = FuncRef[(VoidPtr, SDL_TimerID, UInt) -> UInt]

///|
/// Function prototype for the nanosecond timer callback function.
/// 
/// The callback function is passed the current timer interval and returns the
/// next timer interval, in nanoseconds. If the returned value is the same as
/// the one passed in, the periodic alarm continues, otherwise a new alarm is
/// scheduled. If the callback returns 0, the periodic alarm is canceled and
/// will be removed.
/// 
/// @param userdata an arbitrary pointer provided by the app through
///                 SDL_AddTimer, for its own use.
/// @param timerID the current timer being processed.
/// @param interval the current callback time interval.
/// @return the new callback time interval, or 0 to disable further runs of
///          the callback.
/// 
/// @threadsafety SDL may call this callback at any time from a background
///               thread; the application is responsible for locking resources
///               the callback touches that need to be protected.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// @see SDL_AddTimerNS
/// 
/// ```c
/// typedef Uint64 (SDLCALL *SDL_NSTimerCallback)(void *userdata, SDL_TimerID timerID, Uint64 interval);
/// ```
pub type SDL_NSTimerCallback = FuncRef[(VoidPtr, SDL_TimerID, UInt64) -> UInt64]

///|
/// Get the number of milliseconds that have elapsed since the SDL library
/// initialization.
/// 
/// @return an unsigned 64‑bit integer that represents the number of
///          milliseconds that have elapsed since the SDL library was
///          initialized (typically via a call to SDL_Init).
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetTicksNS
/// 
/// ```c
/// extern SDL_DECLSPEC Uint64 SDLCALL SDL_GetTicks(void);
/// ```
pub extern "C" fn sdl_GetTicks() -> UInt64 = "SDL_GetTicks"

///|
/// Get the number of nanoseconds since SDL library initialization.
/// 
/// @return an unsigned 64-bit value representing the number of nanoseconds
///          since the SDL library initialized.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC Uint64 SDLCALL SDL_GetTicksNS(void);
/// ```
pub extern "C" fn sdl_GetTicksNS() -> UInt64 = "SDL_GetTicksNS"

///|
/// Get the current value of the high resolution counter.
/// 
/// This function is typically used for profiling.
/// 
/// The counter values are only meaningful relative to each other. Differences
/// between values can be converted to times by using
/// SDL_GetPerformanceFrequency().
/// 
/// @return the current counter value.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetPerformanceFrequency
/// 
/// ```c
/// extern SDL_DECLSPEC Uint64 SDLCALL SDL_GetPerformanceCounter(void);
/// ```
pub extern "C" fn sdl_GetPerformanceCounter() -> UInt64 = "SDL_GetPerformanceCounter"

///|
/// Get the count per second of the high resolution counter.
/// 
/// @return a platform-specific count per second.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetPerformanceCounter
/// 
/// ```c
/// extern SDL_DECLSPEC Uint64 SDLCALL SDL_GetPerformanceFrequency(void);
/// ```
pub extern "C" fn sdl_GetPerformanceFrequency() -> UInt64 = "SDL_GetPerformanceFrequency"

///|
/// Wait a specified number of milliseconds before returning.
/// 
/// This function waits a specified number of milliseconds before returning. It
/// waits at least the specified time, but possibly longer due to OS
/// scheduling.
/// 
/// @param ms the number of milliseconds to delay.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_DelayNS
/// @see SDL_DelayPrecise
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_Delay(Uint32 ms);
/// ```
pub extern "C" fn sdl_Delay(ms : UInt) -> Unit = "SDL_Delay"

///|
/// Wait a specified number of nanoseconds before returning.
/// 
/// This function waits a specified number of nanoseconds before returning. It
/// waits at least the specified time, but possibly longer due to OS
/// scheduling.
/// 
/// @param ns the number of nanoseconds to delay.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_Delay
/// @see SDL_DelayPrecise
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_DelayNS(Uint64 ns);
/// ```
pub extern "C" fn sdl_DelayNS(ns : UInt64) -> Unit = "SDL_DelayNS"

///|
/// Wait a specified number of nanoseconds before returning.
/// 
/// This function waits a specified number of nanoseconds before returning. It
/// will attempt to wait as close to the requested time as possible, busy
/// waiting if necessary, but could return later due to OS scheduling.
/// 
/// @param ns the number of nanoseconds to delay.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_Delay
/// @see SDL_DelayNS
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_DelayPrecise(Uint64 ns);
/// ```
pub extern "C" fn sdl_DelayPrecise(ns : UInt64) -> Unit = "SDL_DelayPrecise"

///|
/// Call a callback function at a future time.
/// 
/// The callback function is passed the current timer interval and the user
/// supplied parameter from the SDL_AddTimer() call and should return the next
/// timer interval. If the value returned from the callback is 0, the timer is
/// canceled and will be removed.
/// 
/// The callback is run on a separate thread, and for short timeouts can
/// potentially be called before this function returns.
/// 
/// Timers take into account the amount of time it took to execute the
/// callback. For example, if the callback took 250 ms to execute and returned
/// 1000 (ms), the timer would only wait another 750 ms before its next
/// iteration.
/// 
/// Timing may be inexact due to OS scheduling. Be sure to note the current
/// time with SDL_GetTicksNS() or SDL_GetPerformanceCounter() in case your
/// callback needs to adjust for variances.
/// 
/// @param interval the timer delay, in milliseconds, passed to `callback`.
/// @param callback the SDL_TimerCallback function to call when the specified
///                 `interval` elapses.
/// @param userdata a pointer that is passed to `callback`.
/// @return a timer ID or 0 on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_AddTimerNS
/// @see SDL_RemoveTimer
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_TimerID SDLCALL SDL_AddTimer(Uint32 interval, SDL_TimerCallback callback, void *userdata);
/// ```
pub extern "C" fn sdl_AddTimer(
  interval : UInt,
  callback : SDL_TimerCallback,
  userdata : VoidPtr,
) -> SDL_TimerID = "SDL_AddTimer"

///|
/// Call a callback function at a future time.
/// 
/// The callback function is passed the current timer interval and the user
/// supplied parameter from the SDL_AddTimerNS() call and should return the
/// next timer interval. If the value returned from the callback is 0, the
/// timer is canceled and will be removed.
/// 
/// The callback is run on a separate thread, and for short timeouts can
/// potentially be called before this function returns.
/// 
/// Timers take into account the amount of time it took to execute the
/// callback. For example, if the callback took 250 ns to execute and returned
/// 1000 (ns), the timer would only wait another 750 ns before its next
/// iteration.
/// 
/// Timing may be inexact due to OS scheduling. Be sure to note the current
/// time with SDL_GetTicksNS() or SDL_GetPerformanceCounter() in case your
/// callback needs to adjust for variances.
/// 
/// @param interval the timer delay, in nanoseconds, passed to `callback`.
/// @param callback the SDL_TimerCallback function to call when the specified
///                 `interval` elapses.
/// @param userdata a pointer that is passed to `callback`.
/// @return a timer ID or 0 on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_AddTimer
/// @see SDL_RemoveTimer
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_TimerID SDLCALL SDL_AddTimerNS(Uint64 interval, SDL_NSTimerCallback callback, void *userdata);
/// ```
pub extern "C" fn sdl_AddTimerNS(
  interval : UInt64,
  callback : SDL_NSTimerCallback,
  userdata : VoidPtr,
) -> SDL_TimerID = "SDL_AddTimerNS"

///|
/// Remove a timer created with SDL_AddTimer().
/// 
/// @param id the ID of the timer to remove.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_AddTimer
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RemoveTimer(SDL_TimerID id);
/// ```
pub extern "C" fn sdl_RemoveTimer(id : SDL_TimerID) -> Bool = "SDL_RemoveTimer"
