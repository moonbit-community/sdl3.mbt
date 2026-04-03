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

/// # CategoryFilesystem
///
/// SDL offers an API for examining and manipulating the system's filesystem.

///|
/// Get the directory where the application was run from.
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetBasePath(void);
/// ```
extern "C" fn __sdl_GetBasePath() -> CStr = "SDL_GetBasePath"

///|
pub fn sdl_GetBasePath() -> String {
  let cstr = __sdl_GetBasePath()
  let res = cstr.to_string()
  // Do not free cstr, it's a pointer to internal SDL memory
  res
}

///|
/// Get the user-and-app-specific path where files can be written.
///
/// ```c
/// extern SDL_DECLSPEC char * SDLCALL SDL_GetPrefPath(const char *org, const char *app);
/// ```
#owned(org, app)
extern "C" fn __sdl_GetPrefPath(org : Bytes, app : Bytes) -> CStr = "SDL_GetPrefPath"

///|
pub fn sdl_GetPrefPath(org : String, app : String) -> String {
  let c_org = string_to_cbytes(org)
  let c_app = string_to_cbytes(app)
  let cstr = __sdl_GetPrefPath(c_org, c_app)
  let res = cstr.to_string()
  free_cstr(cstr)
  res
}

///|
/// The type of the OS-provided default folder for a specific purpose.
///
/// ```c
/// typedef enum SDL_Folder
/// {
///     SDL_FOLDER_HOME,        /**< The folder which contains all of the current user's data, preferences, and documents. It usually contains most of the other folders. If a requested folder does not exist, the home folder can be considered a safe fallback to store a user's documents. */
///     SDL_FOLDER_DESKTOP,     /**< The folder of files that are displayed on the desktop. Note that the existence of a desktop folder does not guarantee that the system does show icons on its desktop; certain GNU/Linux distros with a graphical environment may not have desktop icons. */
///     SDL_FOLDER_DOCUMENTS,   /**< User document files, possibly application-specific. This is a good place to save a user's projects. */
///     SDL_FOLDER_DOWNLOADS,   /**< Standard folder for user files downloaded from the internet. */
///     SDL_FOLDER_MUSIC,       /**< Music files that can be played using a standard music player (mp3, ogg...). */
///     SDL_FOLDER_PICTURES,    /**< Image files that can be displayed using a standard viewer (png, jpg...). */
///     SDL_FOLDER_PUBLICSHARE, /**< Files that are meant to be shared with other users on the same computer. */
///     SDL_FOLDER_SAVEDGAMES,  /**< Save files for games. */
///     SDL_FOLDER_SCREENSHOTS, /**< Application screenshots. */
///     SDL_FOLDER_TEMPLATES,   /**< Template files to be used when the user requests the desktop environment to create a new file in a certain folder, such as "New Text File.txt".  Any file in the Templates folder can be used as a starting point for a new file. */
///     SDL_FOLDER_VIDEOS,      /**< Video files that can be played using a standard video player (mp4, webm...). */
///     SDL_FOLDER_COUNT        /**< Total number of types in this enum, not a folder type by itself. */
/// } SDL_Folder;
/// ```
pub(all) enum SDL_Folder {
  SDL_FOLDER_HOME
  SDL_FOLDER_DESKTOP
  SDL_FOLDER_DOCUMENTS
  SDL_FOLDER_DOWNLOADS
  SDL_FOLDER_MUSIC
  SDL_FOLDER_PICTURES
  SDL_FOLDER_PUBLICSHARE
  SDL_FOLDER_SAVEDGAMES
  SDL_FOLDER_SCREENSHOTS
  SDL_FOLDER_TEMPLATES
  SDL_FOLDER_VIDEOS
  SDL_FOLDER_COUNT
}

///|
/// Finds the most suitable user folder for a specific purpose.
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetUserFolder(SDL_Folder folder);
/// ```
extern "C" fn __sdl_GetUserFolder(folder : SDL_Folder) -> CStr = "SDL_GetUserFolder"

