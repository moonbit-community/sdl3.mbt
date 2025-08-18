///
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
///

/// # CategoryPen
///
/// SDL pen event handling.
///
/// SDL provides an API for pressure-sensitive pen (stylus and/or eraser)
/// handling, e.g., for input and drawing tablets or suitably equipped mobile /
/// tablet devices.
///
/// To get started with pens, simply handle SDL_EVENT_PEN_* events. When a pen
/// starts providing input, SDL will assign it a unique SDL_PenID, which will
/// remain for the life of the process, as long as the pen stays connected.
///
/// Pens may provide more than simple touch input; they might have other axes,
/// such as pressure, tilt, rotation, etc.

///| SDL pen instance IDs.
///
/// ```c
/// typedef Uint32 SDL_PenID;
/// ```
pub typealias UInt as SDL_PenID

///| The SDL_MouseID for mouse events simulated with pen input.
///
/// ```c
/// #define SDL_PEN_MOUSEID ((SDL_MouseID)-2)
/// ```
pub const SDL_PEN_MOUSEID : SDL_MouseID = 0xFFFF_FFFE

///| The SDL_TouchID for touch events simulated with pen input.
///
/// ```c
/// #define SDL_PEN_TOUCHID ((SDL_TouchID)-2)
/// ```
pub const SDL_PEN_TOUCHID : SDL_TouchID = 0xFFFF_FFFF_FFFF_FFFE

///| Pen input flags, as reported by various pen events' `pen_state` field.
///
/// ```c
/// typedef Uint32 SDL_PenInputFlags;
///
/// #define SDL_PEN_INPUT_DOWN       (1u << 0)  /**< pen is pressed down */
/// #define SDL_PEN_INPUT_BUTTON_1   (1u << 1)  /**< button 1 is pressed */
/// #define SDL_PEN_INPUT_BUTTON_2   (1u << 2)  /**< button 2 is pressed */
/// #define SDL_PEN_INPUT_BUTTON_3   (1u << 3)  /**< button 3 is pressed */
/// #define SDL_PEN_INPUT_BUTTON_4   (1u << 4)  /**< button 4 is pressed */
/// #define SDL_PEN_INPUT_BUTTON_5   (1u << 5)  /**< button 5 is pressed */
/// #define SDL_PEN_INPUT_ERASER_TIP (1u << 30) /**< eraser tip is used */
/// ```
pub(all) enum SDL_PenInputFlags {
  SDL_PEN_INPUT_DOWN = 1
  SDL_PEN_INPUT_BUTTON_1 = 2
  SDL_PEN_INPUT_BUTTON_2 = 4
  SDL_PEN_INPUT_BUTTON_3 = 8
  SDL_PEN_INPUT_BUTTON_4 = 16
  SDL_PEN_INPUT_BUTTON_5 = 32
  SDL_PEN_INPUT_ERASER_TIP = 1073741824
}

///| Pen axis indices.
///
/// ```c
/// typedef enum SDL_PenAxis
/// {
///     SDL_PEN_AXIS_PRESSURE,  /**< Pen pressure.  Unidirectional: 0 to 1.0 */
///     SDL_PEN_AXIS_XTILT,     /**< Pen horizontal tilt angle.  Bidirectional: -90.0 to 90.0 (left-to-right). */
///     SDL_PEN_AXIS_YTILT,     /**< Pen vertical tilt angle.  Bidirectional: -90.0 to 90.0 (top-to-down). */
///     SDL_PEN_AXIS_DISTANCE,  /**< Pen distance to drawing surface.  Unidirectional: 0.0 to 1.0 */
///     SDL_PEN_AXIS_ROTATION,  /**< Pen barrel rotation.  Bidirectional: -180 to 179.9 (clockwise, 0 is facing up, -180.0 is facing down). */
///     SDL_PEN_AXIS_SLIDER,    /**< Pen finger wheel or slider (e.g., Airbrush Pen).  Unidirectional: 0 to 1.0 */
///     SDL_PEN_AXIS_TANGENTIAL_PRESSURE,    /**< Pressure from squeezing the pen ("barrel pressure"). */
///     SDL_PEN_AXIS_COUNT       /**< Total known pen axis types in this version of SDL. This number may grow in future releases! */
/// } SDL_PenAxis;
/// ```
pub(all) enum SDL_PenAxis {
  SDL_PEN_AXIS_PRESSURE
  SDL_PEN_AXIS_XTILT
  SDL_PEN_AXIS_YTILT
  SDL_PEN_AXIS_DISTANCE
  SDL_PEN_AXIS_ROTATION
  SDL_PEN_AXIS_SLIDER
  SDL_PEN_AXIS_TANGENTIAL_PRESSURE
  SDL_PEN_AXIS_COUNT
}
