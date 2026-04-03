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

///|
/// # CategoryGamepad
///
/// SDL provides a low-level joystick API, which just treats joysticks as an
/// arbitrary pile of buttons, axes, and hat switches. If you're planning to
/// write your own control configuration screen, this can give you a lot of
/// flexibility, but that's a lot of work, and most things that we consider
/// "joysticks" now are actually console-style gamepads. So SDL provides the
/// gamepad API on top of the lower-level joystick functionality.
#external
pub type SDL_Gamepad

///|
/// Standard gamepad types.
///
/// ```c
/// typedef enum SDL_GamepadType
/// {
///     SDL_GAMEPAD_TYPE_UNKNOWN = 0,
///     SDL_GAMEPAD_TYPE_STANDARD,
///     SDL_GAMEPAD_TYPE_XBOX360,
///     SDL_GAMEPAD_TYPE_XBOXONE,
///     SDL_GAMEPAD_TYPE_PS3,
///     SDL_GAMEPAD_TYPE_PS4,
///     SDL_GAMEPAD_TYPE_PS5,
///     SDL_GAMEPAD_TYPE_NINTENDO_SWITCH_PRO,
///     SDL_GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_LEFT,
///     SDL_GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_RIGHT,
///     SDL_GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_PAIR,
///     SDL_GAMEPAD_TYPE_GAMECUBE,
///     SDL_GAMEPAD_TYPE_COUNT
/// } SDL_GamepadType;
/// ```
pub(all) enum SDL_GamepadType {
  SDL_GAMEPAD_TYPE_UNKNOWN
  SDL_GAMEPAD_TYPE_STANDARD
  SDL_GAMEPAD_TYPE_XBOX360
  SDL_GAMEPAD_TYPE_XBOXONE
  SDL_GAMEPAD_TYPE_PS3
  SDL_GAMEPAD_TYPE_PS4
  SDL_GAMEPAD_TYPE_PS5
  SDL_GAMEPAD_TYPE_NINTENDO_SWITCH_PRO
  SDL_GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_LEFT
  SDL_GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_RIGHT
  SDL_GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_PAIR
  SDL_GAMEPAD_TYPE_GAMECUBE
  SDL_GAMEPAD_TYPE_COUNT
}

///|
/// The list of buttons available on a gamepad
///
/// ```c
/// typedef enum SDL_GamepadButton
/// {
///     SDL_GAMEPAD_BUTTON_INVALID = -1,
///     SDL_GAMEPAD_BUTTON_SOUTH,           /**< Bottom face button (e.g. Xbox A button) */
///     SDL_GAMEPAD_BUTTON_EAST,            /**< Right face button (e.g. Xbox B button) */
///     SDL_GAMEPAD_BUTTON_WEST,            /**< Left face button (e.g. Xbox X button) */
///     SDL_GAMEPAD_BUTTON_NORTH,           /**< Top face button (e.g. Xbox Y button) */
///     SDL_GAMEPAD_BUTTON_BACK,
///     SDL_GAMEPAD_BUTTON_GUIDE,
///     SDL_GAMEPAD_BUTTON_START,
///     SDL_GAMEPAD_BUTTON_LEFT_STICK,
///     SDL_GAMEPAD_BUTTON_RIGHT_STICK,
///     SDL_GAMEPAD_BUTTON_LEFT_SHOULDER,
///     SDL_GAMEPAD_BUTTON_RIGHT_SHOULDER,
///     SDL_GAMEPAD_BUTTON_DPAD_UP,
///     SDL_GAMEPAD_BUTTON_DPAD_DOWN,
///     SDL_GAMEPAD_BUTTON_DPAD_LEFT,
///     SDL_GAMEPAD_BUTTON_DPAD_RIGHT,
///     SDL_GAMEPAD_BUTTON_MISC1,           /**< Additional button (e.g. Xbox Series X share button, PS5 microphone button, Nintendo Switch Pro capture button, Amazon Luna microphone button, Google Stadia capture button) */
///     SDL_GAMEPAD_BUTTON_RIGHT_PADDLE1,   /**< Upper or primary paddle, under your right hand (e.g. Xbox Elite paddle P1) */
///     SDL_GAMEPAD_BUTTON_LEFT_PADDLE1,    /**< Upper or primary paddle, under your left hand (e.g. Xbox Elite paddle P3) */
///     SDL_GAMEPAD_BUTTON_RIGHT_PADDLE2,   /**< Lower or secondary paddle, under your right hand (e.g. Xbox Elite paddle P2) */
///     SDL_GAMEPAD_BUTTON_LEFT_PADDLE2,    /**< Lower or secondary paddle, under your left hand (e.g. Xbox Elite paddle P4) */
///     SDL_GAMEPAD_BUTTON_TOUCHPAD,        /**< PS4/PS5 touchpad button */
///     SDL_GAMEPAD_BUTTON_MISC2,           /**< Additional button */
///     SDL_GAMEPAD_BUTTON_MISC3,           /**< Additional button */
///     SDL_GAMEPAD_BUTTON_MISC4,           /**< Additional button */
///     SDL_GAMEPAD_BUTTON_MISC5,           /**< Additional button */
///     SDL_GAMEPAD_BUTTON_MISC6,           /**< Additional button */
///     SDL_GAMEPAD_BUTTON_COUNT
/// } SDL_GamepadButton;
/// ```
pub(all) enum SDL_GamepadButton {
  SDL_GAMEPAD_BUTTON_SOUTH
  SDL_GAMEPAD_BUTTON_EAST
  SDL_GAMEPAD_BUTTON_WEST
  SDL_GAMEPAD_BUTTON_NORTH
  SDL_GAMEPAD_BUTTON_BACK
  SDL_GAMEPAD_BUTTON_GUIDE
  SDL_GAMEPAD_BUTTON_START
  SDL_GAMEPAD_BUTTON_LEFT_STICK
  SDL_GAMEPAD_BUTTON_RIGHT_STICK
  SDL_GAMEPAD_BUTTON_LEFT_SHOULDER
  SDL_GAMEPAD_BUTTON_RIGHT_SHOULDER
  SDL_GAMEPAD_BUTTON_DPAD_UP
  SDL_GAMEPAD_BUTTON_DPAD_DOWN
  SDL_GAMEPAD_BUTTON_DPAD_LEFT
  SDL_GAMEPAD_BUTTON_DPAD_RIGHT
  SDL_GAMEPAD_BUTTON_MISC1
  SDL_GAMEPAD_BUTTON_RIGHT_PADDLE1
  SDL_GAMEPAD_BUTTON_LEFT_PADDLE1
  SDL_GAMEPAD_BUTTON_RIGHT_PADDLE2
  SDL_GAMEPAD_BUTTON_LEFT_PADDLE2
  SDL_GAMEPAD_BUTTON_TOUCHPAD
  SDL_GAMEPAD_BUTTON_MISC2
  SDL_GAMEPAD_BUTTON_MISC3
  SDL_GAMEPAD_BUTTON_MISC4
  SDL_GAMEPAD_BUTTON_MISC5
  SDL_GAMEPAD_BUTTON_MISC6
  SDL_GAMEPAD_BUTTON_COUNT
  SDL_GAMEPAD_BUTTON_INVALID = 0xffff_ffff
}

