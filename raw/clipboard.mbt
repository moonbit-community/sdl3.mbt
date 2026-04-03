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

/// # CategoryClipboard
///
/// SDL provides access to the system clipboard, both for reading information
/// from other processes and publishing information of its own.

///|
/// Put UTF-8 text into the clipboard.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetClipboardText(const char *text);
/// ```
#owned(text)
extern "C" fn __sdl_SetClipboardText(text : Bytes) -> Bool = "SDL_SetClipboardText"

///|
pub fn sdl_SetClipboardText(text : String) -> Bool {
  let c_text = string_to_cbytes(text)
  __sdl_SetClipboardText(c_text)
}

///|
/// Get UTF-8 text from the clipboard.
///
/// ```c
/// extern SDL_DECLSPEC char * SDLCALL SDL_GetClipboardText(void);
/// ```
extern "C" fn __sdl_GetClipboardText() -> CStr = "SDL_GetClipboardText"

///|
pub fn sdl_GetClipboardText() -> String {
  let cstr = __sdl_GetClipboardText()
  let res = cstr.to_string()
  free_cstr(cstr)
  res
}

///|
/// Query whether the clipboard exists and contains a non-empty text string.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasClipboardText(void);
/// ```
pub extern "C" fn sdl_HasClipboardText() -> Bool = "SDL_HasClipboardText"

///|
/// Put UTF-8 text into the primary selection.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetPrimarySelectionText(const char *text);
/// ```
#owned(text)
extern "C" fn __sdl_SetPrimarySelectionText(text : Bytes) -> Bool = "SDL_SetPrimarySelectionText"

///|
pub fn sdl_SetPrimarySelectionText(text : String) -> Bool {
  let c_text = string_to_cbytes(text)
  __sdl_SetPrimarySelectionText(c_text)
}

///|
/// Get UTF-8 text from the primary selection.
///
/// ```c
/// extern SDL_DECLSPEC char * SDLCALL SDL_GetPrimarySelectionText(void);
/// ```
extern "C" fn __sdl_GetPrimarySelectionText() -> CStr = "SDL_GetPrimarySelectionText"

///|
pub fn sdl_GetPrimarySelectionText() -> String {
  let cstr = __sdl_GetPrimarySelectionText()
  let res = cstr.to_string()
  free_cstr(cstr)
  res
}

///| Query whether the primary selection exists and contains a non-empty text

///|
/// string.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasPrimarySelectionText(void);
/// ```
pub extern "C" fn sdl_HasPrimarySelectionText() -> Bool = "SDL_HasPrimarySelectionText"

///| Callback function that will be called when data for the specified mime-type

///|
/// is requested by the OS.
///
/// ```c
/// typedef const void *(SDLCALL *SDL_ClipboardDataCallback)(void *userdata, const char *mime_type, size_t *size);
/// ```
type SDL_ClipboardDataCallback = FuncRef[
  (VoidPtr, CStr, FixedArray[Int]) -> VoidPtr,
]

///| Callback function that will be called when the clipboard is cleared, or new

///|
/// data is set.
///
/// ```c
/// typedef void (SDLCALL *SDL_ClipboardCleanupCallback)(void *userdata);
/// ```
type SDL_ClipboardCleanupCallback = FuncRef[(VoidPtr) -> Unit]

///|
/// Offer clipboard data to the OS.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetClipboardData(SDL_ClipboardDataCallback callback, SDL_ClipboardCleanupCallback cleanup, void *userdata, const char **mime_types, size_t num_mime_types);
/// ```
#owned(mime_types)
extern "C" fn __sdl_SetClipboardData(
  callback : SDL_ClipboardDataCallback,
  cleanup : SDL_ClipboardCleanupCallback,
  userdata : VoidPtr,
  mime_types : FixedArray[Bytes],
  num_mime_types : Int,
) -> Bool = "SDL_SetClipboardData"

///|
pub fn sdl_SetClipboardData(
  callback : SDL_ClipboardDataCallback,
  cleanup : SDL_ClipboardCleanupCallback,
  userdata : VoidPtr,
  mime_types : Array[String],
) -> Bool {
  let c_mime_types = FixedArray::make(mime_types.length(), b"")
  for i = 0; i < mime_types.length(); i = i + 1 {
    c_mime_types[i] = string_to_cbytes(mime_types[i])
  }
  __sdl_SetClipboardData(
    callback,
    cleanup,
    userdata,
    c_mime_types,
    mime_types.length(),
  )
}

///|
/// Clear the clipboard data.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_ClearClipboardData(void);
/// ```
pub extern "C" fn sdl_ClearClipboardData() -> Bool = "SDL_ClearClipboardData"

///|
/// Get the data from clipboard for a given mime type.
///
/// ```c
/// extern SDL_DECLSPEC void * SDLCALL SDL_GetClipboardData(const char *mime_type, size_t *size);
/// ```
#owned(mime_type, size)
extern "C" fn __sdl_GetClipboardData(
  mime_type : Bytes,
  size : FixedArray[Int],
) -> VoidPtr = "SDL_GetClipboardData"

///|
pub fn sdl_GetClipboardData(mime_type : String) -> (VoidPtr, Int) {
  let c_mime_type = string_to_cbytes(mime_type)
  let size = FixedArray::make(1, 0)
  let data = __sdl_GetClipboardData(c_mime_type, size)
  (data, size[0])
}

///|
/// Query whether there is data in the clipboard for the provided mime type.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasClipboardData(const char *mime_type);
/// ```
#owned(mime_type)
extern "C" fn __sdl_HasClipboardData(mime_type : Bytes) -> Bool = "SDL_HasClipboardData"

///|
pub fn sdl_HasClipboardData(mime_type : String) -> Bool {
  let c_mime_type = string_to_cbytes(mime_type)
  __sdl_HasClipboardData(c_mime_type)
}

///|
/// Retrieve the list of mime types available in the clipboard.
///
/// ```c
/// extern SDL_DECLSPEC char ** SDLCALL SDL_GetClipboardMimeTypes(size_t *num_mime_types);
/// ```
#owned(num_mime_types)
extern "C" fn __sdl_GetClipboardMimeTypes(
  num_mime_types : FixedArray[Int],
) -> FixedArray[CStr] = "SDL_GetClipboardMimeTypes"

///|
pub fn sdl_GetClipboardMimeTypes() -> (Array[String], Int) {
  let num_mime_types = FixedArray::make(1, 0)
  let c_mime_types = __sdl_GetClipboardMimeTypes(num_mime_types)
  let mime_types = Array::new()
  for i = 0; i < num_mime_types[0]; i = i + 1 {
    mime_types.push(c_mime_types[i].to_string())
  }
  (mime_types, num_mime_types[0])
}
