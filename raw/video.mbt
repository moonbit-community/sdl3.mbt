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

/// # CategoryVideo
/// 
/// SDL's video subsystem is largely interested in abstracting window
/// management from the underlying operating system. You can create windows,
/// manage them in various ways, set them fullscreen, and get events when
/// interesting things happen with them, such as the mouse or keyboard
/// interacting with a window.
/// 
/// The video subsystem is also interested in abstracting away some
/// platform-specific differences in OpenGL: context creation, swapping
/// buffers, etc. This may be crucial to your app, but also you are not
/// required to use OpenGL at all. In fact, SDL can provide rendering to those
/// windows as well, either with an easy-to-use
/// [2D API](https://wiki.libsdl.org/SDL3/CategoryRender)
/// or with a more-powerful
/// [GPU API](https://wiki.libsdl.org/SDL3/CategoryGPU)
/// . Of course, it can simply get out of your way and give you the window
/// handles you need to use Vulkan, Direct3D, Metal, or whatever else you like
/// directly, too.
/// 
/// The video subsystem covers a lot of functionality, out of necessity, so it
/// is worth perusing the list of functions just to see what's available, but
/// most apps can get by with simply creating a window and listening for
/// events, so start with SDL_CreateWindow() and SDL_PollEvent().

///|
/// This is a unique ID for a display for the time it is connected to the
/// system, and is never reused for the lifetime of the application.
/// 
/// If the display is disconnected and reconnected, it will get a new ID.
/// 
/// The value 0 is an invalid ID.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// ```c
/// typedef Uint32 SDL_DisplayID;
/// ```
pub type SDL_DisplayID = UInt

///|
/// This is a unique ID for a window.
/// 
/// The value 0 is an invalid ID.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// ```c
/// typedef Uint32 SDL_WindowID;
/// ```
pub type SDL_WindowID = UInt

///|
/// System theme.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_SystemTheme
/// {
///     SDL_SYSTEM_THEME_UNKNOWN,   /**< Unknown system theme */
///     SDL_SYSTEM_THEME_LIGHT,     /**< Light colored system theme */
///     SDL_SYSTEM_THEME_DARK       /**< Dark colored system theme */
/// } SDL_SystemTheme;
/// ```
pub(all) enum SDL_SystemTheme {
  SDL_SYSTEM_THEME_UNKNOWN
  SDL_SYSTEM_THEME_LIGHT
  SDL_SYSTEM_THEME_DARK
}

///|
/// Internal display mode data.
/// 
/// This lives as a field in SDL_DisplayMode, as opaque data.
/// 
/// @since This struct is available since SDL 3.2.0.
/// 
/// @see SDL_DisplayMode
/// 
/// ```c
/// typedef struct SDL_DisplayModeData SDL_DisplayModeData;
/// ```
#external
pub type SDL_DisplayModeData

///|
/// The structure that defines a display mode.
/// 
/// @since This struct is available since SDL 3.2.0.
/// 
/// @see SDL_GetFullscreenDisplayModes
/// @see SDL_GetDesktopDisplayMode
/// @see SDL_GetCurrentDisplayMode
/// @see SDL_SetWindowFullscreenMode
/// @see SDL_GetWindowFullscreenMode
/// 
/// ```c
/// typedef struct SDL_DisplayMode
/// {
///     SDL_DisplayID displayID;        /**< the display this mode is associated with */
///     SDL_PixelFormat format;         /**< pixel format */
///     int w;                          /**< width */
///     int h;                          /**< height */
///     float pixel_density;            /**< scale converting size to pixels (e.g. a 1920x1080 mode with 2.0 scale would have 3840x2160 pixels) */
///     float refresh_rate;             /**< refresh rate (or 0.0f for unspecified) */
///     int refresh_rate_numerator;     /**< precise refresh rate numerator (or 0 for unspecified) */
///     int refresh_rate_denominator;   /**< precise refresh rate denominator */
/// 
///     SDL_DisplayModeData *internal;  /**< Private */
/// 
/// } SDL_DisplayMode;
/// ```
pub(all) struct SDL_DisplayMode {
  displayID : SDL_DisplayID
  format : UInt // SDL_PixelFormat
  w : Int
  h : Int
  pixel_density : Float
  refresh_rate : Float
  refresh_rate_numerator : Int
  refresh_rate_denominator : Int
  internal : SDL_DisplayModeData
}

///|
/// Display orientation values; the way a display is rotated.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_DisplayOrientation
/// {
///     SDL_ORIENTATION_UNKNOWN,            /**< The display orientation can't be determined */
///     SDL_ORIENTATION_LANDSCAPE,          /**< The display is in landscape mode, with the right side up, relative to portrait mode */
///     SDL_ORIENTATION_LANDSCAPE_FLIPPED,  /**< The display is in landscape mode, with the left side up, relative to portrait mode */
///     SDL_ORIENTATION_PORTRAIT,           /**< The display is in portrait mode */
///     SDL_ORIENTATION_PORTRAIT_FLIPPED    /**< The display is in portrait mode, upside down */
/// } SDL_DisplayOrientation;
/// ```
pub(all) enum SDL_DisplayOrientation {
  SDL_ORIENTATION_UNKNOWN
  SDL_ORIENTATION_LANDSCAPE
  SDL_ORIENTATION_LANDSCAPE_FLIPPED
  SDL_ORIENTATION_PORTRAIT
  SDL_ORIENTATION_PORTRAIT_FLIPPED
}

///|
/// The struct used as an opaque handle to a window.
/// 
/// @since This struct is available since SDL 3.2.0.
/// 
/// @see SDL_CreateWindow
/// 
/// ```c
/// typedef struct SDL_Window SDL_Window;
/// ```
#external
pub type SDL_Window

///|
pub fn SDL_Window::is_null(self : Self) -> Bool {
  is_nullptr(self)
}

///|
/// The flags on a window.
/// 
/// These cover a lot of true/false, or on/off, window state. Some of it is
/// immutable after being set through SDL_CreateWindow(), some of it can be
/// changed on existing windows by the app, and some of it might be altered by
/// the user or system outside of the app's control.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// @see SDL_GetWindowFlags
/// 
/// ```c
/// typedef Uint64 SDL_WindowFlags;
/// ```
pub type SDL_WindowFlags = UInt64

// Window flag constants

///|
pub const SDL_WINDOW_FULLSCREEN : SDL_WindowFlags = 0x0000000000000001UL

///|
pub const SDL_WINDOW_OPENGL : SDL_WindowFlags = 0x0000000000000002UL

///|
pub const SDL_WINDOW_OCCLUDED : SDL_WindowFlags = 0x0000000000000004UL

///|
pub const SDL_WINDOW_HIDDEN : SDL_WindowFlags = 0x0000000000000008UL

///|
pub const SDL_WINDOW_BORDERLESS : SDL_WindowFlags = 0x0000000000000010UL

///|
pub const SDL_WINDOW_RESIZABLE : SDL_WindowFlags = 0x0000000000000020UL

///|
pub const SDL_WINDOW_MINIMIZED : SDL_WindowFlags = 0x0000000000000040UL

///|
pub const SDL_WINDOW_MAXIMIZED : SDL_WindowFlags = 0x0000000000000080UL

///|
pub const SDL_WINDOW_MOUSE_GRABBED : SDL_WindowFlags = 0x0000000000000100UL

///|
pub const SDL_WINDOW_INPUT_FOCUS : SDL_WindowFlags = 0x0000000000000200UL

///|
pub const SDL_WINDOW_MOUSE_FOCUS : SDL_WindowFlags = 0x0000000000000400UL

///|
pub const SDL_WINDOW_EXTERNAL : SDL_WindowFlags = 0x0000000000000800UL

///|
pub const SDL_WINDOW_MODAL : SDL_WindowFlags = 0x0000000000001000UL

///|
pub const SDL_WINDOW_HIGH_PIXEL_DENSITY : SDL_WindowFlags = 0x0000000000002000UL

