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

/// # CategoryTime
/// 
/// SDL realtime clock and date/time routines.
/// 
/// There are two data types that are used in this category: SDL_Time, which
/// represents the nanoseconds since a specific moment (an "epoch"), and
/// SDL_DateTime, which breaks time down into human-understandable components:
/// years, months, days, hours, etc.
/// 
/// Much of the functionality is involved in converting those two types to
/// other useful forms.

///|
/// A structure holding a calendar date and time broken down into its
/// components.
/// 
/// @since This struct is available since SDL 3.2.0.
/// 
/// ```c
/// typedef struct SDL_DateTime
/// {
///     int year;                  /**< Year */
///     int month;                 /**< Month [01-12] */
///     int day;                   /**< Day of the month [01-31] */
///     int hour;                  /**< Hour [0-23] */
///     int minute;                /**< Minute [0-59] */
///     int second;                /**< Seconds [0-60] */
///     int nanosecond;            /**< Nanoseconds [0-999999999] */
///     int day_of_week;           /**< Day of the week [0-6] (0 being Sunday) */
///     int utc_offset;            /**< Seconds east of UTC */
/// } SDL_DateTime;
/// ```
pub(all) struct SDL_DateTime {
  year : Int // Year
  month : Int // Month [01-12]
  day : Int // Day of the month [01-31]
  hour : Int // Hour [0-23]
  minute : Int // Minute [0-59]
  second : Int // Seconds [0-60]
  nanosecond : Int // Nanoseconds [0-999999999]
  day_of_week : Int // Day of the week [0-6] (0 being Sunday)
  utc_offset : Int // Seconds east of UTC
}

///|
/// The preferred date format of the current system locale.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// @see SDL_GetDateTimeLocalePreferences
/// 
/// ```c
/// typedef enum SDL_DateFormat
/// {
///     SDL_DATE_FORMAT_YYYYMMDD = 0, /**< Year/Month/Day */
///     SDL_DATE_FORMAT_DDMMYYYY = 1, /**< Day/Month/Year */
///     SDL_DATE_FORMAT_MMDDYYYY = 2  /**< Month/Day/Year */
/// } SDL_DateFormat;
/// ```
pub(all) enum SDL_DateFormat {
  SDL_DATE_FORMAT_YYYYMMDD = 0 // Year/Month/Day
  SDL_DATE_FORMAT_DDMMYYYY = 1 // Day/Month/Year
  SDL_DATE_FORMAT_MMDDYYYY = 2 // Month/Day/Year
}

///|
/// The preferred time format of the current system locale.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// @see SDL_GetDateTimeLocalePreferences
/// 
/// ```c
/// typedef enum SDL_TimeFormat
/// {
///     SDL_TIME_FORMAT_24HR = 0, /**< 24 hour time */
///     SDL_TIME_FORMAT_12HR = 1  /**< 12 hour time */
/// } SDL_TimeFormat;
/// ```
pub(all) enum SDL_TimeFormat {
  SDL_TIME_FORMAT_24HR = 0 // 24 hour time
  SDL_TIME_FORMAT_12HR = 1 // 12 hour time
}

///|
/// Gets the current preferred date and time format for the system locale.
/// 
/// This might be a "slow" call that has to query the operating system. It's
/// best to ask for this once and save the results. However, the preferred
/// formats can change, usually because the user has changed a system
/// preference outside of your program.
/// 
/// @param dateFormat a pointer to the SDL_DateFormat to hold the returned date
///                   format, may be NULL.
/// @param timeFormat a pointer to the SDL_TimeFormat to hold the returned time
///                   format, may be NULL.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetDateTimeLocalePreferences(SDL_DateFormat *dateFormat, SDL_TimeFormat *timeFormat);
/// ```
#owned(dateFormat, timeFormat)
pub extern "C" fn sdl_GetDateTimeLocalePreferences(
  dateFormat : FixedArray[SDL_DateFormat],
  timeFormat : FixedArray[SDL_TimeFormat],
) -> Bool = "SDL_GetDateTimeLocalePreferences"

///|
/// Gets the current value of the system realtime clock in nanoseconds since
/// Jan 1, 1970 in Universal Coordinated Time (UTC).
/// 
/// @param ticks the SDL_Time to hold the returned tick count.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetCurrentTime(SDL_Time *ticks);
/// ```
#owned(ticks)
pub extern "C" fn sdl_GetCurrentTime(ticks : FixedArray[Int64]) -> Bool = "SDL_GetCurrentTime"