///|
/// The set of gamepad button labels
///
/// ```c
/// typedef enum SDL_GamepadButtonLabel
/// {
///     SDL_GAMEPAD_BUTTON_LABEL_UNKNOWN,
///     SDL_GAMEPAD_BUTTON_LABEL_A,
///     SDL_GAMEPAD_BUTTON_LABEL_B,
///     SDL_GAMEPAD_BUTTON_LABEL_X,
///     SDL_GAMEPAD_BUTTON_LABEL_Y,
///     SDL_GAMEPAD_BUTTON_LABEL_CROSS,
///     SDL_GAMEPAD_BUTTON_LABEL_CIRCLE,
///     SDL_GAMEPAD_BUTTON_LABEL_SQUARE,
///     SDL_GAMEPAD_BUTTON_LABEL_TRIANGLE
/// } SDL_GamepadButtonLabel;
/// ```
pub(all) enum SDL_GamepadButtonLabel {
  SDL_GAMEPAD_BUTTON_LABEL_UNKNOWN
  SDL_GAMEPAD_BUTTON_LABEL_A
  SDL_GAMEPAD_BUTTON_LABEL_B
  SDL_GAMEPAD_BUTTON_LABEL_X
  SDL_GAMEPAD_BUTTON_LABEL_Y
  SDL_GAMEPAD_BUTTON_LABEL_CROSS
  SDL_GAMEPAD_BUTTON_LABEL_CIRCLE
  SDL_GAMEPAD_BUTTON_LABEL_SQUARE
  SDL_GAMEPAD_BUTTON_LABEL_TRIANGLE
}

///|
/// The list of axes available on a gamepad
///
/// ```c
/// typedef enum SDL_GamepadAxis
/// {
///     SDL_GAMEPAD_AXIS_INVALID = -1,
///     SDL_GAMEPAD_AXIS_LEFTX,
///     SDL_GAMEPAD_AXIS_LEFTY,
///     SDL_GAMEPAD_AXIS_RIGHTX,
///     SDL_GAMEPAD_AXIS_RIGHTY,
///     SDL_GAMEPAD_AXIS_LEFT_TRIGGER,
///     SDL_GAMEPAD_AXIS_RIGHT_TRIGGER,
///     SDL_GAMEPAD_AXIS_COUNT
/// } SDL_GamepadAxis;
/// ```
pub(all) enum SDL_GamepadAxis {
  SDL_GAMEPAD_AXIS_LEFTX
  SDL_GAMEPAD_AXIS_LEFTY
  SDL_GAMEPAD_AXIS_RIGHTX
  SDL_GAMEPAD_AXIS_RIGHTY
  SDL_GAMEPAD_AXIS_LEFT_TRIGGER
  SDL_GAMEPAD_AXIS_RIGHT_TRIGGER
  SDL_GAMEPAD_AXIS_COUNT
  SDL_GAMEPAD_AXIS_INVALID = 0xffff_ffff
}

///|
/// Types of gamepad control bindings.
///
/// ```c
/// typedef enum SDL_GamepadBindingType
/// {
///     SDL_GAMEPAD_BINDTYPE_NONE = 0,
///     SDL_GAMEPAD_BINDTYPE_BUTTON,
///     SDL_GAMEPAD_BINDTYPE_AXIS,
///     SDL_GAMEPAD_BINDTYPE_HAT
/// } SDL_GamepadBindingType;
/// ```
pub(all) enum SDL_GamepadBindingType {
  SDL_GAMEPAD_BINDTYPE_NONE
  SDL_GAMEPAD_BINDTYPE_BUTTON
  SDL_GAMEPAD_BINDTYPE_AXIS
  SDL_GAMEPAD_BINDTYPE_HAT
}