///|
pub const SDL_WINDOW_MOUSE_CAPTURE : SDL_WindowFlags = 0x0000000000004000UL

///|
pub const SDL_WINDOW_MOUSE_RELATIVE_MODE : SDL_WindowFlags = 0x0000000000008000UL

///|
pub const SDL_WINDOW_ALWAYS_ON_TOP : SDL_WindowFlags = 0x0000000000010000UL

///|
pub const SDL_WINDOW_UTILITY : SDL_WindowFlags = 0x0000000000020000UL

///|
pub const SDL_WINDOW_TOOLTIP : SDL_WindowFlags = 0x0000000000040000UL

///|
pub const SDL_WINDOW_POPUP_MENU : SDL_WindowFlags = 0x0000000000080000UL

///|
pub const SDL_WINDOW_KEYBOARD_GRABBED : SDL_WindowFlags = 0x0000000000100000UL

///|
pub const SDL_WINDOW_VULKAN : SDL_WindowFlags = 0x0000000010000000UL

///|
pub const SDL_WINDOW_METAL : SDL_WindowFlags = 0x0000000020000000UL

///|
pub const SDL_WINDOW_TRANSPARENT : SDL_WindowFlags = 0x0000000040000000UL

///|
pub const SDL_WINDOW_NOT_FOCUSABLE : SDL_WindowFlags = 0x0000000080000000UL

///|
/// Window flash operation.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_FlashOperation
/// {
///     SDL_FLASH_CANCEL,                   /**< Cancel any window flash state */
///     SDL_FLASH_BRIEFLY,                  /**< Flash the window briefly to get attention */
///     SDL_FLASH_UNTIL_FOCUSED             /**< Flash the window until it gets focus */
/// } SDL_FlashOperation;
/// ```
pub(all) enum SDL_FlashOperation {
  SDL_FLASH_CANCEL
  SDL_FLASH_BRIEFLY
  SDL_FLASH_UNTIL_FOCUSED
}

///|
/// Window progress state
/// 
/// @since This enum is available since SDL 3.2.8.
/// 
/// ```c
/// typedef enum SDL_ProgressState
/// {
///     SDL_PROGRESS_STATE_INVALID = -1,    /**< An invalid progress state indicating an error; check SDL_GetError() */
///     SDL_PROGRESS_STATE_NONE,            /**< No progress bar is shown */
///     SDL_PROGRESS_STATE_INDETERMINATE,   /**< The progress bar is shown in a indeterminate state */
///     SDL_PROGRESS_STATE_NORMAL,          /**< The progress bar is shown in a normal state */
///     SDL_PROGRESS_STATE_PAUSED,          /**< The progress bar is shown in a paused state */
///     SDL_PROGRESS_STATE_ERROR            /**< The progress bar is shown in a state indicating the application had an error */
/// } SDL_ProgressState;
/// ```
pub(all) enum SDL_ProgressState {
  SDL_PROGRESS_STATE_INVALID
  SDL_PROGRESS_STATE_NONE
  SDL_PROGRESS_STATE_INDETERMINATE
  SDL_PROGRESS_STATE_NORMAL
  SDL_PROGRESS_STATE_PAUSED
  SDL_PROGRESS_STATE_ERROR
}

///|
/// An opaque handle to an OpenGL context.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// @see SDL_GL_CreateContext
/// 
/// ```c
/// typedef struct SDL_GLContextState *SDL_GLContext;
/// ```
#external
pub type SDL_GLContext

///|
pub fn SDL_GLContext::is_null(self : Self) -> Bool {
  is_nullptr(self)
}

///|
/// Opaque type for an EGL display.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// ```c
/// typedef void *SDL_EGLDisplay;
/// ```
pub type SDL_EGLDisplay = VoidPtr

///|
/// Opaque type for an EGL config.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// ```c
/// typedef void *SDL_EGLConfig;
/// ```
pub type SDL_EGLConfig = VoidPtr

///|
/// Opaque type for an EGL surface.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// ```c
/// typedef void *SDL_EGLSurface;
/// ```
pub type SDL_EGLSurface = VoidPtr

///|
/// An EGL attribute, used when creating an EGL context.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// ```c
/// typedef intptr_t SDL_EGLAttrib;
/// ```
pub type SDL_EGLAttrib = Int64

///|
/// An EGL integer attribute, used when creating an EGL surface.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// ```c
/// typedef int SDL_EGLint;
/// ```
pub type SDL_EGLint = Int

///|
/// EGL platform attribute initialization callback.
/// 
/// This is called when SDL is attempting to create an EGL context, to let the
/// app add extra attributes to its eglGetPlatformDisplay() call.
/// 
/// The callback should return a pointer to an EGL attribute array terminated
/// with `EGL_NONE`. If this function returns NULL, the SDL_CreateWindow
/// process will fail gracefully.
/// 
/// The returned pointer should be allocated with SDL_malloc() and will be
/// passed to SDL_free().
/// 
/// The arrays returned by each callback will be appended to the existing
/// attribute arrays defined by SDL.
/// 
/// @param userdata an app-controlled pointer that is passed to the callback.
/// @return a newly-allocated array of attributes, terminated with `EGL_NONE`.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// @see SDL_EGL_SetAttributeCallbacks
/// 
/// ```c
/// typedef SDL_EGLAttrib *(SDLCALL *SDL_EGLAttribArrayCallback)(void *userdata);
/// ```
pub type SDL_EGLAttribArrayCallback = FuncRef[
  (VoidPtr) -> FixedArray[SDL_EGLAttrib],
]

///|
/// EGL surface/context attribute initialization callback types.
/// 
/// This is called when SDL is attempting to create an EGL surface, to let the
/// app add extra attributes to its eglCreateWindowSurface() or
/// eglCreateContext calls.
/// 
/// For convenience, the EGLDisplay and EGLConfig to use are provided to the
/// callback.
/// 
/// The callback should return a pointer to an EGL attribute array terminated
/// with `EGL_NONE`. If this function returns NULL, the SDL_CreateWindow
/// process will fail gracefully.
/// 
/// The returned pointer should be allocated with SDL_malloc() and will be
/// passed to SDL_free().
/// 
/// The arrays returned by each callback will be appended to the existing
/// attribute arrays defined by SDL.
/// 
/// @param userdata an app-controlled pointer that is passed to the callback.
/// @param display the EGL display to be used.
/// @param config the EGL config to be used.
/// @return a newly-allocated array of attributes, terminated with `EGL_NONE`.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// @see SDL_EGL_SetAttributeCallbacks
/// 
/// ```c
/// typedef SDL_EGLint *(SDLCALL *SDL_EGLIntArrayCallback)(void *userdata, SDL_EGLDisplay display, SDL_EGLConfig config);
/// ```
pub type SDL_EGLIntArrayCallback = FuncRef[
  (VoidPtr, SDL_EGLDisplay, SDL_EGLConfig) -> FixedArray[SDL_EGLint],
]

