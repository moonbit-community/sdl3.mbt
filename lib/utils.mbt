
#external
pub type VoidPtr

pub extern "C" fn get_null() -> VoidPtr = "get_null"
pub extern "C" fn voidptr_is_null(p:VoidPtr) -> Bool = "voidptr_is_null"

#external
pub type CStr

extern "C" fn CStr::to_string(cstr: CStr) -> String = "cstr_to_moonbit_string"

extern "C" fn free_cstr(cstr: CStr) = "free_cstr"

fn string_to_cbytes(str: String) -> Bytes {
  let s = str.to_bytes().to_array().filter(fn(c) { c != 0 })
  s.push(0)
  s |> @bytes.from_array
}

pub fn[T] nullptr() -> T {
  let null : VoidPtr = get_null()
  ptr_cast(null)
}

fn[T] ptr_cast(ptr: VoidPtr) -> T = "%identity"

fn[T] is_nullptr(ptr: T) -> Bool {
  let ptr_int : VoidPtr = cast_ptr_to_int64(ptr)
  voidptr_is_null(ptr_int)
}

fn[T] cast_ptr_to_int64(ptr: T) -> VoidPtr = "%identity"

/// -------------------
/// The following types are just temporary
/// eliminate them when new bindings are created
/// -------------------

pub typealias UInt64 as SDL_TouchID

#external
pub type SDL_GPUShaderFormat

#external
pub type SDL_GPUDevice

#external
pub type SDL_GUID


#external
pub type SDL_SensorType

#external
pub type SDL_PropertiesID 

#external
pub type SDL_PowerState