///|
/// Converts an SDL_Time in nanoseconds since the epoch to a calendar time in
/// the SDL_DateTime format.
/// 
/// @param ticks the SDL_Time to be converted.
/// @param dt the resulting SDL_DateTime.
/// @param localTime the resulting SDL_DateTime will be expressed in local time
///                  if true, otherwise it will be in Universal Coordinated
///                  Time (UTC).
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_TimeToDateTime(SDL_Time ticks, SDL_DateTime *dt, bool localTime);
/// ```
#owned(dt)
pub extern "C" fn sdl_TimeToDateTime(
  ticks : Int64,
  dt : FixedArray[SDL_DateTime],
  localTime : Bool,
) -> Bool = "SDL_TimeToDateTime"

///|
/// Converts a calendar time to an SDL_Time in nanoseconds since the epoch.
/// 
/// This function ignores the day_of_week member of the SDL_DateTime struct, so
/// it may remain unset.
/// 
/// @param dt the source SDL_DateTime.
/// @param ticks the resulting SDL_Time.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_DateTimeToTime(const SDL_DateTime *dt, SDL_Time *ticks);
/// ```
#owned(dt, ticks)
pub extern "C" fn sdl_DateTimeToTime(
  dt : FixedArray[SDL_DateTime],
  ticks : FixedArray[Int64],
) -> Bool = "SDL_DateTimeToTime"

///|
/// Converts an SDL time into a Windows FILETIME (100-nanosecond intervals
/// since January 1, 1601).
/// 
/// This function fills in the two 32-bit values of the FILETIME structure.
/// 
/// @param ticks the time to convert.
/// @param dwLowDateTime a pointer filled in with the low portion of the
///                      Windows FILETIME value.
/// @param dwHighDateTime a pointer filled in with the high portion of the
///                       Windows FILETIME value.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_TimeToWindows(SDL_Time ticks, Uint32 *dwLowDateTime, Uint32 *dwHighDateTime);
/// ```
#owned(dwLowDateTime, dwHighDateTime)
pub extern "C" fn sdl_TimeToWindows(
  ticks : Int64,
  dwLowDateTime : FixedArray[UInt],
  dwHighDateTime : FixedArray[UInt],
) -> Unit = "SDL_TimeToWindows"

///|
/// Converts a Windows FILETIME (100-nanosecond intervals since January 1,
/// 1601) to an SDL time.
/// 
/// This function takes the two 32-bit values of the FILETIME structure as
/// parameters.
/// 
/// @param dwLowDateTime the low portion of the Windows FILETIME value.
/// @param dwHighDateTime the high portion of the Windows FILETIME value.
/// @return the converted SDL time.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_Time SDLCALL SDL_TimeFromWindows(Uint32 dwLowDateTime, Uint32 dwHighDateTime);
/// ```
pub extern "C" fn sdl_TimeFromWindows(
  dwLowDateTime : UInt,
  dwHighDateTime : UInt,
) -> Int64 = "SDL_TimeFromWindows"

///|
/// Get the number of days in a month for a given year.
/// 
/// @param year the year.
/// @param month the month [1-12].
/// @return the number of days in the requested month or -1 on failure; call
///          SDL_GetError() for more information.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetDaysInMonth(int year, int month);
/// ```
pub extern "C" fn sdl_GetDaysInMonth(year : Int, month : Int) -> Int = "SDL_GetDaysInMonth"

///|
/// Get the day of year for a calendar date.
/// 
/// @param year the year component of the date.
/// @param month the month component of the date.
/// @param day the day component of the date.
/// @return the day of year [0-365] if the date is valid or -1 on failure;
///          call SDL_GetError() for more information.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetDayOfYear(int year, int month, int day);
/// ```
pub extern "C" fn sdl_GetDayOfYear(year : Int, month : Int, day : Int) -> Int = "SDL_GetDayOfYear"

///|
/// Get the day of week for a calendar date.
/// 
/// @param year the year component of the date.
/// @param month the month component of the date.
/// @param day the day component of the date.
/// @return a value between 0 and 6 (0 being Sunday) if the date is valid or
///          -1 on failure; call SDL_GetError() for more information.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetDayOfWeek(int year, int month, int day);
/// ```
pub extern "C" fn sdl_GetDayOfWeek(year : Int, month : Int, day : Int) -> Int = "SDL_GetDayOfWeek"