///|
/// An enumeration of OpenGL configuration attributes.
/// 
/// While you can set most OpenGL attributes normally, the attributes listed
/// above must be known before SDL creates the window that will be used with
/// the OpenGL context. These attributes are set and read with
/// SDL_GL_SetAttribute() and SDL_GL_GetAttribute().
/// 
/// In some cases, these attributes are minimum requests; the GL does not
/// promise to give you exactly what you asked for. It's possible to ask for a
/// 16-bit depth buffer and get a 24-bit one instead, for example, or to ask
/// for no stencil buffer and still have one available. Context creation should
/// fail if the GL can't provide your requested attributes at a minimum, but
/// you should check to see exactly what you got.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_GLAttr
/// {
///     SDL_GL_RED_SIZE,
///     SDL_GL_GREEN_SIZE,
///     SDL_GL_BLUE_SIZE,
///     SDL_GL_ALPHA_SIZE,
///     SDL_GL_BUFFER_SIZE,
///     SDL_GL_DOUBLEBUFFER,
///     SDL_GL_DEPTH_SIZE,
///     SDL_GL_STENCIL_SIZE,
///     SDL_GL_ACCUM_RED_SIZE,
///     SDL_GL_ACCUM_GREEN_SIZE,
///     SDL_GL_ACCUM_BLUE_SIZE,
///     SDL_GL_ACCUM_ALPHA_SIZE,
///     SDL_GL_STEREO,
///     SDL_GL_MULTISAMPLEBUFFERS,
///     SDL_GL_MULTISAMPLESAMPLES,
///     SDL_GL_ACCELERATED_VISUAL,
///     SDL_GL_RETAINED_BACKING,
///     SDL_GL_CONTEXT_MAJOR_VERSION,
///     SDL_GL_CONTEXT_MINOR_VERSION,
///     SDL_GL_CONTEXT_FLAGS,
///     SDL_GL_CONTEXT_PROFILE_MASK,
///     SDL_GL_SHARE_WITH_CURRENT_CONTEXT,
///     SDL_GL_FRAMEBUFFER_SRGB_CAPABLE,
///     SDL_GL_CONTEXT_RELEASE_BEHAVIOR,
///     SDL_GL_CONTEXT_RESET_NOTIFICATION,
///     SDL_GL_CONTEXT_NO_ERROR,
///     SDL_GL_FLOATBUFFERS,
///     SDL_GL_EGL_PLATFORM
/// } SDL_GLAttr;
/// ```
pub(all) enum SDL_GLAttr {
  SDL_GL_RED_SIZE
  SDL_GL_GREEN_SIZE
  SDL_GL_BLUE_SIZE
  SDL_GL_ALPHA_SIZE
  SDL_GL_BUFFER_SIZE
  SDL_GL_DOUBLEBUFFER
  SDL_GL_DEPTH_SIZE
  SDL_GL_STENCIL_SIZE
  SDL_GL_ACCUM_RED_SIZE
  SDL_GL_ACCUM_GREEN_SIZE
  SDL_GL_ACCUM_BLUE_SIZE
  SDL_GL_ACCUM_ALPHA_SIZE
  SDL_GL_STEREO
  SDL_GL_MULTISAMPLEBUFFERS
  SDL_GL_MULTISAMPLESAMPLES
  SDL_GL_ACCELERATED_VISUAL
  SDL_GL_RETAINED_BACKING
  SDL_GL_CONTEXT_MAJOR_VERSION
  SDL_GL_CONTEXT_MINOR_VERSION
  SDL_GL_CONTEXT_FLAGS
  SDL_GL_CONTEXT_PROFILE_MASK
  SDL_GL_SHARE_WITH_CURRENT_CONTEXT
  SDL_GL_FRAMEBUFFER_SRGB_CAPABLE
  SDL_GL_CONTEXT_RELEASE_BEHAVIOR
  SDL_GL_CONTEXT_RESET_NOTIFICATION
  SDL_GL_CONTEXT_NO_ERROR
  SDL_GL_FLOATBUFFERS
  SDL_GL_EGL_PLATFORM
}

// GL Profile flags

///|
pub type SDL_GLProfile = UInt

///|
pub const SDL_GL_CONTEXT_PROFILE_CORE : SDL_GLProfile = 0x0001U

///|
pub const SDL_GL_CONTEXT_PROFILE_COMPATIBILITY : SDL_GLProfile = 0x0002U

///|
pub const SDL_GL_CONTEXT_PROFILE_ES : SDL_GLProfile = 0x0004U

// GL Context flags

///|
pub type SDL_GLContextFlag = UInt

///|
pub const SDL_GL_CONTEXT_DEBUG_FLAG : SDL_GLContextFlag = 0x0001U

///|
pub const SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG : SDL_GLContextFlag = 0x0002U

///|
pub const SDL_GL_CONTEXT_ROBUST_ACCESS_FLAG : SDL_GLContextFlag = 0x0004U

///|
pub const SDL_GL_CONTEXT_RESET_ISOLATION_FLAG : SDL_GLContextFlag = 0x0008U

// GL Context release flags

///|
pub type SDL_GLContextReleaseFlag = UInt

///|
pub const SDL_GL_CONTEXT_RELEASE_BEHAVIOR_NONE : SDL_GLContextReleaseFlag = 0x0000U

///|
pub const SDL_GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH : SDL_GLContextReleaseFlag = 0x0001U

// GL Context reset notification flags

///|
pub type SDL_GLContextResetNotification = UInt

///|
pub const SDL_GL_CONTEXT_RESET_NO_NOTIFICATION : SDL_GLContextResetNotification = 0x0000U

///|
pub const SDL_GL_CONTEXT_RESET_LOSE_CONTEXT : SDL_GLContextResetNotification = 0x0001U

///|
/// Get the number of video drivers compiled into SDL.
/// 
/// @return the number of built in video drivers.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetVideoDriver
/// 
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetNumVideoDrivers(void);
/// ```
pub extern "C" fn sdl_GetNumVideoDrivers() -> Int = "SDL_GetNumVideoDrivers"

///|
/// Get the name of a built in video driver.
/// 
/// The video drivers are presented in the order in which they are normally
/// checked during initialization.
/// 
/// The names of drivers are all simple, low-ASCII identifiers, like "cocoa",
/// "x11" or "windows". These never have Unicode characters, and are not meant
/// to be proper names.
/// 
/// @param index the index of a video driver.
/// @return the name of the video driver with the given **index**, or NULL if
///          index is out of bounds.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetNumVideoDrivers
/// 
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetVideoDriver(int index);
/// ```
pub fn sdl_GetVideoDriver(index : Int) -> String {
  let cres = __sdl_GetVideoDriver(index)
  let res = cres.to_string()
  free_cstr(cres)
  res
}

///|
extern "C" fn __sdl_GetVideoDriver(index : Int) -> CStr = "SDL_GetVideoDriver"

///|
/// Get the name of the currently initialized video driver.
/// 
/// The names of drivers are all simple, low-ASCII identifiers, like "cocoa",
/// "x11" or "windows". These never have Unicode characters, and are not meant
/// to be proper names.
/// 
/// @return the name of the current video driver or NULL if no driver has been
///          initialized.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetNumVideoDrivers
/// @see SDL_GetVideoDriver
/// 
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetCurrentVideoDriver(void);
/// ```
pub fn sdl_GetCurrentVideoDriver() -> String {
  let cres = __sdl_GetCurrentVideoDriver()
  let res = cres.to_string()
  free_cstr(cres)
  res
}

///|
extern "C" fn __sdl_GetCurrentVideoDriver() -> CStr = "SDL_GetCurrentVideoDriver"

///|
/// Get the current system theme.
/// 
/// @return the current system theme, light, dark, or unknown.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_SystemTheme SDLCALL SDL_GetSystemTheme(void);
/// ```
pub extern "C" fn sdl_GetSystemTheme() -> SDL_SystemTheme = "SDL_GetSystemTheme"

///|
/// Get a list of currently connected displays.
/// 
/// @param count a pointer filled in with the number of displays returned, may
///              be NULL.
/// @return a 0 terminated array of display instance IDs or NULL on failure;
///          call SDL_GetError() for more information. This should be freed
///          with SDL_free() when it is no longer needed.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetPrimaryDisplay
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_DisplayID * SDLCALL SDL_GetDisplays(int *count);
/// ```
#owned(count)
pub extern "C" fn sdl_GetDisplays(
  count : FixedArray[Int],
) -> FixedArray[SDL_DisplayID] = "SDL_GetDisplays"

///|
/// Return the primary display.
/// 
/// @return the instance ID of the primary display on success or 0 on failure;
///          call SDL_GetError() for more information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetDisplays
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_DisplayID SDLCALL SDL_GetPrimaryDisplay(void);
/// ```
pub extern "C" fn sdl_GetPrimaryDisplay() -> SDL_DisplayID = "SDL_GetPrimaryDisplay"