///|
/// A mapping between one joystick input to a gamepad control.
///
/// ```c
/// typedef struct SDL_GamepadBinding
/// {
///     SDL_GamepadBindingType input_type;
///     union
///     {
///         int button;
///
///         struct
///         {
///             int axis;
///             int axis_min;
///             int axis_max;
///         } axis;
///
///         struct
///         {
///             int hat;
///             int hat_mask;
///         } hat;
///
///     } input;
///
///     SDL_GamepadBindingType output_type;
///     union
///     {
///         SDL_GamepadButton button;
///
///         struct
///         {
///             SDL_GamepadAxis axis;
///             int axis_min;
///             int axis_max;
///         } axis;
///
///     } output;
/// } SDL_GamepadBinding;
/// ```
pub(all) struct SDL_GamepadBinding {
  // Opaque struct, not directly accessible
}

///| Add support for gamepads that SDL is unaware of or change the binding of an

///|
/// existing gamepad.
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_AddGamepadMapping(const char *mapping);
/// ```
#owned(mapping)
extern "C" fn __sdl_AddGamepadMapping(mapping : Bytes) -> Int = "SDL_AddGamepadMapping"

///|
pub fn sdl_AddGamepadMapping(mapping : String) -> Int {
  let c_mapping = string_to_cbytes(mapping)
  __sdl_AddGamepadMapping(c_mapping)
}

///|
/// Load a set of gamepad mappings from an SDL_IOStream.
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_AddGamepadMappingsFromIO(SDL_IOStream *src, bool closeio);
/// ```
pub extern "C" fn sdl_AddGamepadMappingsFromIO(
  src : SDL_IOStream,
  closeio : Bool,
) -> Int = "SDL_AddGamepadMappingsFromIO"

///|
/// Load a set of gamepad mappings from a file.
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_AddGamepadMappingsFromFile(const char *file);
/// ```
#owned(file)
extern "C" fn __sdl_AddGamepadMappingsFromFile(file : Bytes) -> Int = "SDL_AddGamepadMappingsFromFile"

///|
pub fn sdl_AddGamepadMappingsFromFile(file : String) -> Int {
  let c_file = string_to_cbytes(file)
  __sdl_AddGamepadMappingsFromFile(c_file)
}

///|
/// Reinitialize the SDL mapping database to its initial state.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_ReloadGamepadMappings(void);
/// ```
pub extern "C" fn sdl_ReloadGamepadMappings() -> Bool = "SDL_ReloadGamepadMappings"

///|
/// Get the current gamepad mappings.
///
/// ```c
/// extern SDL_DECLSPEC char ** SDLCALL SDL_GetGamepadMappings(int *count);
/// ```
#owned(count)
extern "C" fn __sdl_GetGamepadMappings(
  count : FixedArray[Int],
) -> FixedArray[CStr] = "SDL_GetGamepadMappings"

///|
pub fn sdl_GetGamepadMappings() -> (Array[String], Int) {
  let count = FixedArray::make(1, 0)
  let c_mappings = __sdl_GetGamepadMappings(count)
  let mappings = Array::new()
  for i = 0; i < count[0]; i = i + 1 {
    mappings.push(c_mappings[i].to_string())
  }
  (mappings, count[0])
}

///|
/// Get the gamepad mapping string for a given GUID.
///
/// ```c
/// extern SDL_DECLSPEC char * SDLCALL SDL_GetGamepadMappingForGUID(SDL_GUID guid);
/// ```
extern "C" fn __sdl_GetGamepadMappingForGUID(guid : SDL_GUID) -> CStr = "SDL_GetGamepadMappingForGUID"

///|
pub fn sdl_GetGamepadMappingForGUID(guid : SDL_GUID) -> String {
  let cstr = __sdl_GetGamepadMappingForGUID(guid)
  let res = cstr.to_string()
  free_cstr(cstr)
  res
}

///|
/// Get the current mapping of a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC char * SDLCALL SDL_GetGamepadMapping(SDL_Gamepad *gamepad);
/// ```
extern "C" fn __sdl_GetGamepadMapping(gamepad : SDL_Gamepad) -> CStr = "SDL_GetGamepadMapping"

///|
pub fn sdl_GetGamepadMapping(gamepad : SDL_Gamepad) -> String {
  let cstr = __sdl_GetGamepadMapping(gamepad)
  let res = cstr.to_string()
  free_cstr(cstr)
  res
}

///|
/// Set the current mapping of a joystick or gamepad.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetGamepadMapping(SDL_JoystickID instance_id, const char *mapping);
/// ```
#owned(mapping)
extern "C" fn __sdl_SetGamepadMapping(
  instance_id : SDL_JoystickID,
  mapping : Bytes,
) -> Bool = "SDL_SetGamepadMapping"

///|
pub fn sdl_SetGamepadMapping(
  instance_id : SDL_JoystickID,
  mapping : String,
) -> Bool {
  let c_mapping = string_to_cbytes(mapping)
  __sdl_SetGamepadMapping(instance_id, c_mapping)
}

///|
/// Return whether a gamepad is currently connected.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasGamepad(void);
/// ```
pub extern "C" fn sdl_HasGamepad() -> Bool = "SDL_HasGamepad"

///|
/// Get a list of currently connected gamepads.
///
/// ```c
/// extern SDL_DECLSPEC SDL_JoystickID * SDLCALL SDL_GetGamepads(int *count);
/// ```
#owned(count)
extern "C" fn __sdl_GetGamepads(
  count : FixedArray[Int],
) -> FixedArray[SDL_JoystickID] = "SDL_GetGamepads"

///|
pub fn sdl_GetGamepads() -> (Array[SDL_JoystickID], Int) {
  let count = FixedArray::make(1, 0)
  let ids = __sdl_GetGamepads(count)
  let res = Array::new()
  for i = 0; i < count[0]; i = i + 1 {
    res.push(ids[i])
  }
  (res, count[0])
}

///|
/// Check if the given joystick is supported by the gamepad interface.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_IsGamepad(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_IsGamepad(instance_id : SDL_JoystickID) -> Bool = "SDL_IsGamepad"