///|
pub fn sdl_GetUserFolder(folder : SDL_Folder) -> String {
  let cstr = __sdl_GetUserFolder(folder)
  let res = cstr.to_string()
  // Do not free cstr, it's a pointer to internal SDL memory
  res
}

///|
/// Types of filesystem entries.
///
/// ```c
/// typedef enum SDL_PathType
/// {
///     SDL_PATHTYPE_NONE,      /**< path does not exist */
///     SDL_PATHTYPE_FILE,      /**< a normal file */
///     SDL_PATHTYPE_DIRECTORY, /**< a directory */
///     SDL_PATHTYPE_OTHER      /**< something completely different like a device node (not a symlink, those are always followed) */
/// } SDL_PathType;
/// ```
pub(all) enum SDL_PathType {
  SDL_PATHTYPE_NONE
  SDL_PATHTYPE_FILE
  SDL_PATHTYPE_DIRECTORY
  SDL_PATHTYPE_OTHER
}

///|
/// Information about a path on the filesystem.
///
/// ```c
/// typedef struct SDL_PathInfo
/// {
///     SDL_PathType type;      /**< the path type */
///     Uint64 size;            /**< the file size in bytes */
///     SDL_Time create_time;   /**< the time when the path was created */
///     SDL_Time modify_time;   /**< the last time the path was modified */
///     SDL_Time access_time;   /**< the last time the path was read */
/// } SDL_PathInfo;
/// ```
pub(all) struct SDL_PathInfo {
  type_ : SDL_PathType
  size : UInt64
  create_time : Int64
  modify_time : Int64
  access_time : Int64
}

///|
/// Flags for path matching.
///
/// ```c
/// typedef Uint32 SDL_GlobFlags;
/// #define SDL_GLOB_CASEINSENSITIVE (1u << 0)
/// ```
type SDL_GlobFlags = UInt

///|
pub const SDL_GLOB_CASEINSENSITIVE : SDL_GlobFlags = 1

///|
/// Create a directory, and any missing parent directories.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_CreateDirectory(const char *path);
/// ```
#owned(path)
extern "C" fn __sdl_CreateDirectory(path : Bytes) -> Bool = "SDL_CreateDirectory"

///|
pub fn sdl_CreateDirectory(path : String) -> Bool {
  let c_path = string_to_cbytes(path)
  __sdl_CreateDirectory(c_path)
}

///|
/// Possible results from an enumeration callback.
///
/// ```c
/// typedef enum SDL_EnumerationResult
/// {
///     SDL_ENUM_CONTINUE,   /**< Value that requests that enumeration continue. */
///     SDL_ENUM_SUCCESS,    /**< Value that requests that enumeration stop, successfully. */
///     SDL_ENUM_FAILURE     /**< Value that requests that enumeration stop, as a failure. */
/// } SDL_EnumerationResult;
/// ```
pub(all) enum SDL_EnumerationResult {
  SDL_ENUM_CONTINUE
  SDL_ENUM_SUCCESS
  SDL_ENUM_FAILURE
}

///|
/// Callback for directory enumeration.
///
/// ```c
/// typedef SDL_EnumerationResult (SDLCALL *SDL_EnumerateDirectoryCallback)(void *userdata, const char *dirname, const char *fname);
/// ```
type SDL_EnumerateDirectoryCallback = FuncRef[
  (VoidPtr, CStr, CStr) -> SDL_EnumerationResult,
]

///|
/// Enumerate a directory through a callback function.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_EnumerateDirectory(const char *path, SDL_EnumerateDirectoryCallback callback, void *userdata);
/// ```
#owned(path)
extern "C" fn __sdl_EnumerateDirectory(
  path : Bytes,
  callback : SDL_EnumerateDirectoryCallback,
  userdata : VoidPtr,
) -> Bool = "SDL_EnumerateDirectory"

///|
pub fn sdl_EnumerateDirectory(
  path : String,
  callback : SDL_EnumerateDirectoryCallback,
  userdata : VoidPtr,
) -> Bool {
  let c_path = string_to_cbytes(path)
  __sdl_EnumerateDirectory(c_path, callback, userdata)
}

