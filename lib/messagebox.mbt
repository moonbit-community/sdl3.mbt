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

/// # CategoryMessagebox
/// 
/// SDL offers a simple message box API, which is useful for simple alerts,
/// such as informing the user when something fatal happens at startup without
/// the need to build a UI for it (or informing the user _before_ your UI is
/// ready).
/// 
/// These message boxes are native system dialogs where possible.
/// 
/// There is both a customizable function (SDL_ShowMessageBox()) that offers
/// lots of options for what to display and reports on what choice the user
/// made, and also a much-simplified version (SDL_ShowSimpleMessageBox()),
/// merely takes a text message and title, and waits until the user presses a
/// single "OK" UI button. Often, this is all that is necessary.

///| Message box flags.
/// 
/// If supported will display warning icon, etc.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// ```c
/// typedef Uint32 SDL_MessageBoxFlags;
/// ```
pub typealias UInt as SDL_MessageBoxFlags

/// error dialog
pub const SDL_MESSAGEBOX_ERROR: UInt = 0x00000010
/// warning dialog  
pub const SDL_MESSAGEBOX_WARNING: UInt = 0x00000020
/// informational dialog
pub const SDL_MESSAGEBOX_INFORMATION: UInt = 0x00000040
/// buttons placed left to right
pub const SDL_MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT: UInt = 0x00000080
/// buttons placed right to left
pub const SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT: UInt = 0x00000100

///| SDL_MessageBoxButtonData flags.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// ```c
/// typedef Uint32 SDL_MessageBoxButtonFlags;
/// ```
pub typealias UInt as SDL_MessageBoxButtonFlags

/// Marks the default button when return is hit
pub const SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT: UInt = 0x00000001
/// Marks the default button when escape is hit
pub const SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT: UInt = 0x00000002

///| Individual button data.
/// 
/// @since This struct is available since SDL 3.2.0.
/// 
/// ```c
/// typedef struct SDL_MessageBoxButtonData
/// {
///     SDL_MessageBoxButtonFlags flags;
///     int buttonID;       /**< User defined button id (value returned via SDL_ShowMessageBox) */
///     const char *text;   /**< The UTF-8 button text */
/// } SDL_MessageBoxButtonData;
/// ```
pub(all) struct SDL_MessageBoxButtonData {
    flags: SDL_MessageBoxButtonFlags
    buttonID: Int         /// User defined button id (value returned via SDL_ShowMessageBox)
    text: String         /// The UTF-8 button text
}

///| RGB value used in a message box color scheme
/// 
/// @since This struct is available since SDL 3.2.0.
/// 
/// ```c
/// typedef struct SDL_MessageBoxColor
/// {
///     Uint8 r, g, b;
/// } SDL_MessageBoxColor;
/// ```
pub(all) struct SDL_MessageBoxColor {
    r: Byte
    g: Byte
    b: Byte
}

///| An enumeration of indices inside the colors array of SDL_MessageBoxColorScheme.
/// 
/// ```c
/// typedef enum SDL_MessageBoxColorType
/// {
///     SDL_MESSAGEBOX_COLOR_BACKGROUND,
///     SDL_MESSAGEBOX_COLOR_TEXT,
///     SDL_MESSAGEBOX_COLOR_BUTTON_BORDER,
///     SDL_MESSAGEBOX_COLOR_BUTTON_BACKGROUND,
///     SDL_MESSAGEBOX_COLOR_BUTTON_SELECTED,
///     SDL_MESSAGEBOX_COLOR_COUNT                    /**< Size of the colors array of SDL_MessageBoxColorScheme. */
/// } SDL_MessageBoxColorType;
/// ```
pub(all) enum SDL_MessageBoxColorType {
    SDL_MESSAGEBOX_COLOR_BACKGROUND
    SDL_MESSAGEBOX_COLOR_TEXT
    SDL_MESSAGEBOX_COLOR_BUTTON_BORDER
    SDL_MESSAGEBOX_COLOR_BUTTON_BACKGROUND
    SDL_MESSAGEBOX_COLOR_BUTTON_SELECTED
    SDL_MESSAGEBOX_COLOR_COUNT    /// Size of the colors array of SDL_MessageBoxColorScheme.
}

///| A set of colors to use for message box dialogs
/// 
/// @since This struct is available since SDL 3.2.0.
/// 
/// ```c
/// typedef struct SDL_MessageBoxColorScheme
/// {
///     SDL_MessageBoxColor colors[SDL_MESSAGEBOX_COLOR_COUNT];
/// } SDL_MessageBoxColorScheme;
/// ```
pub(all) struct SDL_MessageBoxColorScheme {
    colors: FixedArray[SDL_MessageBoxColor]  // SDL_MESSAGEBOX_COLOR_COUNT elements
}