///|
/// Get the implementation dependent name of a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetGamepadNameForID(SDL_JoystickID instance_id);
/// ```
extern "C" fn __sdl_GetGamepadNameForID(instance_id : SDL_JoystickID) -> CStr = "SDL_GetGamepadNameForID"

///|
pub fn sdl_GetGamepadNameForID(instance_id : SDL_JoystickID) -> String {
  let cstr = __sdl_GetGamepadNameForID(instance_id)
  let res = cstr.to_string()
  // Do not free cstr, it's a pointer to internal SDL memory
  res
}

///|
/// Get the implementation dependent path of a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetGamepadPathForID(SDL_JoystickID instance_id);
/// ```
extern "C" fn __sdl_GetGamepadPathForID(instance_id : SDL_JoystickID) -> CStr = "SDL_GetGamepadPathForID"

///|
pub fn sdl_GetGamepadPathForID(instance_id : SDL_JoystickID) -> String {
  let cstr = __sdl_GetGamepadPathForID(instance_id)
  let res = cstr.to_string()
  // Do not free cstr, it's a pointer to internal SDL memory
  res
}

///|
/// Get the player index of a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetGamepadPlayerIndexForID(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_GetGamepadPlayerIndexForID(
  instance_id : SDL_JoystickID,
) -> Int = "SDL_GetGamepadPlayerIndexForID"

///|
/// Get the implementation-dependent GUID of a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC SDL_GUID SDLCALL SDL_GetGamepadGUIDForID(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_GetGamepadGUIDForID(
  instance_id : SDL_JoystickID,
) -> SDL_GUID = "SDL_GetGamepadGUIDForID"

///|
/// Get the USB vendor ID of a gamepad, if available.
///
/// ```c
/// extern SDL_DECLSPEC Uint16 SDLCALL SDL_GetGamepadVendorForID(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_GetGamepadVendorForID(
  instance_id : SDL_JoystickID,
) -> UInt16 = "SDL_GetGamepadVendorForID"

///|
/// Get the USB product ID of a gamepad, if available.
///
/// ```c
/// extern SDL_DECLSPEC Uint16 SDLCALL SDL_GetGamepadProductForID(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_GetGamepadProductForID(
  instance_id : SDL_JoystickID,
) -> UInt16 = "SDL_GetGamepadProductForID"

///|
/// Get the product version of a gamepad, if available.
///
/// ```c
/// extern SDL_DECLSPEC Uint16 SDLCALL SDL_GetGamepadProductVersionForID(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_GetGamepadProductVersionForID(
  instance_id : SDL_JoystickID,
) -> UInt16 = "SDL_GetGamepadProductVersionForID"

///|
/// Get the type of a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC SDL_GamepadType SDLCALL SDL_GetGamepadTypeForID(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_GetGamepadTypeForID(
  instance_id : SDL_JoystickID,
) -> SDL_GamepadType = "SDL_GetGamepadTypeForID"

///|
/// Get the type of a gamepad, ignoring any mapping override.
///
/// ```c
/// extern SDL_DECLSPEC SDL_GamepadType SDLCALL SDL_GetRealGamepadTypeForID(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_GetRealGamepadTypeForID(
  instance_id : SDL_JoystickID,
) -> SDL_GamepadType = "SDL_GetRealGamepadTypeForID"

///|
/// Get the mapping of a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC char * SDLCALL SDL_GetGamepadMappingForID(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn __sdl_GetGamepadMappingForID(
  instance_id : SDL_JoystickID,
) -> CStr = "SDL_GetGamepadMappingForID"

///|
pub fn sdl_GetGamepadMappingForID(instance_id : SDL_JoystickID) -> String {
  let cstr = __sdl_GetGamepadMappingForID(instance_id)
  let res = cstr.to_string()
  free_cstr(cstr)
  res
}

///|
/// Open a gamepad for use.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Gamepad * SDLCALL SDL_OpenGamepad(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_OpenGamepad(instance_id : SDL_JoystickID) -> SDL_Gamepad = "SDL_OpenGamepad"

///| Get the SDL_Gamepad associated with a joystick instance ID, if it has been

///|
/// opened.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Gamepad * SDLCALL SDL_GetGamepadFromID(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_GetGamepadFromID(
  instance_id : SDL_JoystickID,
) -> SDL_Gamepad = "SDL_GetGamepadFromID"

///|
/// Get the SDL_Gamepad associated with a player index.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Gamepad * SDLCALL SDL_GetGamepadFromPlayerIndex(int player_index);
/// ```
pub extern "C" fn sdl_GetGamepadFromPlayerIndex(
  player_index : Int,
) -> SDL_Gamepad = "SDL_GetGamepadFromPlayerIndex"

///|
/// Get the properties associated with an opened gamepad.
///
/// ```c
/// extern SDL_DECLSPEC SDL_PropertiesID SDLCALL SDL_GetGamepadProperties(SDL_Gamepad *gamepad);
/// ```
pub extern "C" fn sdl_GetGamepadProperties(
  gamepad : SDL_Gamepad,
) -> SDL_PropertiesID = "SDL_GetGamepadProperties"

///|
/// Get the instance ID of an opened gamepad.
///
/// ```c
/// extern SDL_DECLSPEC SDL_JoystickID SDLCALL SDL_GetGamepadID(SDL_Gamepad *gamepad);
/// ```
pub extern "C" fn sdl_GetGamepadID(gamepad : SDL_Gamepad) -> SDL_JoystickID = "SDL_GetGamepadID"

///|
/// Get the implementation-dependent name for an opened gamepad.
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetGamepadName(SDL_Gamepad *gamepad);
/// ```
extern "C" fn __sdl_GetGamepadName(gamepad : SDL_Gamepad) -> CStr = "SDL_GetGamepadName"