///|
/// Get the properties associated with a display.
/// 
/// @param displayID the instance ID of the display to query.
/// @return a valid property ID on success or 0 on failure; call
///          SDL_GetError() for more information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_PropertiesID SDLCALL SDL_GetDisplayProperties(SDL_DisplayID displayID);
/// ```
pub extern "C" fn sdl_GetDisplayProperties(displayID : SDL_DisplayID) -> UInt = "SDL_GetDisplayProperties" // SDL_PropertiesID is Uint32

///|
/// Get the name of a display in UTF-8 encoding.
/// 
/// @param displayID the instance ID of the display to query.
/// @return the name of a display or NULL on failure; call SDL_GetError() for
///          more information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetDisplayName(SDL_DisplayID displayID);
/// ```
pub fn sdl_GetDisplayName(displayID : SDL_DisplayID) -> String {
  let cres = __sdl_GetDisplayName(displayID)
  let res = cres.to_string()
  free_cstr(cres)
  res
}

///|
extern "C" fn __sdl_GetDisplayName(displayID : SDL_DisplayID) -> CStr = "SDL_GetDisplayName"

///|
/// Get the desktop area represented by a display.
/// 
/// The primary display is always located at (0,0).
/// 
/// @param displayID the instance ID of the display to query.
/// @param rect the SDL_Rect structure filled in with the display bounds.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetDisplayUsableBounds
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetDisplayBounds(SDL_DisplayID displayID, SDL_Rect *rect);
/// ```
#owned(rect)
pub extern "C" fn sdl_GetDisplayBounds(
  displayID : SDL_DisplayID,
  rect : FixedArray[SDL_Rect],
) -> Bool = "SDL_GetDisplayBounds"

///|
/// Get the usable desktop area represented by a display.
/// 
/// The primary display is always located at (0,0).
/// 
/// This is the same area as SDL_GetDisplayBounds() reports, but with portions
/// reserved by the system removed. For example, on Apple's macOS, this
/// subtracts the area occupied by the menu bar and dock.
/// 
/// Setting a window to be fullscreen generally bypasses these unusable areas,
/// so these are good guidelines for the maximum space available to a
/// non-fullscreen window.
/// 
/// @param displayID the instance ID of the display to query.
/// @param rect the SDL_Rect structure filled in with the display bounds.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetDisplayBounds
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetDisplayUsableBounds(SDL_DisplayID displayID, SDL_Rect *rect);
/// ```
#owned(rect)
pub extern "C" fn sdl_GetDisplayUsableBounds(
  displayID : SDL_DisplayID,
  rect : FixedArray[SDL_Rect],
) -> Bool = "SDL_GetDisplayUsableBounds"

///|
/// Get the orientation of a display.
/// 
/// @param displayID the instance ID of the display to query.
/// @return the SDL_DisplayOrientation enum value of the display, or
///          SDL_ORIENTATION_UNKNOWN if it isn't available.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_DisplayOrientation SDLCALL SDL_GetNaturalDisplayOrientation(SDL_DisplayID displayID);
/// ```
pub extern "C" fn sdl_GetNaturalDisplayOrientation(
  displayID : SDL_DisplayID,
) -> SDL_DisplayOrientation = "SDL_GetNaturalDisplayOrientation"

///|
/// Get the orientation of a display.
/// 
/// @param displayID the instance ID of the display to query.
/// @return the SDL_DisplayOrientation enum value of the display, or
///          SDL_ORIENTATION_UNKNOWN if it isn't available.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_DisplayOrientation SDLCALL SDL_GetCurrentDisplayOrientation(SDL_DisplayID displayID);
/// ```
pub extern "C" fn sdl_GetCurrentDisplayOrientation(
  displayID : SDL_DisplayID,
) -> SDL_DisplayOrientation = "SDL_GetCurrentDisplayOrientation"

///|
/// Get the content scale of a display.
/// 
/// The content scale is the expected scale for content based on the DPI
/// settings of the display. For example, a 4K display might have a 2.0 scale to
/// indicate that UI elements should be drawn twice as large as normal to
/// account for the increased pixel density.
/// 
/// The default value is 1.0.
/// 
/// This function can be called before SDL_Init().
/// 
/// @param displayID the instance ID of the display to query.
/// @return the content scale of the display, or 0.0f on failure; call
///          SDL_GetError() for more information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC float SDLCALL SDL_GetDisplayContentScale(SDL_DisplayID displayID);
/// ```
pub extern "C" fn sdl_GetDisplayContentScale(
  displayID : SDL_DisplayID,
) -> Float = "SDL_GetDisplayContentScale"

// 这里我会为了简洁起见，添加一些最重要的函数。完整版本会包含更多函数

///|
/// Create a window with the specified properties.
/// 
/// These are the supported properties:
/// 
/// - `SDL_PROP_WINDOW_CREATE_ALWAYS_ON_TOP_BOOLEAN`: true if the window should
///   be always on top
/// - `SDL_PROP_WINDOW_CREATE_BORDERLESS_BOOLEAN`: true if the window should
///   have no window decoration
/// - `SDL_PROP_WINDOW_CREATE_FOCUSABLE_BOOLEAN`: true if the window should
///   accept keyboard input (defaults to true)
/// - `SDL_PROP_WINDOW_CREATE_EXTERNAL_GRAPHICS_CONTEXT_BOOLEAN`: true if the
///   window will be used with an externally managed graphics context.
/// - `SDL_PROP_WINDOW_CREATE_FLAGS_NUMBER`: equivalent to flags
/// - `SDL_PROP_WINDOW_CREATE_FULLSCREEN_BOOLEAN`: true if the window should
///   start in fullscreen mode at desktop resolution
/// - `SDL_PROP_WINDOW_CREATE_HEIGHT_NUMBER`: the height of the window
/// - `SDL_PROP_WINDOW_CREATE_HIDDEN_BOOLEAN`: true if the window should start
///   hidden
/// - `SDL_PROP_WINDOW_CREATE_HIGH_PIXEL_DENSITY_BOOLEAN`: true if the window
///   uses a high pixel density buffer if possible
/// - `SDL_PROP_WINDOW_CREATE_MAXIMIZED_BOOLEAN`: true if the window should
///   start maximized
/// - `SDL_PROP_WINDOW_CREATE_MENU_BOOLEAN`: true if the window is a popup menu
/// - `SDL_PROP_WINDOW_CREATE_METAL_BOOLEAN`: true if the window will be used
///   with Metal rendering
/// - `SDL_PROP_WINDOW_CREATE_MINIMIZED_BOOLEAN`: true if the window should
///   start minimized
/// - `SDL_PROP_WINDOW_CREATE_MODAL_BOOLEAN`: true if the window is modal to
///   its parent
/// - `SDL_PROP_WINDOW_CREATE_MOUSE_GRABBED_BOOLEAN`: true if the window starts
///   with grabbed mouse focus
/// - `SDL_PROP_WINDOW_CREATE_OPENGL_BOOLEAN`: true if the window will be used
///   with OpenGL rendering
/// - `SDL_PROP_WINDOW_CREATE_PARENT_POINTER`: an SDL_Window that will be the
///   parent of this window, required for windows with the "toolip", "menu",
///   and "modal" properties
/// - `SDL_PROP_WINDOW_CREATE_RESIZABLE_BOOLEAN`: true if the window should be
///   resizable
/// - `SDL_PROP_WINDOW_CREATE_TITLE_STRING`: the title of the window, in UTF-8
///   encoding
/// - `SDL_PROP_WINDOW_CREATE_TRANSPARENT_BOOLEAN`: true if the window show
///   transparent in the areas with alpha of 0
/// - `SDL_PROP_WINDOW_CREATE_TOOLTIP_BOOLEAN`: true if the window is a tooltip
/// - `SDL_PROP_WINDOW_CREATE_UTILITY_BOOLEAN`: true if the window is a utility
///   window, not showing in the task bar and window list
/// - `SDL_PROP_WINDOW_CREATE_VULKAN_BOOLEAN`: true if the window will be used
///   with Vulkan rendering
/// - `SDL_PROP_WINDOW_CREATE_WIDTH_NUMBER`: the width of the window
/// - `SDL_PROP_WINDOW_CREATE_X_NUMBER`: the x position of the window, or
///   `SDL_WINDOWPOS_CENTERED`, defaults to `SDL_WINDOWPOS_UNDEFINED`.
/// - `SDL_PROP_WINDOW_CREATE_Y_NUMBER`: the y position of the window, or
///   `SDL_WINDOWPOS_CENTERED`, defaults to `SDL_WINDOWPOS_UNDEFINED`.
/// 
/// The window is implicitly shown if SDL_PROP_WINDOW_CREATE_HIDDEN_BOOLEAN is
/// not set.
/// 
/// Windows with the "tooltip" and "menu" properties are popup windows and have
/// the behaviors and guidelines outlined in `SDL_CreatePopupWindow()`.
/// 
/// If this window is being created to be used with an SDL_Renderer, you should
/// not add a graphics API specific flag
/// (SDL_PROP_WINDOW_CREATE_OPENGL_BOOLEAN, etc), as SDL will add the correct
/// flag when the renderer is created.
/// 
/// @param props the properties to use.
/// @return the window that was created or NULL on failure; call
///          SDL_GetError() for more information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_CreatePopupWindow
/// @see SDL_CreateWindow
/// @see SDL_DestroyWindow
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_Window * SDLCALL SDL_CreateWindowWithProperties(SDL_PropertiesID props);
/// ```
pub extern "C" fn sdl_CreateWindowWithProperties(props : UInt) -> SDL_Window = "SDL_CreateWindowWithProperties" // SDL_PropertiesID is Uint32

