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

/// # CategoryJoystick
///
/// SDL joystick support.

#external
pub type SDL_Joystick

///| This is a unique ID for a joystick for the time it is connected to the
///| system, and is never reused for the lifetime of the application.
///
/// ```c
/// typedef Uint32 SDL_JoystickID;
/// ```
pub typealias UInt as SDL_JoystickID

///| An enum of some common joystick types.
///
/// ```c
/// typedef enum SDL_JoystickType
/// {
///     SDL_JOYSTICK_TYPE_UNKNOWN,
///     SDL_JOYSTICK_TYPE_GAMEPAD,
///     SDL_JOYSTICK_TYPE_WHEEL,
///     SDL_JOYSTICK_TYPE_ARCADE_STICK,
///     SDL_JOYSTICK_TYPE_FLIGHT_STICK,
///     SDL_JOYSTICK_TYPE_DANCE_PAD,
///     SDL_JOYSTICK_TYPE_GUITAR,
///     SDL_JOYSTICK_TYPE_DRUM_KIT,
///     SDL_JOYSTICK_TYPE_ARCADE_PAD,
///     SDL_JOYSTICK_TYPE_THROTTLE,
///     SDL_JOYSTICK_TYPE_COUNT
/// } SDL_JoystickType;
/// ```
pub(all) enum SDL_JoystickType {
  SDL_JOYSTICK_TYPE_UNKNOWN
  SDL_JOYSTICK_TYPE_GAMEPAD
  SDL_JOYSTICK_TYPE_WHEEL
  SDL_JOYSTICK_TYPE_ARCADE_STICK
  SDL_JOYSTICK_TYPE_FLIGHT_STICK
  SDL_JOYSTICK_TYPE_DANCE_PAD
  SDL_JOYSTICK_TYPE_GUITAR
  SDL_JOYSTICK_TYPE_DRUM_KIT
  SDL_JOYSTICK_TYPE_ARCADE_PAD
  SDL_JOYSTICK_TYPE_THROTTLE
  SDL_JOYSTICK_TYPE_COUNT
}

///| Possible connection states for a joystick device.
///
/// ```c
/// typedef enum SDL_JoystickConnectionState
/// {
///     SDL_JOYSTICK_CONNECTION_INVALID = -1,
///     SDL_JOYSTICK_CONNECTION_UNKNOWN,
///     SDL_JOYSTICK_CONNECTION_WIRED,
///     SDL_JOYSTICK_CONNECTION_WIRELESS
/// } SDL_JoystickConnectionState;
/// ```
pub(all) enum SDL_JoystickConnectionState {
  SDL_JOYSTICK_CONNECTION_UNKNOWN
  SDL_JOYSTICK_CONNECTION_WIRED
  SDL_JOYSTICK_CONNECTION_WIRELESS
  SDL_JOYSTICK_CONNECTION_INVALID = 0xffff_ffff
}

///| The largest value an SDL_Joystick's axis can report.
///
/// ```c
/// #define SDL_JOYSTICK_AXIS_MAX   32767
/// ```
pub const SDL_JOYSTICK_AXIS_MAX : Int = 32767

///| The smallest value an SDL_Joystick's axis can report.
///
/// ```c
/// #define SDL_JOYSTICK_AXIS_MIN   -32768
/// ```
pub const SDL_JOYSTICK_AXIS_MIN : Int = -32768

///| Locking for atomic access to the joystick API.
///
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_LockJoysticks(void) SDL_ACQUIRE(SDL_joystick_lock);
/// ```
pub extern "C" fn sdl_LockJoysticks() -> Unit = "SDL_LockJoysticks"

///| Unlocking for atomic access to the joystick API.
///
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_UnlockJoysticks(void) SDL_RELEASE(SDL_joystick_lock);
/// ```
pub extern "C" fn sdl_UnlockJoysticks() -> Unit = "SDL_UnlockJoysticks"

///| Return whether a joystick is currently connected.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasJoystick(void);
/// ```
pub extern "C" fn sdl_HasJoystick() -> Bool = "SDL_HasJoystick"

///| Get a list of currently connected joysticks.
///
/// ```c
/// extern SDL_DECLSPEC SDL_JoystickID * SDLCALL SDL_GetJoysticks(int *count);
/// ```
pub extern "C" fn __sdl_GetJoysticks(count: FixedArray[Int]) -> FixedArray[SDL_JoystickID] = "SDL_GetJoysticks"