///|
pub fn sdl_GetGamepadName(gamepad : SDL_Gamepad) -> String {
  let cstr = __sdl_GetGamepadName(gamepad)
  let res = cstr.to_string()
  // Do not free cstr, it's a pointer to internal SDL memory
  res
}

///|
/// Get the implementation-dependent path for an opened gamepad.
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetGamepadPath(SDL_Gamepad *gamepad);
/// ```
extern "C" fn __sdl_GetGamepadPath(gamepad : SDL_Gamepad) -> CStr = "SDL_GetGamepadPath"

///|
pub fn sdl_GetGamepadPath(gamepad : SDL_Gamepad) -> String {
  let cstr = __sdl_GetGamepadPath(gamepad)
  let res = cstr.to_string()
  // Do not free cstr, it's a pointer to internal SDL memory
  res
}

///|
/// Get the type of an opened gamepad.
///
/// ```c
/// extern SDL_DECLSPEC SDL_GamepadType SDLCALL SDL_GetGamepadType(SDL_Gamepad *gamepad);
/// ```
pub extern "C" fn sdl_GetGamepadType(gamepad : SDL_Gamepad) -> SDL_GamepadType = "SDL_GetGamepadType"

///|
/// Get the type of an opened gamepad, ignoring any mapping override.
///
/// ```c
/// extern SDL_DECLSPEC SDL_GamepadType SDLCALL SDL_GetRealGamepadType(SDL_Gamepad *gamepad);
/// ```
pub extern "C" fn sdl_GetRealGamepadType(
  gamepad : SDL_Gamepad,
) -> SDL_GamepadType = "SDL_GetRealGamepadType"

///|
/// Get the player index of an opened gamepad.
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetGamepadPlayerIndex(SDL_Gamepad *gamepad);
/// ```
pub extern "C" fn sdl_GetGamepadPlayerIndex(gamepad : SDL_Gamepad) -> Int = "SDL_GetGamepadPlayerIndex"

///|
/// Set the player index of an opened gamepad.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetGamepadPlayerIndex(SDL_Gamepad *gamepad, int player_index);
/// ```
pub extern "C" fn sdl_SetGamepadPlayerIndex(
  gamepad : SDL_Gamepad,
  player_index : Int,
) -> Bool = "SDL_SetGamepadPlayerIndex"

///|
/// Get the USB vendor ID of an opened gamepad, if available.
///
/// ```c
/// extern SDL_DECLSPEC Uint16 SDLCALL SDL_GetGamepadVendor(SDL_Gamepad *gamepad);
/// ```
pub extern "C" fn sdl_GetGamepadVendor(gamepad : SDL_Gamepad) -> UInt16 = "SDL_GetGamepadVendor"

///|
/// Get the USB product ID of an opened gamepad, if available.
///
/// ```c
/// extern SDL_DECLSPEC Uint16 SDLCALL SDL_GetGamepadProduct(SDL_Gamepad *gamepad);
/// ```
pub extern "C" fn sdl_GetGamepadProduct(gamepad : SDL_Gamepad) -> UInt16 = "SDL_GetGamepadProduct"

///|
/// Get the product version of an opened gamepad, if available.
///
/// ```c
/// extern SDL_DECLSPEC Uint16 SDLCALL SDL_GetGamepadProductVersion(SDL_Gamepad *gamepad);
/// ```
pub extern "C" fn sdl_GetGamepadProductVersion(gamepad : SDL_Gamepad) -> UInt16 = "SDL_GetGamepadProductVersion"

///|
/// Get the firmware version of an opened gamepad, if available.
///
/// ```c
/// extern SDL_DECLSPEC Uint16 SDLCALL SDL_GetGamepadFirmwareVersion(SDL_Gamepad *gamepad);
/// ```
pub extern "C" fn sdl_GetGamepadFirmwareVersion(
  gamepad : SDL_Gamepad,
) -> UInt16 = "SDL_GetGamepadFirmwareVersion"

///|
/// Get the serial number of an opened gamepad, if available.
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetGamepadSerial(SDL_Gamepad *gamepad);
/// ```
extern "C" fn __sdl_GetGamepadSerial(gamepad : SDL_Gamepad) -> CStr = "SDL_GetGamepadSerial"

///|
pub fn sdl_GetGamepadSerial(gamepad : SDL_Gamepad) -> String {
  let cstr = __sdl_GetGamepadSerial(gamepad)
  let res = cstr.to_string()
  // Do not free cstr, it's a pointer to internal SDL memory
  res
}

///|
/// Get the Steam Input handle of an opened gamepad, if available.
///
/// ```c
/// extern SDL_DECLSPEC Uint64 SDLCALL SDL_GetGamepadSteamHandle(SDL_Gamepad *gamepad);
/// ```
pub extern "C" fn sdl_GetGamepadSteamHandle(gamepad : SDL_Gamepad) -> UInt64 = "SDL_GetGamepadSteamHandle"

///|
/// Get the connection state of a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC SDL_JoystickConnectionState SDLCALL SDL_GetGamepadConnectionState(SDL_Gamepad *gamepad);
/// ```
pub extern "C" fn sdl_GetGamepadConnectionState(
  gamepad : SDL_Gamepad,
) -> SDL_JoystickConnectionState = "SDL_GetGamepadConnectionState"

///|
/// Get the battery state of a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC SDL_PowerState SDLCALL SDL_GetGamepadPowerInfo(SDL_Gamepad *gamepad, int *percent);
/// ```
#owned(percent)
extern "C" fn __sdl_GetGamepadPowerInfo(
  gamepad : SDL_Gamepad,
  percent : FixedArray[Int],
) -> SDL_PowerState = "SDL_GetGamepadPowerInfo"