///|
/// Create a window with the specified title, position, dimensions, and flags.
/// 
/// `flags` may be any of the following OR'd together:
/// 
/// - `SDL_WINDOW_FULLSCREEN`: fullscreen window at desktop resolution
/// - `SDL_WINDOW_OPENGL`: window usable with an OpenGL context
/// - `SDL_WINDOW_VULKAN`: window usable with a Vulkan instance
/// - `SDL_WINDOW_METAL`: window usable with a Metal instance
/// - `SDL_WINDOW_HIDDEN`: window is not visible
/// - `SDL_WINDOW_BORDERLESS`: no window decoration
/// - `SDL_WINDOW_RESIZABLE`: window can be resized
/// - `SDL_WINDOW_MINIMIZED`: window is minimized
/// - `SDL_WINDOW_MAXIMIZED`: window is maximized
/// - `SDL_WINDOW_MOUSE_GRABBED`: window has grabbed mouse focus
/// - `SDL_WINDOW_MOUSE_CAPTURE`: window has mouse captured (unrelated to
///   MOUSE_GRABBED)
/// - `SDL_WINDOW_ALWAYS_ON_TOP`: window should always be above others
/// - `SDL_WINDOW_UTILITY`: window should not be added to the taskbar
/// - `SDL_WINDOW_TOOLTIP`: window should be treated as a tooltip and does not
///   get mouse or keyboard focus
/// - `SDL_WINDOW_POPUP_MENU`: window should be treated as a popup menu
/// - `SDL_WINDOW_KEYBOARD_GRABBED`: window has grabbed keyboard input
/// - `SDL_WINDOW_NOT_FOCUSABLE`: window should not be focusable
/// 
/// The SDL_Window is implicitly shown if SDL_WINDOW_HIDDEN is not set.
/// 
/// On Apple's macOS, you **must** set the NSHighResolutionCapable Info.plist
/// property to YES, otherwise you will not receive a High-DPI OpenGL canvas.
/// 
/// The window pixel size may differ from its window coordinate size if the
/// window is on a high pixel density display. Use SDL_GetWindowSize() to query
/// the client area's size in window coordinates, and
/// SDL_GetWindowSizeInPixels() or SDL_GetRenderOutputSize() to query the
/// drawable size in pixels. Note that the drawable size can vary after the
/// window is created and should be queried again if you get an
/// SDL_EVENT_WINDOW_PIXEL_SIZE_CHANGED event.
/// 
/// If the window is created with any of the SDL_WINDOW_OPENGL or
/// SDL_WINDOW_VULKAN flags, then the corresponding LoadLibrary function
/// (SDL_GL_LoadLibrary or SDL_Vulkan_LoadLibrary) is called and the
/// corresponding UnloadLibrary function is called by SDL_DestroyWindow().
/// 
/// If SDL_WINDOW_VULKAN is specified and there isn't a working Vulkan driver,
/// SDL_CreateWindow() will fail, because SDL_Vulkan_LoadLibrary() will fail.
/// 
/// If SDL_WINDOW_METAL is specified on an OS that does not support Metal,
/// SDL_CreateWindow() will fail.
/// 
/// If you intend to use this window with an SDL_Renderer, you should not add a
/// graphics API specific flag (SDL_WINDOW_OPENGL, etc), as SDL will add the
/// correct flag when the renderer is created.
/// 
/// @param title the title of the window, in UTF-8 encoding.
/// @param w the width of the window.
/// @param h the height of the window.
/// @param flags 0, or one or more SDL_WindowFlags OR'd together.
/// @return the window that was created or NULL on failure; call
///          SDL_GetError() for more information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_CreatePopupWindow
/// @see SDL_CreateWindowWithProperties
/// @see SDL_DestroyWindow
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_Window * SDLCALL SDL_CreateWindow(const char *title, int w, int h, SDL_WindowFlags flags);
/// ```
pub fn sdl_CreateWindow(
  title : String,
  w : Int,
  h : Int,
  flags : SDL_WindowFlags,
) -> SDL_Window {
  __sdl_CreateWindow(string_to_cbytes(title), w, h, flags)
}

///|
#owned(title)
extern "C" fn __sdl_CreateWindow(
  title : Bytes,
  w : Int,
  h : Int,
  flags : SDL_WindowFlags,
) -> SDL_Window = "SDL_CreateWindow"

///|
/// Get the window ID of a window.
/// 
/// @param window the window to query.
/// @return the ID of the window on success or 0 on failure; call
///          SDL_GetError() for more information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetWindowFromID
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_WindowID SDLCALL SDL_GetWindowID(SDL_Window *window);
/// ```
pub extern "C" fn sdl_GetWindowID(window : SDL_Window) -> SDL_WindowID = "SDL_GetWindowID"

///|
/// Get a window from a stored ID.
/// 
/// The window is returned even if it is in another process (such as when
/// using the "external" window flag).
/// 
/// @param id the ID of the window.
/// @return the window associated with `id` or NULL if it doesn't exist; call
///          SDL_GetError() for more information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetWindowID
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_Window * SDLCALL SDL_GetWindowFromID(SDL_WindowID id);
/// ```
pub extern "C" fn sdl_GetWindowFromID(id : SDL_WindowID) -> SDL_Window = "SDL_GetWindowFromID"

///|
/// Get the parent of a window.
/// 
/// @param window the window to query.
/// @return the parent of the window on success or NULL if the window has no
///          parent.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_SetWindowParent
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_Window * SDLCALL SDL_GetWindowParent(SDL_Window *window);
/// ```
pub extern "C" fn sdl_GetWindowParent(window : SDL_Window) -> SDL_Window = "SDL_GetWindowParent"

///|
/// Get the properties associated with a window.
/// 
/// @param window the window to query.
/// @return a valid property ID on success or 0 on failure; call
///          SDL_GetError() for more information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_PropertiesID SDLCALL SDL_GetWindowProperties(SDL_Window *window);
/// ```
pub extern "C" fn sdl_GetWindowProperties(window : SDL_Window) -> UInt = "SDL_GetWindowProperties" // SDL_PropertiesID is Uint32