pub fn sdl_GetJoysticks() -> (Array[SDL_JoystickID], Int) {
  let count = FixedArray::make(1, 0)
  let ids = __sdl_GetJoysticks(count)
  let res = Array::new()
  for i = 0; i < count[0]; i = i + 1 {
    res.push(ids[i])
  }
  (res, count[0])
}

///| Get the implementation dependent name of a joystick.
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetJoystickNameForID(SDL_JoystickID instance_id);
/// ```
extern "C" fn __sdl_GetJoystickNameForID(instance_id: SDL_JoystickID) -> CStr = "SDL_GetJoystickNameForID"

pub fn sdl_GetJoystickNameForID(instance_id: SDL_JoystickID) -> String {
  let cstr = __sdl_GetJoystickNameForID(instance_id)
  let res = cstr.to_string()
  // Do not free cstr, it's a pointer to internal SDL memory
  res
}

///| Get the implementation dependent path of a joystick.
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetJoystickPathForID(SDL_JoystickID instance_id);
/// ```
extern "C" fn __sdl_GetJoystickPathForID(instance_id: SDL_JoystickID) -> CStr = "SDL_GetJoystickPathForID"

pub fn sdl_GetJoystickPathForID(instance_id: SDL_JoystickID) -> String {
  let cstr = __sdl_GetJoystickPathForID(instance_id)
  let res = cstr.to_string()
  // Do not free cstr, it's a pointer to internal SDL memory
  res
}