///|
pub fn sdl_GetGamepadPowerInfo(gamepad : SDL_Gamepad) -> (SDL_PowerState, Int) {
  let percent = FixedArray::make(1, 0)
  let state = __sdl_GetGamepadPowerInfo(gamepad, percent)
  (state, percent[0])
}

///|
/// Check if a gamepad has been opened and is currently connected.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GamepadConnected(SDL_Gamepad *gamepad);
/// ```
pub extern "C" fn sdl_GamepadConnected(gamepad : SDL_Gamepad) -> Bool = "SDL_GamepadConnected"

///|
/// Get the underlying joystick from a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Joystick * SDLCALL SDL_GetGamepadJoystick(SDL_Gamepad *gamepad);
/// ```
pub extern "C" fn sdl_GetGamepadJoystick(gamepad : SDL_Gamepad) -> SDL_Joystick = "SDL_GetGamepadJoystick"

///|
/// Set the state of gamepad event processing.
///
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_SetGamepadEventsEnabled(bool enabled);
/// ```
pub extern "C" fn sdl_SetGamepadEventsEnabled(enabled : Bool) -> Unit = "SDL_SetGamepadEventsEnabled"

///|
/// Query the state of gamepad event processing.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GamepadEventsEnabled(void);
/// ```
pub extern "C" fn sdl_GamepadEventsEnabled() -> Bool = "SDL_GamepadEventsEnabled"

///|
/// Get the SDL joystick layer bindings for a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC SDL_GamepadBinding ** SDLCALL SDL_GetGamepadBindings(SDL_Gamepad *gamepad, int *count);
/// ```
#owned(count)
extern "C" fn __sdl_GetGamepadBindings(
  gamepad : SDL_Gamepad,
  count : FixedArray[Int],
) -> FixedArray[SDL_GamepadBinding] = "SDL_GetGamepadBindings"

///|
pub fn sdl_GetGamepadBindings(
  gamepad : SDL_Gamepad,
) -> (Array[SDL_GamepadBinding], Int) {
  let count = FixedArray::make(1, 0)
  let bindings = __sdl_GetGamepadBindings(gamepad, count)
  let res = Array::new()
  for i = 0; i < count[0]; i = i + 1 {
    res.push(bindings[i])
  }
  (res, count[0])
}

///|
/// Manually pump gamepad updates if not using the loop.
///
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_UpdateGamepads(void);
/// ```
pub extern "C" fn sdl_UpdateGamepads() -> Unit = "SDL_UpdateGamepads"

///|
/// Convert a string into SDL_GamepadType enum.
///
/// ```c
/// extern SDL_DECLSPEC SDL_GamepadType SDLCALL SDL_GetGamepadTypeFromString(const char *str);
/// ```
#owned(str)
extern "C" fn __sdl_GetGamepadTypeFromString(str : Bytes) -> SDL_GamepadType = "SDL_GetGamepadTypeFromString"

///|
pub fn sdl_GetGamepadTypeFromString(str : String) -> SDL_GamepadType {
  let c_str = string_to_cbytes(str)
  __sdl_GetGamepadTypeFromString(c_str)
}

///|
/// Convert from an SDL_GamepadType enum to a string.
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetGamepadStringForType(SDL_GamepadType type);
/// ```
pub extern "C" fn __sdl_GetGamepadStringForType(
  type_ : SDL_GamepadType,
) -> CStr = "SDL_GetGamepadStringForType"

///|
pub fn sdl_GetGamepadStringForType(type_ : SDL_GamepadType) -> String {
  let cstr = __sdl_GetGamepadStringForType(type_)
  let res = cstr.to_string()
  // Do not free cstr, it's a pointer to internal SDL memory
  res
}

///|
/// Convert a string into SDL_GamepadAxis enum.
///
/// ```c
/// extern SDL_DECLSPEC SDL_GamepadAxis SDLCALL SDL_GetGamepadAxisFromString(const char *str);
/// ```
#owned(str)
extern "C" fn __sdl_GetGamepadAxisFromString(str : Bytes) -> SDL_GamepadAxis = "SDL_GetGamepadAxisFromString"

///|
pub fn sdl_GetGamepadAxisFromString(str : String) -> SDL_GamepadAxis {
  let c_str = string_to_cbytes(str)
  __sdl_GetGamepadAxisFromString(c_str)
}

///|
/// Convert from an SDL_GamepadAxis enum to a string.
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetGamepadStringForAxis(SDL_GamepadAxis axis);
/// ```
extern "C" fn __sdl_GetGamepadStringForAxis(axis : SDL_GamepadAxis) -> CStr = "SDL_GetGamepadStringForAxis"

///|
pub fn sdl_GetGamepadStringForAxis(axis : SDL_GamepadAxis) -> String {
  let cstr = __sdl_GetGamepadStringForAxis(axis)
  let res = cstr.to_string()
  // Do not free cstr, it's a pointer to internal SDL memory
  res
}

///|
/// Query whether a gamepad has a given axis.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GamepadHasAxis(SDL_Gamepad *gamepad, SDL_GamepadAxis axis);
/// ```
pub extern "C" fn sdl_GamepadHasAxis(
  gamepad : SDL_Gamepad,
  axis : SDL_GamepadAxis,
) -> Bool = "SDL_GamepadHasAxis"

///|
/// Get the current state of an axis control on a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC Sint16 SDLCALL SDL_GetGamepadAxis(SDL_Gamepad *gamepad, SDL_GamepadAxis axis);
/// ```
pub extern "C" fn sdl_GetGamepadAxis(
  gamepad : SDL_Gamepad,
  axis : SDL_GamepadAxis,
) -> Int16 = "SDL_GetGamepadAxis"