///|
/// Get the window flags.
/// 
/// @param window the window to retrieve the flags from.
/// @return a mask of the SDL_WindowFlags associated with `window`.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_CreateWindow
/// @see SDL_HideWindow
/// @see SDL_MaximizeWindow
/// @see SDL_MinimizeWindow
/// @see SDL_SetWindowFullscreen
/// @see SDL_SetWindowMouseGrab
/// @see SDL_ShowWindow
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_WindowFlags SDLCALL SDL_GetWindowFlags(SDL_Window *window);
/// ```
pub extern "C" fn sdl_GetWindowFlags(window : SDL_Window) -> SDL_WindowFlags = "SDL_GetWindowFlags"

///|
/// Set the title of a window.
/// 
/// This string is expected to be in UTF-8 encoding.
/// 
/// @param window the window to change.
/// @param title the desired window title in UTF-8 format.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetWindowTitle
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetWindowTitle(SDL_Window *window, const char *title);
/// ```
pub fn sdl_SetWindowTitle(window : SDL_Window, title : String) -> Bool {
  __sdl_SetWindowTitle(window, string_to_cbytes(title))
}

///|
#owned(title)
extern "C" fn __sdl_SetWindowTitle(window : SDL_Window, title : Bytes) -> Bool = "SDL_SetWindowTitle"

///|
/// Get the title of a window.
/// 
/// @param window the window to query.
/// @return the title of the window in UTF-8 format or "" if there is no
///          title.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_SetWindowTitle
/// 
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetWindowTitle(SDL_Window *window);
/// ```
pub fn sdl_GetWindowTitle(window : SDL_Window) -> String {
  let cres = __sdl_GetWindowTitle(window)
  let res = cres.to_string()
  free_cstr(cres)
  res
}

///|
extern "C" fn __sdl_GetWindowTitle(window : SDL_Window) -> CStr = "SDL_GetWindowTitle"

///|
/// Set the icon for a window.
/// 
/// @param window the window to change.
/// @param icon an SDL_Surface structure containing the icon for the window.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetWindowIcon(SDL_Window *window, SDL_Surface *icon);
/// ```
pub extern "C" fn sdl_SetWindowIcon(
  window : SDL_Window,
  icon : SDL_Surface,
) -> Bool = "SDL_SetWindowIcon"

///|
/// Request that the window's position be set.
/// 
/// If, at the time of this request, the window is in a fixed-size state such
/// as maximized, this request may be deferred until the window returns to a
/// resizable state.
/// 
/// This can be used to reposition fullscreen windows onto a different display,
/// however, exclusive fullscreen windows are locked to a display and can only
/// be repositioned programmatically via SDL_SetWindowFullscreenMode().
/// 
/// On some windowing systems this request is asynchronous and the new
/// coordinates may not have have been applied immediately upon the return of
/// this function. If an immediate change is required, call SDL_SyncWindow() to
/// block until the changes have taken effect.
/// 
/// When the window position changes, an SDL_EVENT_WINDOW_MOVED event will be
/// emitted with the window's new coordinates. Note that the new coordinates
/// may not match the exact coordinates requested, as some windowing systems
/// can restrict the position of the window in certain scenarios (e.g.
/// constraining the position so the window is always within desktop bounds).
/// Additionally, as this is just a request, it can be denied by the windowing
/// system.
/// 
/// @param window the window to reposition.
/// @param x the x coordinate of the window in screen coordinates, or
///          `SDL_WINDOWPOS_CENTERED` or `SDL_WINDOWPOS_UNDEFINED`.
/// @param y the y coordinate of the window in screen coordinates, or
///          `SDL_WINDOWPOS_CENTERED` or `SDL_WINDOWPOS_UNDEFINED`.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetWindowPosition
/// @see SDL_SyncWindow
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetWindowPosition(SDL_Window *window, int x, int y);
/// ```
pub extern "C" fn sdl_SetWindowPosition(
  window : SDL_Window,
  x : Int,
  y : Int,
) -> Bool = "SDL_SetWindowPosition"

///|
/// Get the position of a window.
/// 
/// This is the current position of the window as last reported by the
/// windowing system.
/// 
/// If you do not need the value for one of the positions a NULL may be passed
/// in the `x` or `y` parameter.
/// 
/// @param window the window to query.
/// @param x a pointer filled in with the x position of the window, in screen
///          coordinates, may be NULL.
/// @param y a pointer filled in with the y position of the window, in screen
///          coordinates, may be NULL.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_SetWindowPosition
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetWindowPosition(SDL_Window *window, int *x, int *y);
/// ```
#owned(x, y)
pub extern "C" fn sdl_GetWindowPosition(
  window : SDL_Window,
  x : FixedArray[Int],
  y : FixedArray[Int],
) -> Bool = "SDL_GetWindowPosition"

///|
/// Request that the size of a window's client area be set.
/// 
/// If, at the time of this request, the window in a fixed-size state, such as
/// maximized or fullscreen, the request will be deferred until the window
/// exits this state and becomes resizable again.
/// 
/// To change the fullscreen mode of a window, use
/// SDL_SetWindowFullscreenMode()
/// 
/// On some windowing systems, this request is asynchronous and the new window
/// size may not have have been applied immediately upon the return of this
/// function. If an immediate change is required, call SDL_SyncWindow() to
/// block until the changes have taken effect.
/// 
/// When the window size changes, an SDL_EVENT_WINDOW_RESIZED event will be
/// emitted with the new window dimensions. Note that the new dimensions may
/// not match the exact size requested, as some windowing systems can restrict
/// the window size in certain scenarios (e.g. constraining the size of the
/// content area to remain within the usable desktop area). Additionally, as
/// this is just a request, it can be denied by the windowing system.
/// 
/// @param window the window to change.
/// @param w the width of the window in pixels, in screen coordinates, must be
///          > 0.
/// @param h the height of the window in pixels, in screen coordinates, must be
///          > 0.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetWindowSize
/// @see SDL_SetWindowDisplayMode
/// @see SDL_SetWindowFullscreenMode
/// @see SDL_SyncWindow
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetWindowSize(SDL_Window *window, int w, int h);
/// ```
pub extern "C" fn sdl_SetWindowSize(
  window : SDL_Window,
  w : Int,
  h : Int,
) -> Bool = "SDL_SetWindowSize"

///|
/// Get the size of a window's client area.
/// 
/// NULL can safely be passed as the `w` or `h` parameter if the width or
/// height value is not desired.
/// 
/// The window pixel size may differ from its window coordinate size if the
/// window is on a high pixel density display. Use SDL_GetWindowSizeInPixels()
/// or SDL_GetRenderOutputSize() to get the real client area size in pixels.
/// 
/// @param window the window to query the width and height from.
/// @param w a pointer filled in with the width of the window, in screen
///          coordinates, may be NULL.
/// @param h a pointer filled in with the height of the window, in screen
///          coordinates, may be NULL.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetRenderOutputSize
/// @see SDL_GetWindowSizeInPixels
/// @see SDL_SetWindowSize
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetWindowSize(SDL_Window *window, int *w, int *h);
/// ```
#owned(w, h)
pub extern "C" fn sdl_GetWindowSize(
  window : SDL_Window,
  w : FixedArray[Int],
  h : FixedArray[Int],
) -> Bool = "SDL_GetWindowSize"

///|
/// Show a window.
/// 
/// @param window the window to show.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_HideWindow
/// @see SDL_WindowHidden
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_ShowWindow(SDL_Window *window);
/// ```
pub extern "C" fn sdl_ShowWindow(window : SDL_Window) -> Bool = "SDL_ShowWindow"

///|
/// Hide a window.
/// 
/// @param window the window to hide.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_ShowWindow
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HideWindow(SDL_Window *window);
/// ```
pub extern "C" fn sdl_HideWindow(window : SDL_Window) -> Bool = "SDL_HideWindow"