///| Get the player index of a joystick.
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetJoystickPlayerIndexForID(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_GetJoystickPlayerIndexForID(instance_id: SDL_JoystickID) -> Int = "SDL_GetJoystickPlayerIndexForID"

///| Get the implementation-dependent GUID of a joystick.
///
/// ```c
/// extern SDL_DECLSPEC SDL_GUID SDLCALL SDL_GetJoystickGUIDForID(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_GetJoystickGUIDForID(instance_id: SDL_JoystickID) -> SDL_GUID = "SDL_GetJoystickGUIDForID"

///| Get the USB vendor ID of a joystick, if available.
///
/// ```c
/// extern SDL_DECLSPEC Uint16 SDLCALL SDL_GetJoystickVendorForID(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_GetJoystickVendorForID(instance_id: SDL_JoystickID) -> UInt16 = "SDL_GetJoystickVendorForID"

///| Get the USB product ID of a joystick, if available.
///
/// ```c
/// extern SDL_DECLSPEC Uint16 SDLCALL SDL_GetJoystickProductForID(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_GetJoystickProductForID(instance_id: SDL_JoystickID) -> UInt16 = "SDL_GetJoystickProductForID"

///| Get the product version of a joystick, if available.
///
/// ```c
/// extern SDL_DECLSPEC Uint16 SDLCALL SDL_GetJoystickProductVersionForID(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_GetJoystickProductVersionForID(instance_id: SDL_JoystickID) -> UInt16 = "SDL_GetJoystickProductVersionForID"

///| Get the type of a joystick, if available.
///
/// ```c
/// extern SDL_DECLSPEC SDL_JoystickType SDLCALL SDL_GetJoystickTypeForID(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_GetJoystickTypeForID(instance_id: SDL_JoystickID) -> SDL_JoystickType = "SDL_GetJoystickTypeForID"

///| Open a joystick for use.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Joystick * SDLCALL SDL_OpenJoystick(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_OpenJoystick(instance_id: SDL_JoystickID) -> SDL_Joystick = "SDL_OpenJoystick"

///| Get the SDL_Joystick associated with an instance ID, if it has been opened.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Joystick * SDLCALL SDL_GetJoystickFromID(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_GetJoystickFromID(instance_id: SDL_JoystickID) -> SDL_Joystick = "SDL_GetJoystickFromID"

///| Get the SDL_Joystick associated with a player index.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Joystick * SDLCALL SDL_GetJoystickFromPlayerIndex(int player_index);
/// ```
pub extern "C" fn sdl_GetJoystickFromPlayerIndex(player_index: Int) -> SDL_Joystick = "SDL_GetJoystickFromPlayerIndex"

///| The structure that describes a virtual joystick touchpad.
///
/// ```c
/// typedef struct SDL_VirtualJoystickTouchpadDesc
/// {
///     Uint16 nfingers;    /**< the number of simultaneous fingers on this touchpad */
///     Uint16 padding[3];
/// } SDL_VirtualJoystickTouchpadDesc;
/// ```
pub(all) struct SDL_VirtualJoystickTouchpadDesc {
  nfingers: UInt16
}

///| The structure that describes a virtual joystick sensor.
///
/// ```c
/// typedef struct SDL_VirtualJoystickSensorDesc
/// {
///     SDL_SensorType type;    /**< the type of this sensor */
///     float rate;             /**< the update frequency of this sensor, may be 0.0f */
/// } SDL_VirtualJoystickSensorDesc;
/// ```
pub(all) struct SDL_VirtualJoystickSensorDesc {
  type_: SDL_SensorType
  rate: Float
}

///| The structure that describes a virtual joystick.
///
/// ```c
/// typedef struct SDL_VirtualJoystickDesc
/// {
///     Uint32 version;     /**< the version of this interface */
///     Uint16 type;        /**< `SDL_JoystickType` */
///     Uint16 padding;     /**< unused */
///     Uint16 vendor_id;   /**< the USB vendor ID of this joystick */
///     Uint16 product_id;  /**< the USB product ID of this joystick */
///     Uint16 naxes;       /**< the number of axes on this joystick */
///     Uint16 nbuttons;    /**< the number of buttons on this joystick */
///     Uint16 nballs;      /**< the number of balls on this joystick */
///     Uint16 nhats;       /**< the number of hats on this joystick */
///     Uint16 ntouchpads;  /**< the number of touchpads on this joystick, requires `touchpads` to point at valid descriptions */
///     Uint16 nsensors;    /**< the number of sensors on this joystick, requires `sensors` to point at valid descriptions */
///     Uint16 padding2[2]; /**< unused */
///     Uint32 button_mask; /**< A mask of which buttons are valid for this controller
///                              e.g. (1 << SDL_GAMEPAD_BUTTON_SOUTH) */
///     Uint32 axis_mask;   /**< A mask of which axes are valid for this controller
///                              e.g. (1 << SDL_GAMEPAD_AXIS_LEFTX) */
///     const char *name;   /**< the name of the joystick */
///     const SDL_VirtualJoystickTouchpadDesc *touchpads;   /**< A pointer to an array of touchpad descriptions, required if `ntouchpads` is > 0 */
///     const SDL_VirtualJoystickSensorDesc *sensors;       /**< A pointer to an array of sensor descriptions, required if `nsensors` is > 0 */
///
///     void *userdata;     /**< User data pointer passed to callbacks */
///     void (SDLCALL *Update)(void *userdata); /**< Called when the joystick state should be updated */
///     void (SDLCALL *SetPlayerIndex)(void *userdata, int player_index); /**< Called when the player index is set */
///     bool (SDLCALL *Rumble)(void *userdata, Uint16 low_frequency_rumble, Uint16 high_frequency_rumble); /**< Implements SDL_RumbleJoystick() */
///     bool (SDLCALL *RumbleTriggers)(void *userdata, Uint16 left_rumble, Uint16 right_rumble); /**< Implements SDL_RumbleJoystickTriggers() */
///     bool (SDLCALL *SetLED)(void *userdata, Uint8 red, Uint8 green, Uint8 blue); /**< Implements SDL_SetJoystickLED() */
///     bool (SDLCALL *SendEffect)(void *userdata, const void *data, int size); /**< Implements SDL_SendJoystickEffect() */
///     bool (SDLCALL *SetSensorsEnabled)(void *userdata, bool enabled); /**< Implements SDL_SetGamepadSensorEnabled() */
///     void (SDLCALL *Cleanup)(void *userdata); /**< Cleans up the userdata when the joystick is detached */
/// } SDL_VirtualJoystickDesc;
/// ```
pub(all) struct SDL_VirtualJoystickDesc {
  // Opaque struct, not directly accessible
}

///| Attach a new virtual joystick.
///
/// ```c
/// extern SDL_DECLSPEC SDL_JoystickID SDLCALL SDL_AttachVirtualJoystick(const SDL_VirtualJoystickDesc *desc);
/// ```
pub extern "C" fn sdl_AttachVirtualJoystick(desc: SDL_VirtualJoystickDesc) -> SDL_JoystickID = "SDL_AttachVirtualJoystick"

///| Detach a virtual joystick.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_DetachVirtualJoystick(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_DetachVirtualJoystick(instance_id: SDL_JoystickID) -> Bool = "SDL_DetachVirtualJoystick"

///| Query whether or not a joystick is virtual.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_IsJoystickVirtual(SDL_JoystickID instance_id);
/// ```
pub extern "C" fn sdl_IsJoystickVirtual(instance_id: SDL_JoystickID) -> Bool = "SDL_IsJoystickVirtual"

///| Set the state of an axis on an opened virtual joystick.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetJoystickVirtualAxis(SDL_Joystick *joystick, int axis, Sint16 value);
/// ```
pub extern "C" fn sdl_SetJoystickVirtualAxis(joystick: SDL_Joystick, axis: Int, value: Int16) -> Bool = "SDL_SetJoystickVirtualAxis"

///| Generate ball motion on an opened virtual joystick.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetJoystickVirtualBall(SDL_Joystick *joystick, int ball, Sint16 xrel, Sint16 yrel);
/// ```
pub extern "C" fn sdl_SetJoystickVirtualBall(joystick: SDL_Joystick, ball: Int, xrel: Int16, yrel: Int16) -> Bool = "SDL_SetJoystickVirtualBall"

///| Set the state of a button on an opened virtual joystick.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetJoystickVirtualButton(SDL_Joystick *joystick, int button, bool down);
/// ```
pub extern "C" fn sdl_SetJoystickVirtualButton(joystick: SDL_Joystick, button: Int, down: Bool) -> Bool = "SDL_SetJoystickVirtualButton"

///| Set the state of a hat on an opened virtual joystick.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetJoystickVirtualHat(SDL_Joystick *joystick, int hat, Uint8 value);
/// ```
pub extern "C" fn sdl_SetJoystickVirtualHat(joystick: SDL_Joystick, hat: Int, value: Byte) -> Bool = "SDL_SetJoystickVirtualHat"

///| Set touchpad finger state on an opened virtual joystick.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetJoystickVirtualTouchpad(SDL_Joystick *joystick, int touchpad, int finger, bool down, float x, float y, float pressure);
/// ```
pub extern "C" fn sdl_SetJoystickVirtualTouchpad(joystick: SDL_Joystick, touchpad: Int, finger: Int, down: Bool, x: Float, y: Float, pressure: Float) -> Bool = "SDL_SetJoystickVirtualTouchpad"

///| Send a sensor update for an opened virtual joystick.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SendJoystickVirtualSensorData(SDL_Joystick *joystick, SDL_SensorType type, Uint64 sensor_timestamp, const float *data, int num_values);
/// ```
pub extern "C" fn __sdl_SendJoystickVirtualSensorData(joystick: SDL_Joystick, type_: SDL_SensorType, sensor_timestamp: UInt64, data: FixedArray[Float], num_values: Int) -> Bool = "SDL_SendJoystickVirtualSensorData"

pub fn sdl_SendJoystickVirtualSensorData(joystick: SDL_Joystick, type_: SDL_SensorType, sensor_timestamp: UInt64, data: Array[Float]) -> Bool {
  __sdl_SendJoystickVirtualSensorData(joystick, type_, sensor_timestamp, FixedArray::from_array(data), data.length())
}

///| Get the properties associated with a joystick.
///
/// ```c
/// extern SDL_DECLSPEC SDL_PropertiesID SDLCALL SDL_GetJoystickProperties(SDL_Joystick *joystick);
/// ```
pub extern "C" fn sdl_GetJoystickProperties(joystick: SDL_Joystick) -> SDL_PropertiesID = "SDL_GetJoystickProperties"

///| Get the implementation dependent name of a joystick.
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetJoystickName(SDL_Joystick *joystick);
/// ```
extern "C" fn __sdl_GetJoystickName(joystick: SDL_Joystick) -> CStr = "SDL_GetJoystickName"

pub fn sdl_GetJoystickName(joystick: SDL_Joystick) -> String {
  let cstr = __sdl_GetJoystickName(joystick)
  let res = cstr.to_string()
  // Do not free cstr, it's a pointer to internal SDL memory
  res
}

///| Get the implementation dependent path of a joystick.
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetJoystickPath(SDL_Joystick *joystick);
/// ```
extern "C" fn __sdl_GetJoystickPath(joystick: SDL_Joystick) -> CStr = "SDL_GetJoystickPath"

pub fn sdl_GetJoystickPath(joystick: SDL_Joystick) -> String {
  let cstr = __sdl_GetJoystickPath(joystick)
  let res = cstr.to_string()
  // Do not free cstr, it's a pointer to internal SDL memory
  res
}

///| Get the player index of an opened joystick.
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetJoystickPlayerIndex(SDL_Joystick *joystick);
/// ```
pub extern "C" fn sdl_GetJoystickPlayerIndex(joystick: SDL_Joystick) -> Int = "SDL_GetJoystickPlayerIndex"

///| Set the player index of an opened joystick.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetJoystickPlayerIndex(SDL_Joystick *joystick, int player_index);
/// ```
pub extern "C" fn sdl_SetJoystickPlayerIndex(joystick: SDL_Joystick, player_index: Int) -> Bool = "SDL_SetJoystickPlayerIndex"

///| Get the implementation-dependent GUID for the joystick.
///
/// ```c
/// extern SDL_DECLSPEC SDL_GUID SDLCALL SDL_GetJoystickGUID(SDL_Joystick *joystick);
/// ```
pub extern "C" fn sdl_GetJoystickGUID(joystick: SDL_Joystick) -> SDL_GUID = "SDL_GetJoystickGUID"

///| Get the USB vendor ID of an opened joystick, if available.
///
/// ```c
/// extern SDL_DECLSPEC Uint16 SDLCALL SDL_GetJoystickVendor(SDL_Joystick *joystick);
/// ```
pub extern "C" fn sdl_GetJoystickVendor(joystick: SDL_Joystick) -> UInt16 = "SDL_GetJoystickVendor"

///| Get the USB product ID of an opened joystick, if available.
///
/// ```c
/// extern SDL_DECLSPEC Uint16 SDLCALL SDL_GetJoystickProduct(SDL_Joystick *joystick);
/// ```
pub extern "C" fn sdl_GetJoystickProduct(joystick: SDL_Joystick) -> UInt16 = "SDL_GetJoystickProduct"

///| Get the product version of an opened joystick, if available.
///
/// ```c
/// extern SDL_DECLSPEC Uint16 SDLCALL SDL_GetJoystickProductVersion(SDL_Joystick *joystick);
/// ```
pub extern "C" fn sdl_GetJoystickProductVersion(joystick: SDL_Joystick) -> UInt16 = "SDL_GetJoystickProductVersion"

///| Get the firmware version of an opened joystick, if available.
///
/// ```c
/// extern SDL_DECLSPEC Uint16 SDLCALL SDL_GetJoystickFirmwareVersion(SDL_Joystick *joystick);
/// ```
pub extern "C" fn sdl_GetJoystickFirmwareVersion(joystick: SDL_Joystick) -> UInt16 = "SDL_GetJoystickFirmwareVersion"

///| Get the serial number of an opened joystick, if available.
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetJoystickSerial(SDL_Joystick *joystick);
/// ```
extern "C" fn __sdl_GetJoystickSerial(joystick: SDL_Joystick) -> CStr = "SDL_GetJoystickSerial"

pub fn sdl_GetJoystickSerial(joystick: SDL_Joystick) -> String {
  let cstr = __sdl_GetJoystickSerial(joystick)
  let res = cstr.to_string()
  // Do not free cstr, it's a pointer to internal SDL memory
  res
}

///| Get the type of an opened joystick.
///
/// ```c
/// extern SDL_DECLSPEC SDL_JoystickType SDLCALL SDL_GetJoystickType(SDL_Joystick *joystick);
/// ```
pub extern "C" fn sdl_GetJoystickType(joystick: SDL_Joystick) -> SDL_JoystickType = "SDL_GetJoystickType"

///| Get the device information encoded in a SDL_GUID structure.
///
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_GetJoystickGUIDInfo(SDL_GUID guid, Uint16 *vendor, Uint16 *product, Uint16 *version, Uint16 *crc16);
/// ```
extern "C" fn __sdl_GetJoystickGUIDInfo(guid: SDL_GUID, vendor: FixedArray[UInt16], product: FixedArray[UInt16], version: FixedArray[UInt16], crc16: FixedArray[UInt16]) -> Unit = "SDL_GetJoystickGUIDInfo"

pub fn sdl_GetJoystickGUIDInfo(guid: SDL_GUID) -> (UInt16, UInt16, UInt16, UInt16) {
  let vendor: FixedArray[UInt16] = FixedArray::make(1, 0)
  let product: FixedArray[UInt16] = FixedArray::make(1, 0)
  let version: FixedArray[UInt16] = FixedArray::make(1, 0)
  let crc16: FixedArray[UInt16] = FixedArray::make(1, 0)
  __sdl_GetJoystickGUIDInfo(guid, vendor, product, version, crc16)
  (vendor[0], product[0], version[0], crc16[0])
}

///| Get the status of a specified joystick.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_JoystickConnected(SDL_Joystick *joystick);
/// ```
pub extern "C" fn sdl_JoystickConnected(joystick: SDL_Joystick) -> Bool = "SDL_JoystickConnected"

///| Get the instance ID of an opened joystick.
///
/// ```c
/// extern SDL_DECLSPEC SDL_JoystickID SDLCALL SDL_GetJoystickID(SDL_Joystick *joystick);
/// ```
pub extern "C" fn sdl_GetJoystickID(joystick: SDL_Joystick) -> SDL_JoystickID = "SDL_GetJoystickID"

///| Get the number of general axis controls on a joystick.
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetNumJoystickAxes(SDL_Joystick *joystick);
/// ```
pub extern "C" fn sdl_GetNumJoystickAxes(joystick: SDL_Joystick) -> Int = "SDL_GetNumJoystickAxes"

///| Get the number of trackballs on a joystick.
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetNumJoystickBalls(SDL_Joystick *joystick);
/// ```
pub extern "C" fn sdl_GetNumJoystickBalls(joystick: SDL_Joystick) -> Int = "SDL_GetNumJoystickBalls"

///| Get the number of POV hats on a joystick.
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetNumJoystickHats(SDL_Joystick *joystick);
/// ```
pub extern "C" fn sdl_GetNumJoystickHats(joystick: SDL_Joystick) -> Int = "SDL_GetNumJoystickHats"

///| Get the number of buttons on a joystick.
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetNumJoystickButtons(SDL_Joystick *joystick);
/// ```
pub extern "C" fn sdl_GetNumJoystickButtons(joystick: SDL_Joystick) -> Int = "SDL_GetNumJoystickButtons"

///| Set the state of joystick event processing.
///
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_SetJoystickEventsEnabled(bool enabled);
/// ```
pub extern "C" fn sdl_SetJoystickEventsEnabled(enabled: Bool) -> Unit = "SDL_SetJoystickEventsEnabled"

///| Query the state of joystick event processing.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_JoystickEventsEnabled(void);
/// ```
pub extern "C" fn sdl_JoystickEventsEnabled() -> Bool = "SDL_JoystickEventsEnabled"

///| Update the current state of the open joysticks.
///
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_UpdateJoysticks(void);
/// ```
pub extern "C" fn sdl_UpdateJoysticks() -> Unit = "SDL_UpdateJoysticks"

///| Get the current state of an axis control on a joystick.
///
/// ```c
/// extern SDL_DECLSPEC Sint16 SDLCALL SDL_GetJoystickAxis(SDL_Joystick *joystick, int axis);
/// ```
pub extern "C" fn sdl_GetJoystickAxis(joystick: SDL_Joystick, axis: Int) -> Int16 = "SDL_GetJoystickAxis"

///| Get the initial state of an axis control on a joystick.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetJoystickAxisInitialState(SDL_Joystick *joystick, int axis, Sint16 *state);
/// ```
extern "C" fn __sdl_GetJoystickAxisInitialState(joystick: SDL_Joystick, axis: Int, state: FixedArray[Int16]) -> Bool = "SDL_GetJoystickAxisInitialState"

pub fn sdl_GetJoystickAxisInitialState(joystick: SDL_Joystick, axis: Int) -> (Bool, Int16) {
  let state: FixedArray[Int16] = FixedArray::make(1, 0)
  let success = __sdl_GetJoystickAxisInitialState(joystick, axis, state)
  (success, state[0])
}

///| Get the ball axis change since the last poll.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetJoystickBall(SDL_Joystick *joystick, int ball, int *dx, int *dy);
/// ```
extern "C" fn __sdl_GetJoystickBall(joystick: SDL_Joystick, ball: Int, dx: FixedArray[Int], dy: FixedArray[Int]) -> Bool = "SDL_GetJoystickBall"

pub fn sdl_GetJoystickBall(joystick: SDL_Joystick, ball: Int) -> (Bool, Int, Int) {
  let dx = FixedArray::make(1, 0)
  let dy = FixedArray::make(1, 0)
  let success = __sdl_GetJoystickBall(joystick, ball, dx, dy)
  (success, dx[0], dy[0])
}

///| Get the current state of a POV hat on a joystick.
///
/// ```c
/// extern SDL_DECLSPEC Uint8 SDLCALL SDL_GetJoystickHat(SDL_Joystick *joystick, int hat);
/// ```
pub extern "C" fn sdl_GetJoystickHat(joystick: SDL_Joystick, hat: Int) -> Byte = "SDL_GetJoystickHat"

pub const SDL_HAT_CENTERED : UInt = 0x00
pub const SDL_HAT_UP : UInt = 0x01
pub const SDL_HAT_RIGHT : UInt = 0x02
pub const SDL_HAT_DOWN : UInt = 0x04
pub const SDL_HAT_LEFT : UInt = 0x08
pub const SDL_HAT_RIGHTUP : UInt = 0x02 | 0x01
pub const SDL_HAT_RIGHTDOWN : UInt = 0x02 | 0x04
pub const SDL_HAT_LEFTUP : UInt = 0x08 | 0x01
pub const SDL_HAT_LEFTDOWN : UInt = 0x08 | 0x04

///| Get the current state of a button on a joystick.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetJoystickButton(SDL_Joystick *joystick, int button);
/// ```
pub extern "C" fn sdl_GetJoystickButton(joystick: SDL_Joystick, button: Int) -> Bool = "SDL_GetJoystickButton"

///| Start a rumble effect.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RumbleJoystick(SDL_Joystick *joystick, Uint16 low_frequency_rumble, Uint16 high_frequency_rumble, Uint32 duration_ms);
/// ```
pub extern "C" fn sdl_RumbleJoystick(joystick: SDL_Joystick, low_frequency_rumble: UInt16, high_frequency_rumble: UInt16, duration_ms: UInt) -> Bool = "SDL_RumbleJoystick"

///| Start a rumble effect in the joystick's triggers.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RumbleJoystickTriggers(SDL_Joystick *joystick, Uint16 left_rumble, Uint16 right_rumble, Uint32 duration_ms);
/// ```
pub extern "C" fn sdl_RumbleJoystickTriggers(joystick: SDL_Joystick, left_rumble: UInt16, right_rumble: UInt16, duration_ms: UInt) -> Bool = "SDL_RumbleJoystickTriggers"

///| Update a joystick's LED color.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetJoystickLED(SDL_Joystick *joystick, Uint8 red, Uint8 green, Uint8 blue);
/// ```
pub extern "C" fn sdl_SetJoystickLED(joystick: SDL_Joystick, red: Byte, green: Byte, blue: Byte) -> Bool = "SDL_SetJoystickLED"

///| Send a joystick specific effect packet.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SendJoystickEffect(SDL_Joystick *joystick, const void *data, int size);
/// ```
pub extern "C" fn sdl_SendJoystickEffect(joystick: SDL_Joystick, data: VoidPtr, size: Int) -> Bool = "SDL_SendJoystickEffect"

///| Close a joystick previously opened with SDL_OpenJoystick().
///
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_CloseJoystick(SDL_Joystick *joystick);
/// ```
pub extern "C" fn sdl_CloseJoystick(joystick: SDL_Joystick) -> Unit = "SDL_CloseJoystick"

///| Get the connection state of a joystick.
///
/// ```c
/// extern SDL_DECLSPEC SDL_JoystickConnectionState SDLCALL SDL_GetJoystickConnectionState(SDL_Joystick *joystick);
/// ```
pub extern "C" fn sdl_GetJoystickConnectionState(joystick: SDL_Joystick) -> SDL_JoystickConnectionState = "SDL_GetJoystickConnectionState"

///| Get the battery state of a joystick.
///
/// ```c
/// extern SDL_DECLSPEC SDL_PowerState SDLCALL SDL_GetJoystickPowerInfo(SDL_Joystick *joystick, int *percent);
/// ```
pub extern "C" fn __sdl_GetJoystickPowerInfo(joystick: SDL_Joystick, percent: FixedArray[Int]) -> SDL_PowerState = "SDL_GetJoystickPowerInfo"

pub fn sdl_GetJoystickPowerInfo(joystick: SDL_Joystick) -> (SDL_PowerState, Int) {
  let percent = FixedArray::make(1, 0)
  let state = __sdl_GetJoystickPowerInfo(joystick, percent)
  (state, percent[0])
}