///|
/// Convert a string into an SDL_GamepadButton enum.
///
/// ```c
/// extern SDL_DECLSPEC SDL_GamepadButton SDLCALL SDL_GetGamepadButtonFromString(const char *str);
/// ```
#owned(str)
extern "C" fn __sdl_GetGamepadButtonFromString(
  str : Bytes,
) -> SDL_GamepadButton = "SDL_GetGamepadButtonFromString"

///|
pub fn sdl_GetGamepadButtonFromString(str : String) -> SDL_GamepadButton {
  let c_str = string_to_cbytes(str)
  __sdl_GetGamepadButtonFromString(c_str)
}

///|
/// Convert from an SDL_GamepadButton enum to a string.
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetGamepadStringForButton(SDL_GamepadButton button);
/// ```
extern "C" fn __sdl_GetGamepadStringForButton(
  button : SDL_GamepadButton,
) -> CStr = "SDL_GetGamepadStringForButton"

///|
pub fn sdl_GetGamepadStringForButton(button : SDL_GamepadButton) -> String {
  let cstr = __sdl_GetGamepadStringForButton(button)
  let res = cstr.to_string()
  // Do not free cstr, it's a pointer to internal SDL memory
  res
}

///|
/// Query whether a gamepad has a given button.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GamepadHasButton(SDL_Gamepad *gamepad, SDL_GamepadButton button);
/// ```
pub extern "C" fn sdl_GamepadHasButton(
  gamepad : SDL_Gamepad,
  button : SDL_GamepadButton,
) -> Bool = "SDL_GamepadHasButton"

///|
/// Get the current state of a button on a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetGamepadButton(SDL_Gamepad *gamepad, SDL_GamepadButton button);
/// ```
pub extern "C" fn sdl_GetGamepadButton(
  gamepad : SDL_Gamepad,
  button : SDL_GamepadButton,
) -> Bool = "SDL_GetGamepadButton"

///|
/// Get the label of a button on a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC SDL_GamepadButtonLabel SDLCALL SDL_GetGamepadButtonLabelForType(SDL_GamepadType type, SDL_GamepadButton button);
/// ```
pub extern "C" fn sdl_GetGamepadButtonLabelForType(
  type_ : SDL_GamepadType,
  button : SDL_GamepadButton,
) -> SDL_GamepadButtonLabel = "SDL_GetGamepadButtonLabelForType"

///|
/// Get the label of a button on a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC SDL_GamepadButtonLabel SDLCALL SDL_GetGamepadButtonLabel(SDL_Gamepad *gamepad, SDL_GamepadButton button);
/// ```
pub extern "C" fn sdl_GetGamepadButtonLabel(
  gamepad : SDL_Gamepad,
  button : SDL_GamepadButton,
) -> SDL_GamepadButtonLabel = "SDL_GetGamepadButtonLabel"

///|
/// Get the number of touchpads on a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetNumGamepadTouchpads(SDL_Gamepad *gamepad);
/// ```
pub extern "C" fn sdl_GetNumGamepadTouchpads(gamepad : SDL_Gamepad) -> Int = "SDL_GetNumGamepadTouchpads"

///| Get the number of supported simultaneous fingers on a touchpad on a game

///|
/// gamepad.
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetNumGamepadTouchpadFingers(SDL_Gamepad *gamepad, int touchpad);
/// ```
pub extern "C" fn sdl_GetNumGamepadTouchpadFingers(
  gamepad : SDL_Gamepad,
  touchpad : Int,
) -> Int = "SDL_GetNumGamepadTouchpadFingers"

///|
/// Get the current state of a finger on a touchpad on a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetGamepadTouchpadFinger(SDL_Gamepad *gamepad, int touchpad, int finger, bool *down, float *x, float *y, float *pressure);
/// ```
#owned(down, x, y, pressure)
extern "C" fn __sdl_GetGamepadTouchpadFinger(
  gamepad : SDL_Gamepad,
  touchpad : Int,
  finger : Int,
  down : FixedArray[Bool],
  x : FixedArray[Float],
  y : FixedArray[Float],
  pressure : FixedArray[Float],
) -> Bool = "SDL_GetGamepadTouchpadFinger"

///|
pub fn sdl_GetGamepadTouchpadFinger(
  gamepad : SDL_Gamepad,
  touchpad : Int,
  finger : Int,
) -> (Bool, Bool, Float, Float, Float) {
  let down = FixedArray::make(1, false)
  let x : FixedArray[Float] = FixedArray::make(1, 0.0)
  let y : FixedArray[Float] = FixedArray::make(1, 0.0)
  let pressure : FixedArray[Float] = FixedArray::make(1, 0.0)
  let success = __sdl_GetGamepadTouchpadFinger(
    gamepad, touchpad, finger, down, x, y, pressure,
  )
  (success, down[0], x[0], y[0], pressure[0])
}

///|
/// Return whether a gamepad has a particular sensor.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GamepadHasSensor(SDL_Gamepad *gamepad, SDL_SensorType type);
/// ```
pub extern "C" fn sdl_GamepadHasSensor(
  gamepad : SDL_Gamepad,
  type_ : SDL_SensorType,
) -> Bool = "SDL_GamepadHasSensor"

///|
/// Set whether data reporting for a gamepad sensor is enabled.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetGamepadSensorEnabled(SDL_Gamepad *gamepad, SDL_SensorType type, bool enabled);
/// ```
pub extern "C" fn sdl_SetGamepadSensorEnabled(
  gamepad : SDL_Gamepad,
  type_ : SDL_SensorType,
  enabled : Bool,
) -> Bool = "SDL_SetGamepadSensorEnabled"