///| MessageBox structure containing title, text, window, etc.
/// 
/// @since This struct is available since SDL 3.2.0.
/// 
/// ```c
/// typedef struct SDL_MessageBoxData
/// {
///     SDL_MessageBoxFlags flags;
///     SDL_Window *window;                 /**< Parent window, can be NULL */
///     const char *title;                  /**< UTF-8 title */
///     const char *message;                /**< UTF-8 message text */
/// 
///     int numbuttons;
///     const SDL_MessageBoxButtonData *buttons;
/// 
///     const SDL_MessageBoxColorScheme *colorScheme;   /**< SDL_MessageBoxColorScheme, can be NULL to use system settings */
/// } SDL_MessageBoxData;
/// ```
pub(all) struct SDL_MessageBoxData {
    flags: SDL_MessageBoxFlags
    window: SDL_Window?                   /// Parent window, can be NULL
    title: String                        /// UTF-8 title
    message: String                      /// UTF-8 message text
    numbuttons: Int
    buttons: FixedArray[SDL_MessageBoxButtonData]
    colorScheme: SDL_MessageBoxColorScheme? /// SDL_MessageBoxColorScheme, can be NULL to use system settings
}

///| Create a modal message box.
/// 
/// If your needs aren't complex, it might be easier to use
/// SDL_ShowSimpleMessageBox.
/// 
/// This function should be called on the thread that created the parent
/// window, or on the main thread if the messagebox has no parent. It will
/// block execution of that thread until the user clicks a button or closes the
/// messagebox.
/// 
/// This function may be called at any time, even before SDL_Init(). This makes
/// it useful for reporting errors like a failure to create a renderer or
/// OpenGL context.
/// 
/// On X11, SDL rolls its own dialog box with X11 primitives instead of a
/// formal toolkit like GTK+ or Qt.
/// 
/// Note that if SDL_Init() would fail because there isn't any available video
/// target, this function is likely to fail for the same reasons. If this is a
/// concern, check the return value from this function and fall back to writing
/// to stderr if you can.
/// 
/// @param messageboxdata the SDL_MessageBoxData structure with title, text and
///                       other options.
/// @return tuple of (success, buttonid) where success indicates if the call was 
///         successful and buttonid is the user id of the button that was hit.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_ShowSimpleMessageBox
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_ShowMessageBox(const SDL_MessageBoxData *messageboxdata, int *buttonid);
/// ```
pub fn sdl_ShowMessageBox(messageboxdata: SDL_MessageBoxData) -> (Bool, Int) {
    // This is a simplified version - in practice you'd need to convert the struct to C representation
    let buttonid = FixedArray::make(1, 0)
    let success = __sdl_ShowMessageBox(messageboxdata, buttonid)
    (success, buttonid[0])
}

///|
extern "C" fn __sdl_ShowMessageBox(messageboxdata:SDL_MessageBoxData, buttonid: FixedArray[Int]) -> Bool = "SDL_ShowMessageBox"

///| Display a simple modal message box.
/// 
/// If your needs aren't complex, this function is preferred over
/// SDL_ShowMessageBox.
/// 
/// `flags` may be any of the following:
/// 
/// - `SDL_MESSAGEBOX_ERROR`: error dialog
/// - `SDL_MESSAGEBOX_WARNING`: warning dialog
/// - `SDL_MESSAGEBOX_INFORMATION`: informational dialog
/// 
/// This function should be called on the thread that created the parent
/// window, or on the main thread if the messagebox has no parent. It will
/// block execution of that thread until the user clicks a button or closes the
/// messagebox.
/// 
/// This function may be called at any time, even before SDL_Init(). This makes
/// it useful for reporting errors like a failure to create a renderer or
/// OpenGL context.
/// 
/// On X11, SDL rolls its own dialog box with X11 primitives instead of a
/// formal toolkit like GTK+ or Qt.
/// 
/// Note that if SDL_Init() would fail because there isn't any available video
/// target, this function is likely to fail for the same reasons. If this is a
/// concern, check the return value from this function and fall back to writing
/// to stderr if you can.
/// 
/// @param flags an SDL_MessageBoxFlags value.
/// @param title UTF-8 title text.
/// @param message UTF-8 message text.
/// @param window the parent window, or NULL for no parent.
/// @return true on success or false on failure; call SDL_GetError() for more
///         information.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_ShowMessageBox
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_ShowSimpleMessageBox(SDL_MessageBoxFlags flags, const char *title, const char *message, SDL_Window *window);
/// ```
pub fn sdl_ShowSimpleMessageBox(flags: SDL_MessageBoxFlags, title: String, message: String, window: SDL_Window) -> Bool {
    let title_bytes = string_to_cbytes(title)
    let message_bytes = string_to_cbytes(message)
    __sdl_ShowSimpleMessageBox(flags, title_bytes, message_bytes, window)
}

extern "C" fn __sdl_ShowSimpleMessageBox(flags: SDL_MessageBoxFlags, title: Bytes, message: Bytes, window: SDL_Window) -> Bool = "SDL_ShowSimpleMessageBox"