///|
/// Remove a file or an empty directory.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RemovePath(const char *path);
/// ```
#owned(path)
extern "C" fn __sdl_RemovePath(path : Bytes) -> Bool = "SDL_RemovePath"

///|
pub fn sdl_RemovePath(path : String) -> Bool {
  let c_path = string_to_cbytes(path)
  __sdl_RemovePath(c_path)
}

///|
/// Rename a file or directory.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenamePath(const char *oldpath, const char *newpath);
/// ```
#owned(oldpath, newpath)
extern "C" fn __sdl_RenamePath(oldpath : Bytes, newpath : Bytes) -> Bool = "SDL_RenamePath"

///|
pub fn sdl_RenamePath(oldpath : String, newpath : String) -> Bool {
  let c_oldpath = string_to_cbytes(oldpath)
  let c_newpath = string_to_cbytes(newpath)
  __sdl_RenamePath(c_oldpath, c_newpath)
}

///|
/// Copy a file.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_CopyFile(const char *oldpath, const char *newpath);
/// ```
#owned(oldpath, newpath)
extern "C" fn __sdl_CopyFile(oldpath : Bytes, newpath : Bytes) -> Bool = "SDL_CopyFile"

///|
pub fn sdl_CopyFile(oldpath : String, newpath : String) -> Bool {
  let c_oldpath = string_to_cbytes(oldpath)
  let c_newpath = string_to_cbytes(newpath)
  __sdl_CopyFile(c_oldpath, c_newpath)
}

///|
/// Get information about a filesystem path.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetPathInfo(const char *path, SDL_PathInfo *info);
/// ```
#owned(path, info)
extern "C" fn __sdl_GetPathInfo(
  path : Bytes,
  info : FixedArray[SDL_PathInfo],
) -> Bool = "SDL_GetPathInfo"

///|
pub fn sdl_GetPathInfo(path : String) -> (Bool, SDL_PathInfo) {
  let c_path = string_to_cbytes(path)
  let info = FixedArray::make(1, {
    type_: SDL_PATHTYPE_NONE,
    size: 0,
    create_time: 0L,
    modify_time: 0L,
    access_time: 0L,
  })
  let success = __sdl_GetPathInfo(c_path, info)
  (success, info[0])
}

///|
/// Enumerate a directory tree, filtered by pattern, and return a list.
///
/// ```c
/// extern SDL_DECLSPEC char ** SDLCALL SDL_GlobDirectory(const char *path, const char *pattern, SDL_GlobFlags flags, int *count);
/// ```
#owned(path, pattern, count)
extern "C" fn __sdl_GlobDirectory(
  path : Bytes,
  pattern : Bytes,
  flags : SDL_GlobFlags,
  count : FixedArray[Int],
) -> FixedArray[CStr] = "SDL_GlobDirectory"

///|
pub fn sdl_GlobDirectory(
  path : String,
  pattern : String,
  flags : SDL_GlobFlags,
) -> (Array[String], Int) {
  let c_path = string_to_cbytes(path)
  let c_pattern = string_to_cbytes(pattern)
  let count = FixedArray::make(1, 0)
  let c_strs = __sdl_GlobDirectory(c_path, c_pattern, flags, count)
  let strs = Array::new()
  for i = 0; i < count[0]; i = i + 1 {
    strs.push(c_strs[i].to_string())
  }
  (strs, count[0])
}

///|
/// Get what the system believes is the "current working directory."
///
/// ```c
/// extern SDL_DECLSPEC char * SDLCALL SDL_GetCurrentDirectory(void);
/// ```
extern "C" fn __sdl_GetCurrentDirectory() -> CStr = "SDL_GetCurrentDirectory"

///|
pub fn sdl_GetCurrentDirectory() -> String {
  let cstr = __sdl_GetCurrentDirectory()
  let res = cstr.to_string()
  free_cstr(cstr)
  res
}