///|
/// Request that a window be raised above other windows and gain the input focus.
/// 
/// The result of this request is subject to desktop window manager policy,
/// particularly if raising the requested window would result in stealing focus
/// from another application. If the window is successfully raised and gains
/// input focus, an SDL_EVENT_WINDOW_FOCUS_GAINED event will be emitted.
/// 
/// @param window the window to raise.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RaiseWindow(SDL_Window *window);
/// ```
pub extern "C" fn sdl_RaiseWindow(window : SDL_Window) -> Bool = "SDL_RaiseWindow"

///|
/// Request that the window be made as large as possible.
/// 
/// Non-resizable windows can't be maximized. The window must have the
/// SDL_WINDOW_RESIZABLE flag set, or this will have no effect.
/// 
/// On some windowing systems this request is asynchronous and the new window
/// state may not have have been applied immediately upon the return of this
/// function. If an immediate change is required, call SDL_SyncWindow() to
/// block until the changes have taken effect.
/// 
/// When the window state changes, an SDL_EVENT_WINDOW_MAXIMIZED event will be
/// emitted. Note that, as this is just a request, the windowing system can
/// deny the state change.
/// 
/// When maximizing a window, whether the constraints set via
/// SDL_SetWindowMaximumSize() are honored depends on the policy of the window
/// manager. Win32 and macOS enforce the constraints when maximizing, while X11
/// and Wayland window managers may vary.
/// 
/// @param window the window to maximize.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_MinimizeWindow
/// @see SDL_RestoreWindow
/// @see SDL_SyncWindow
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_MaximizeWindow(SDL_Window *window);
/// ```
pub extern "C" fn sdl_MaximizeWindow(window : SDL_Window) -> Bool = "SDL_MaximizeWindow"

///|
/// Request that the window be minimized to an iconic representation.
/// 
/// On some windowing systems this request is asynchronous and the new window
/// state may not have have been applied immediately upon the return of this
/// function. If an immediate change is required, call SDL_SyncWindow() to
/// block until the changes have taken effect.
/// 
/// When the window state changes, an SDL_EVENT_WINDOW_MINIMIZED event will be
/// emitted. Note that, as this is just a request, the windowing system can
/// deny the state change.
/// 
/// @param window the window to minimize.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_MaximizeWindow
/// @see SDL_RestoreWindow
/// @see SDL_SyncWindow
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_MinimizeWindow(SDL_Window *window);
/// ```
pub extern "C" fn sdl_MinimizeWindow(window : SDL_Window) -> Bool = "SDL_MinimizeWindow"

///|
/// Request that the size and position of a minimized or maximized window be
/// restored.
/// 
/// On some windowing systems this request is asynchronous and the new window
/// state may not have have been applied immediately upon the return of this
/// function. If an immediate change is required, call SDL_SyncWindow() to
/// block until the changes have taken effect.
/// 
/// When the window state changes, an SDL_EVENT_WINDOW_RESTORED event will be
/// emitted. Note that, as this is just a request, the windowing system can
/// deny the state change.
/// 
/// @param window the window to restore.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_MaximizeWindow
/// @see SDL_MinimizeWindow
/// @see SDL_SyncWindow
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RestoreWindow(SDL_Window *window);
/// ```
pub extern "C" fn sdl_RestoreWindow(window : SDL_Window) -> Bool = "SDL_RestoreWindow"

///|
/// Request that the window's fullscreen state be changed.
/// 
/// By default a window in fullscreen state uses fullscreen desktop mode, but a
/// specific exclusive display mode can be set using
/// SDL_SetWindowFullscreenMode().
/// 
/// On some windowing systems this request is asynchronous and the new
/// fullscreen state may not have have been applied immediately upon the
/// return of this function. If an immediate change is required, call
/// SDL_SyncWindow() to block until the changes have taken effect.
/// 
/// When the window state changes, an SDL_EVENT_WINDOW_ENTER_FULLSCREEN or
/// SDL_EVENT_WINDOW_LEAVE_FULLSCREEN event will be emitted. Note that, as
/// this is just a request, it can be denied by the windowing system.
/// 
/// @param window the window to change.
/// @param fullscreen true for fullscreen mode, false for windowed mode.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetWindowFullscreenMode
/// @see SDL_SetWindowFullscreenMode
/// @see SDL_SyncWindow
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetWindowFullscreen(SDL_Window *window, bool fullscreen);
/// ```
pub extern "C" fn sdl_SetWindowFullscreen(
  window : SDL_Window,
  fullscreen : Bool,
) -> Bool = "SDL_SetWindowFullscreen"

///|
/// Block until any pending window state is finalized.
/// 
/// On asynchronous windowing systems, this acts as a synchronization fence for
/// pending window state. It will attempt to wait until any pending window
/// state has been applied and is guaranteed to return within finite time. Note
/// that for how long it can potentially block depends on the underlying window
/// system, but this function should only be called in situations where an
/// immediate synchronization is required, such as for unit tests or
/// compatibility with synchronous windowing systems.
/// 
/// @param window the window for which to wait for the pending state to be
///               applied.
/// @return true on success, false if the operation timed out before the
///          window was in the requested state.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_SetWindowSize
/// @see SDL_SetWindowPosition
/// @see SDL_SetWindowFullscreen
/// @see SDL_MinimizeWindow
/// @see SDL_MaximizeWindow
/// @see SDL_RestoreWindow
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SyncWindow(SDL_Window *window);
/// ```
pub extern "C" fn sdl_SyncWindow(window : SDL_Window) -> Bool = "SDL_SyncWindow"

///|
/// Destroy a window.
/// 
/// If `window` is NULL, this function will return immediately after setting
/// the SDL error message to "Invalid window". See SDL_GetError().
/// 
/// The window is implicitly hidden, any child windows are recursively
/// destroyed, and associated resources are freed by this function.
/// 
/// @param window the window to destroy.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_CreatePopupWindow
/// @see SDL_CreateWindow
/// @see SDL_CreateWindowWithProperties
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_DestroyWindow(SDL_Window *window);
/// ```
pub extern "C" fn sdl_DestroyWindow(window : SDL_Window) = "SDL_DestroyWindow"

// OpenGL functions

///|
/// Dynamically load an OpenGL library.
/// 
/// @param path the platform dependent OpenGL library name, or NULL to open the
///             default OpenGL library.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GL_GetProcAddress
/// @see SDL_GL_UnloadLibrary
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GL_LoadLibrary(const char *path);
/// ```
pub fn sdl_GL_LoadLibrary(path : String) -> Bool {
  __sdl_GL_LoadLibrary(string_to_cbytes(path))
}

///|
#owned(path)
extern "C" fn __sdl_GL_LoadLibrary(path : Bytes) -> Bool = "SDL_GL_LoadLibrary"

///|
/// Get an OpenGL function by name.
/// 
/// If the GL library is loaded via SDL_GL_LoadLibrary(), this function
/// returns a pointer to the named OpenGL function. The returned function may
/// be called even if there is no current GL context.
/// 
/// @param proc the name of an OpenGL function.
/// @return a pointer to the named OpenGL function or NULL on failure; call
///          SDL_GetError() for more information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GL_ExtensionSupported
/// @see SDL_GL_LoadLibrary
/// @see SDL_GL_UnloadLibrary
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_FunctionPointer SDLCALL SDL_GL_GetProcAddress(const char *proc);
/// ```
pub fn sdl_GL_GetProcAddress(proc : String) -> VoidPtr {
  __sdl_GL_GetProcAddress(string_to_cbytes(proc))
}

///|
#owned(proc)
extern "C" fn __sdl_GL_GetProcAddress(proc : Bytes) -> VoidPtr = "SDL_GL_GetProcAddress" // SDL_FunctionPointer is void*

///|
/// Get an EGL library function by name.
/// 
/// If an EGL library is loaded, this function returns a pointer to the named
/// EGL function. This function should only be called if an EGL library has
/// been loaded, otherwise the results are undefined.
/// 
/// @param proc the name of an EGL function.
/// @return a pointer to the named EGL function or NULL on failure; call
///          SDL_GetError() for more information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_FunctionPointer SDLCALL SDL_EGL_GetProcAddress(const char *proc);
/// ```
pub fn sdl_EGL_GetProcAddress(proc : String) -> VoidPtr {
  __sdl_EGL_GetProcAddress(string_to_cbytes(proc))
}