///|
/// Query whether sensor data reporting is enabled for a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GamepadSensorEnabled(SDL_Gamepad *gamepad, SDL_SensorType type);
/// ```
pub extern "C" fn sdl_GamepadSensorEnabled(
  gamepad : SDL_Gamepad,
  type_ : SDL_SensorType,
) -> Bool = "SDL_GamepadSensorEnabled"

///|
/// Get the data rate (number of events per second) of a gamepad sensor.
///
/// ```c
/// extern SDL_DECLSPEC float SDLCALL SDL_GetGamepadSensorDataRate(SDL_Gamepad *gamepad, SDL_SensorType type);
/// ```
pub extern "C" fn sdl_GetGamepadSensorDataRate(
  gamepad : SDL_Gamepad,
  type_ : SDL_SensorType,
) -> Float = "SDL_GetGamepadSensorDataRate"

///|
/// Get the current state of a gamepad sensor.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetGamepadSensorData(SDL_Gamepad *gamepad, SDL_SensorType type, float *data, int num_values);
/// ```
#owned(data)
pub extern "C" fn __sdl_GetGamepadSensorData(
  gamepad : SDL_Gamepad,
  type_ : SDL_SensorType,
  data : FixedArray[Float],
  num_values : Int,
) -> Bool = "SDL_GetGamepadSensorData"

///|
pub fn sdl_GetGamepadSensorData(
  gamepad : SDL_Gamepad,
  type_ : SDL_SensorType,
  num_values : Int,
) -> (Bool, Array[Float]) {
  let data : FixedArray[Float] = FixedArray::make(num_values, 0.0)
  let success = __sdl_GetGamepadSensorData(gamepad, type_, data, num_values)
  let res = Array::new()
  for i = 0; i < num_values; i = i + 1 {
    res.push(data[i])
  }
  (success, res)
}

///|
/// Start a rumble effect on a gamepad.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RumbleGamepad(SDL_Gamepad *gamepad, Uint16 low_frequency_rumble, Uint16 high_frequency_rumble, Uint32 duration_ms);
/// ```
pub extern "C" fn sdl_RumbleGamepad(
  gamepad : SDL_Gamepad,
  low_frequency_rumble : UInt16,
  high_frequency_rumble : UInt16,
  duration_ms : UInt,
) -> Bool = "SDL_RumbleGamepad"

///|
/// Start a rumble effect in the gamepad's triggers.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RumbleGamepadTriggers(SDL_Gamepad *gamepad, Uint16 left_rumble, Uint16 right_rumble, Uint32 duration_ms);
/// ```
pub extern "C" fn sdl_RumbleGamepadTriggers(
  gamepad : SDL_Gamepad,
  left_rumble : UInt16,
  right_rumble : UInt16,
  duration_ms : UInt,
) -> Bool = "SDL_RumbleGamepadTriggers"

///|
/// Update a gamepad's LED color.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetGamepadLED(SDL_Gamepad *gamepad, Uint8 red, Uint8 green, Uint8 blue);
/// ```
pub extern "C" fn sdl_SetGamepadLED(
  gamepad : SDL_Gamepad,
  red : Byte,
  green : Byte,
  blue : Byte,
) -> Bool = "SDL_SetGamepadLED"

///|
/// Send a gamepad specific effect packet.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SendGamepadEffect(SDL_Gamepad *gamepad, const void *data, int size);
/// ```
pub extern "C" fn sdl_SendGamepadEffect(
  gamepad : SDL_Gamepad,
  data : VoidPtr,
  size : Int,
) -> Bool = "SDL_SendGamepadEffect"

///|
/// Close a gamepad previously opened with SDL_OpenGamepad().
///
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_CloseGamepad(SDL_Gamepad *gamepad);
/// ```
pub extern "C" fn sdl_CloseGamepad(gamepad : SDL_Gamepad) -> Unit = "SDL_CloseGamepad"

///| Return the sfSymbolsName for a given button on a gamepad on Apple

///|
/// platforms.
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetGamepadAppleSFSymbolsNameForButton(SDL_Gamepad *gamepad, SDL_GamepadButton button);
/// ```
extern "C" fn __sdl_GetGamepadAppleSFSymbolsNameForButton(
  gamepad : SDL_Gamepad,
  button : SDL_GamepadButton,
) -> CStr = "SDL_GetGamepadAppleSFSymbolsNameForButton"

///|
pub fn sdl_GetGamepadAppleSFSymbolsNameForButton(
  gamepad : SDL_Gamepad,
  button : SDL_GamepadButton,
) -> String {
  let cstr = __sdl_GetGamepadAppleSFSymbolsNameForButton(gamepad, button)
  let res = cstr.to_string()
  // Do not free cstr, it's a pointer to internal SDL memory
  res
}

///|
/// Return the sfSymbolsName for a given axis on a gamepad on Apple platforms.
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetGamepadAppleSFSymbolsNameForAxis(SDL_Gamepad *gamepad, SDL_GamepadAxis axis);
/// ```
extern "C" fn __sdl_GetGamepadAppleSFSymbolsNameForAxis(
  gamepad : SDL_Gamepad,
  axis : SDL_GamepadAxis,
) -> CStr = "SDL_GetGamepadAppleSFSymbolsNameForAxis"

///|
pub fn sdl_GetGamepadAppleSFSymbolsNameForAxis(
  gamepad : SDL_Gamepad,
  axis : SDL_GamepadAxis,
) -> String {
  let cstr = __sdl_GetGamepadAppleSFSymbolsNameForAxis(gamepad, axis)
  let res = cstr.to_string()
  // Do not free cstr, it's a pointer to internal SDL memory
  res
}