///|
#owned(proc)
extern "C" fn __sdl_EGL_GetProcAddress(proc : Bytes) -> VoidPtr = "SDL_EGL_GetProcAddress" // SDL_FunctionPointer is void*

///|
/// Unload the OpenGL library previously loaded by SDL_GL_LoadLibrary().
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GL_LoadLibrary
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_GL_UnloadLibrary(void);
/// ```
pub extern "C" fn sdl_GL_UnloadLibrary() = "SDL_GL_UnloadLibrary"

///|
/// Check if an OpenGL extension is supported.
/// 
/// This function operates on the current GL context.
/// 
/// @param extension the name of the extension to check.
/// @return true if the extension is supported, false otherwise.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GL_ExtensionSupported(const char *extension);
/// ```
pub fn sdl_GL_ExtensionSupported(extension : String) -> Bool {
  __sdl_GL_ExtensionSupported(string_to_cbytes(extension))
}

///|
#owned(extension)
extern "C" fn __sdl_GL_ExtensionSupported(extension : Bytes) -> Bool = "SDL_GL_ExtensionSupported"

///|
/// Reset all previously set OpenGL context attributes to their default values.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GL_GetAttribute
/// @see SDL_GL_SetAttribute
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_GL_ResetAttributes(void);
/// ```
pub extern "C" fn sdl_GL_ResetAttributes() = "SDL_GL_ResetAttributes"

///|
/// Set an OpenGL window attribute before window creation.
/// 
/// This function sets the OpenGL attribute `attr` to `value`. The requested
/// attributes should be set before creating an OpenGL window. You should use
/// SDL_GL_GetAttribute() to check the values after creating the OpenGL
/// context, since the values obtained can differ from the requested ones.
/// 
/// @param attr an SDL_GLAttr enum value specifying the OpenGL attribute to set.
/// @param value the desired value for the attribute.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GL_GetAttribute
/// @see SDL_GL_ResetAttributes
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GL_SetAttribute(SDL_GLAttr attr, int value);
/// ```
pub extern "C" fn sdl_GL_SetAttribute(attr : SDL_GLAttr, value : Int) -> Bool = "SDL_GL_SetAttribute"

///|
/// Get the actual value for an attribute from the current context.
/// 
/// @param attr an SDL_GLAttr enum value specifying the OpenGL attribute to get.
/// @param value a pointer filled in with the current value of `attr`.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GL_ResetAttributes
/// @see SDL_GL_SetAttribute
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GL_GetAttribute(SDL_GLAttr attr, int *value);
/// ```
#owned(value)
pub extern "C" fn sdl_GL_GetAttribute(
  attr : SDL_GLAttr,
  value : FixedArray[Int],
) -> Bool = "SDL_GL_GetAttribute"

///|
/// Create an OpenGL context for an OpenGL window, and make it current.
/// 
/// Windows users new to OpenGL should note that, for historical reasons, GL
/// functions added after OpenGL version 1.1 are not available by default.
/// Those functions must be loaded at run-time, either with an OpenGL
/// extension-handling library or with SDL_GL_GetProcAddress() and its related
/// functions.
/// 
/// SDL_GLContext is an alias for `void *`. It's opaque to the application.
/// 
/// @param window the window to associate with the context.
/// @return the OpenGL context associated with `window` or NULL on failure;
///          call SDL_GetError() for more information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GL_DestroyContext
/// @see SDL_GL_MakeCurrent
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_GLContext SDLCALL SDL_GL_CreateContext(SDL_Window *window);
/// ```
pub extern "C" fn sdl_GL_CreateContext(window : SDL_Window) -> SDL_GLContext = "SDL_GL_CreateContext"

///|
/// Set up an OpenGL context for rendering into an OpenGL window.
/// 
/// The context must have been created with a compatible window.
/// 
/// @param window the window to associate with the context.
/// @param context the OpenGL context to associate with the window.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GL_CreateContext
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GL_MakeCurrent(SDL_Window *window, SDL_GLContext context);
/// ```
pub extern "C" fn sdl_GL_MakeCurrent(
  window : SDL_Window,
  context : SDL_GLContext,
) -> Bool = "SDL_GL_MakeCurrent"

///|
/// Get the currently active OpenGL context.
/// 
/// @return the currently active OpenGL context or NULL on failure; call
///          SDL_GetError() for more information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GL_MakeCurrent
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_GLContext SDLCALL SDL_GL_GetCurrentContext(void);
/// ```
pub extern "C" fn sdl_GL_GetCurrentContext() -> SDL_GLContext = "SDL_GL_GetCurrentContext"

///|
/// Get the currently active OpenGL window.
/// 
/// @return the currently active OpenGL window on success or NULL on failure;
///          call SDL_GetError() for more information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_Window * SDLCALL SDL_GL_GetCurrentWindow(void);
/// ```
pub extern "C" fn sdl_GL_GetCurrentWindow() -> SDL_Window = "SDL_GL_GetCurrentWindow"

///|
/// Set the swap interval for the current OpenGL context.
/// 
/// Some systems allow specifying -1 for the interval, to enable adaptive
/// vsync. Adaptive vsync works the same as vsync, but if you've already missed
/// the vertical retrace for a given frame, it swaps buffers immediately, which
/// might be less jarring for the user during occasional framerate drops. If
/// an application requests adaptive vsync and the system does not support it,
/// this function will fail and return false. In such a case, you should
/// probably retry the call with 1 for the interval.
/// 
/// Adaptive vsync is implemented for some glX drivers with
/// GLX_EXT_swap_control_tear, and for some Windows drivers with
/// WGL_EXT_swap_control_tear.
/// 
/// Read more on the Khronos wiki:
/// https://www.khronos.org/opengl/wiki/Swap_Interval#Adaptive_Vsync
/// 
/// @param interval 0 for immediate updates, 1 for updates synchronized with
///                 the vertical retrace, -1 for adaptive vsync.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GL_GetSwapInterval
/// @see SDL_GL_SwapWindow
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GL_SetSwapInterval(int interval);
/// ```
pub extern "C" fn sdl_GL_SetSwapInterval(interval : Int) -> Bool = "SDL_GL_SetSwapInterval"

///|
/// Get the swap interval for the current OpenGL context.
/// 
/// If the system can't determine the swap interval, or there isn't a valid
/// current context, this function will set *interval to 0 as a safe default.
/// 
/// @param interval output interval value. 0 if there is no vertical retrace
///                 synchronization, 1 if the buffer swap is synchronized with
///                 the vertical retrace, and -1 if late swaps happen
///                 immediately instead of waiting for the next retrace.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GL_SetSwapInterval
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GL_GetSwapInterval(int *interval);
/// ```
#owned(interval)
pub extern "C" fn sdl_GL_GetSwapInterval(interval : FixedArray[Int]) -> Bool = "SDL_GL_GetSwapInterval"

///|
/// Update a window with OpenGL rendering.
/// 
/// This is used with double-buffered OpenGL contexts, which are the default.
/// 
/// On macOS, make sure you bind 0 to the draw framebuffer before swapping the
/// window, otherwise nothing will happen. If you aren't using
/// glBindFramebuffer(), this is the default and you won't have to do anything
/// extra.
/// 
/// @param window the window to change.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GL_SetSwapInterval
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GL_SwapWindow(SDL_Window *window);
/// ```
pub extern "C" fn sdl_GL_SwapWindow(window : SDL_Window) -> Bool = "SDL_GL_SwapWindow"

///|
/// Delete an OpenGL context.
/// 
/// @param context the OpenGL context to be deleted.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GL_CreateContext
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GL_DestroyContext(SDL_GLContext context);
/// ```
pub extern "C" fn sdl_GL_DestroyContext(context : SDL_GLContext) -> Bool = "SDL_GL_DestroyContext"
