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

/// # CategoryAudio
/// 
/// Audio functionality for the SDL library.
/// 
/// All audio in SDL3 revolves around SDL_AudioStream. Whether you want to play
/// or record audio, convert it, stream it, buffer it, or mix it, you're going
/// to be passing it through an audio stream.
/// 
/// Audio streams are quite flexible; they can accept any amount of data at a
/// time, in any supported format, and output it as needed in any other format,
/// even if the data format changes on either side halfway through.

///|
/// Audio format.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_AudioFormat
/// {
///     SDL_AUDIO_UNKNOWN   = 0x0000u,
///     SDL_AUDIO_U8        = 0x0008u,
///     SDL_AUDIO_S8        = 0x8008u,
///     SDL_AUDIO_S16LE     = 0x8010u,
///     SDL_AUDIO_S16BE     = 0x9010u,
///     SDL_AUDIO_S32LE     = 0x8020u,
///     SDL_AUDIO_S32BE     = 0x9020u,
///     SDL_AUDIO_F32LE     = 0x8120u,
///     SDL_AUDIO_F32BE     = 0x9120u,
/// } SDL_AudioFormat;
/// ```
pub(all) enum SDL_AudioFormat {
  SDL_AUDIO_UNKNOWN = 0x0000
  SDL_AUDIO_U8 = 0x0008
  SDL_AUDIO_S8 = 0x8008
  SDL_AUDIO_S16LE = 0x8010
  SDL_AUDIO_S16BE = 0x9010
  SDL_AUDIO_S32LE = 0x8020
  SDL_AUDIO_S32BE = 0x9020
  SDL_AUDIO_F32LE = 0x8120
  SDL_AUDIO_F32BE = 0x9120
}

///|
/// SDL Audio Device instance IDs.
/// 
/// Zero is used to signify an invalid/null device.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// ```c
/// typedef Uint32 SDL_AudioDeviceID;
/// ```
pub type SDL_AudioDeviceID = UInt

// Audio device constants

///|
pub const SDL_AUDIO_DEVICE_DEFAULT_PLAYBACK : SDL_AudioDeviceID = 0xFFFFFFFFU

///|
pub const SDL_AUDIO_DEVICE_DEFAULT_RECORDING : SDL_AudioDeviceID = 0xFFFFFFFEU

///|
/// Format specifier for audio data.
/// 
/// @since This struct is available since SDL 3.2.0.
/// 
/// ```c
/// typedef struct SDL_AudioSpec
/// {
///     SDL_AudioFormat format;
///     int channels;
///     int freq;
/// } SDL_AudioSpec;
/// ```
pub(all) struct SDL_AudioSpec {
  format : SDL_AudioFormat
  channels : Int
  freq : Int
}

///|
/// The opaque handle that represents an audio stream.
/// 
/// SDL_AudioStream is an audio conversion interface.
/// 
/// @since This struct is available since SDL 3.2.0.
/// 
/// ```c
/// typedef struct SDL_AudioStream SDL_AudioStream;
/// ```
#external
pub type SDL_AudioStream

///|
/// A callback that fires when data passes through an SDL_AudioStream.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// ```c
/// typedef void (SDLCALL *SDL_AudioStreamCallback)(void *userdata, SDL_AudioStream *stream, int additional_amount, int total_amount);
/// ```
pub type SDL_AudioStreamCallback = FuncRef[
  (VoidPtr, SDL_AudioStream, Int, Int) -> Unit,
]

///|
/// A callback that fires when data is about to be fed to an audio device.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// ```c
/// typedef void (SDLCALL *SDL_AudioPostmixCallback)(void *userdata, const SDL_AudioSpec *spec, float *buffer, int buflen);
/// ```
pub type SDL_AudioPostmixCallback = FuncRef[
  (VoidPtr, SDL_AudioSpec, FixedArray[Float], Int) -> Unit,
]

///|
/// Use this function to get the number of built-in audio drivers.
/// 
/// This function returns a hardcoded number. This never returns a negative
/// value; if there are no drivers compiled into this build of SDL, this
/// function returns zero.
/// 
/// @return the number of built-in audio drivers.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetAudioDriver
/// 
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetNumAudioDrivers(void);
/// ```
pub extern "C" fn sdl_GetNumAudioDrivers() -> Int = "SDL_GetNumAudioDrivers"

///|
/// Use this function to get the name of a built in audio driver.
/// 
/// The list of audio drivers is given in the order that they are normally
/// initialized by default.
/// 
/// @param index the index of the audio driver.
/// @return the name of the audio driver at the requested index, or NULL if an
///          invalid index was specified.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetNumAudioDrivers
/// 
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetAudioDriver(int index);
/// ```
pub fn sdl_GetAudioDriver(index : Int) -> String {
  let cres = __sdl_GetAudioDriver(index)
  let res = cres.to_string()
  free_cstr(cres)
  res
}

///|
extern "C" fn __sdl_GetAudioDriver(index : Int) -> CStr = "SDL_GetAudioDriver"

///|
/// Get the name of the current audio driver.
/// 
/// @return the name of the current audio driver or NULL if no driver has been
///          initialized.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetCurrentAudioDriver(void);
/// ```
pub fn sdl_GetCurrentAudioDriver() -> String {
  let cres = __sdl_GetCurrentAudioDriver()
  let res = cres.to_string()
  free_cstr(cres)
  res
}

///|
extern "C" fn __sdl_GetCurrentAudioDriver() -> CStr = "SDL_GetCurrentAudioDriver"

///|
/// Get a list of currently-connected audio playback devices.
/// 
/// This returns of list of available devices that play sound, perhaps to
/// speakers or headphones ("playback" devices).
/// 
/// @param count a pointer filled in with the number of devices returned, may
///              be NULL.
/// @return a 0 terminated array of device instance IDs or NULL on error.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_OpenAudioDevice
/// @see SDL_GetAudioRecordingDevices
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_AudioDeviceID * SDLCALL SDL_GetAudioPlaybackDevices(int *count);
/// ```
#owned(count)
pub extern "C" fn sdl_GetAudioPlaybackDevices(
  count : FixedArray[Int],
) -> FixedArray[SDL_AudioDeviceID] = "SDL_GetAudioPlaybackDevices"

///|
/// Get a list of currently-connected audio recording devices.
/// 
/// This returns of list of available devices that record audio, like a
/// microphone ("recording" devices).
/// 
/// @param count a pointer filled in with the number of devices returned, may
///              be NULL.
/// @return a 0 terminated array of device instance IDs, or NULL on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_OpenAudioDevice
/// @see SDL_GetAudioPlaybackDevices
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_AudioDeviceID * SDLCALL SDL_GetAudioRecordingDevices(int *count);
/// ```
#owned(count)
pub extern "C" fn sdl_GetAudioRecordingDevices(
  count : FixedArray[Int],
) -> FixedArray[SDL_AudioDeviceID] = "SDL_GetAudioRecordingDevices"

///|
/// Get the human-readable name of a specific audio device.
/// 
/// @param devid the instance ID of the device to query.
/// @return the name of the audio device, or NULL on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetAudioPlaybackDevices
/// @see SDL_GetAudioRecordingDevices
/// 
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetAudioDeviceName(SDL_AudioDeviceID devid);
/// ```
pub fn sdl_GetAudioDeviceName(devid : SDL_AudioDeviceID) -> String {
  let cres = __sdl_GetAudioDeviceName(devid)
  let res = cres.to_string()
  free_cstr(cres)
  res
}

///|
extern "C" fn __sdl_GetAudioDeviceName(devid : SDL_AudioDeviceID) -> CStr = "SDL_GetAudioDeviceName"

///|
/// Get the current audio format of a specific audio device.
/// 
/// For an opened device, this will report the format the device is currently
/// using. If the device isn't yet opened, this will report the device's
/// preferred format.
/// 
/// @param devid the instance ID of the device to query.
/// @param spec on return, will be filled with device details.
/// @param sample_frames pointer to store device buffer size, in sample frames.
///                      Can be NULL.
/// @return true on success or false on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetAudioDeviceFormat(SDL_AudioDeviceID devid, SDL_AudioSpec *spec, int *sample_frames);
/// ```
#owned(spec, sample_frames)
pub extern "C" fn sdl_GetAudioDeviceFormat(
  devid : SDL_AudioDeviceID,
  spec : FixedArray[SDL_AudioSpec],
  sample_frames : FixedArray[Int],
) -> Bool = "SDL_GetAudioDeviceFormat"

///|
/// Open a specific audio device.
/// 
/// You can open both playback and recording devices through this function.
/// Playback devices will take data from bound audio streams, mix it, and send
/// it to the hardware. Recording devices will feed any bound audio streams
/// with a copy of any incoming data.
/// 
/// @param devid the device instance id to open, or
///              SDL_AUDIO_DEVICE_DEFAULT_PLAYBACK or
///              SDL_AUDIO_DEVICE_DEFAULT_RECORDING for the most reasonable
///              default device.
/// @param spec the requested device configuration. Can be NULL to use
///             reasonable defaults.
/// @return the device ID on success or 0 on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_CloseAudioDevice
/// @see SDL_GetAudioDeviceFormat
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_AudioDeviceID SDLCALL SDL_OpenAudioDevice(SDL_AudioDeviceID devid, const SDL_AudioSpec *spec);
/// ```
#owned(spec)
pub extern "C" fn sdl_OpenAudioDevice(
  devid : SDL_AudioDeviceID,
  spec : FixedArray[SDL_AudioSpec],
) -> SDL_AudioDeviceID = "SDL_OpenAudioDevice"

///|
/// Use this function to pause audio playback on a specified device.
/// 
/// This function pauses audio processing for a given device. Any bound audio
/// streams will not progress, and no audio will be generated.
/// 
/// Physical devices can not be paused or unpaused, only logical devices
/// created through SDL_OpenAudioDevice() can be.
/// 
/// @param devid a device opened by SDL_OpenAudioDevice().
/// @return true on success or false on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_ResumeAudioDevice
/// @see SDL_AudioDevicePaused
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_PauseAudioDevice(SDL_AudioDeviceID devid);
/// ```
pub extern "C" fn sdl_PauseAudioDevice(devid : SDL_AudioDeviceID) -> Bool = "SDL_PauseAudioDevice"

///|
/// Use this function to unpause audio playback on a specified device.
/// 
/// This function unpauses audio processing for a given device that has
/// previously been paused with SDL_PauseAudioDevice().
/// 
/// Physical devices can not be paused or unpaused, only logical devices
/// created through SDL_OpenAudioDevice() can be.
/// 
/// @param devid a device opened by SDL_OpenAudioDevice().
/// @return true on success or false on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_AudioDevicePaused
/// @see SDL_PauseAudioDevice
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_ResumeAudioDevice(SDL_AudioDeviceID devid);
/// ```
pub extern "C" fn sdl_ResumeAudioDevice(devid : SDL_AudioDeviceID) -> Bool = "SDL_ResumeAudioDevice"

///|
/// Use this function to query if an audio device is paused.
/// 
/// Physical devices can not be paused or unpaused, only logical devices
/// created through SDL_OpenAudioDevice() can be. Physical and invalid device
/// IDs will report themselves as unpaused here.
/// 
/// @param devid a device opened by SDL_OpenAudioDevice().
/// @return true if device is valid and paused, false otherwise.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_PauseAudioDevice
/// @see SDL_ResumeAudioDevice
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_AudioDevicePaused(SDL_AudioDeviceID devid);
/// ```
pub extern "C" fn sdl_AudioDevicePaused(devid : SDL_AudioDeviceID) -> Bool = "SDL_AudioDevicePaused"

///|
/// Get the gain of an audio device.
/// 
/// The gain of a device is its volume; a larger gain means a louder output,
/// with a gain of zero being silence.
/// 
/// Audio devices default to a gain of 1.0f (no change in output).
/// 
/// @param devid the audio device to query.
/// @return the gain of the device or -1.0f on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_SetAudioDeviceGain
/// 
/// ```c
/// extern SDL_DECLSPEC float SDLCALL SDL_GetAudioDeviceGain(SDL_AudioDeviceID devid);
/// ```
pub extern "C" fn sdl_GetAudioDeviceGain(devid : SDL_AudioDeviceID) -> Float = "SDL_GetAudioDeviceGain"

///|
/// Change the gain of an audio device.
/// 
/// The gain of a device is its volume; a larger gain means a louder output,
/// with a gain of zero being silence.
/// 
/// Audio devices default to a gain of 1.0f (no change in output).
/// 
/// @param devid the audio device on which to change gain.
/// @param gain the gain. 1.0f is no change, 0.0f is silence.
/// @return true on success or false on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetAudioDeviceGain
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetAudioDeviceGain(SDL_AudioDeviceID devid, float gain);
/// ```
pub extern "C" fn sdl_SetAudioDeviceGain(
  devid : SDL_AudioDeviceID,
  gain : Float,
) -> Bool = "SDL_SetAudioDeviceGain"

///|
/// Close a previously-opened audio device.
/// 
/// The application should close open audio devices once they are no longer
/// needed.
/// 
/// @param devid an audio device id previously returned by
///              SDL_OpenAudioDevice().
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_OpenAudioDevice
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_CloseAudioDevice(SDL_AudioDeviceID devid);
/// ```
pub extern "C" fn sdl_CloseAudioDevice(devid : SDL_AudioDeviceID) = "SDL_CloseAudioDevice"

///|
/// Bind a single audio stream to an audio device.
/// 
/// @param devid an audio device to bind a stream to.
/// @param stream an audio stream to bind to a device.
/// @return true on success or false on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_BindAudioStreams
/// @see SDL_UnbindAudioStream
/// @see SDL_GetAudioStreamDevice
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_BindAudioStream(SDL_AudioDeviceID devid, SDL_AudioStream *stream);
/// ```
pub extern "C" fn sdl_BindAudioStream(
  devid : SDL_AudioDeviceID,
  stream : SDL_AudioStream,
) -> Bool = "SDL_BindAudioStream"

///|
/// Unbind a single audio stream from its audio device.
/// 
/// @param stream an audio stream to unbind from a device. Can be NULL.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_BindAudioStream
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_UnbindAudioStream(SDL_AudioStream *stream);
/// ```
pub extern "C" fn sdl_UnbindAudioStream(stream : SDL_AudioStream) = "SDL_UnbindAudioStream"

///|
/// Query an audio stream for its currently-bound device.
/// 
/// This reports the logical audio device that an audio stream is currently
/// bound to.
/// 
/// If not bound, or invalid, this returns zero, which is not a valid device
/// ID.
/// 
/// @param stream the audio stream to query.
/// @return the bound audio device, or 0 if not bound or invalid.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_BindAudioStream
/// @see SDL_BindAudioStreams
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_AudioDeviceID SDLCALL SDL_GetAudioStreamDevice(SDL_AudioStream *stream);
/// ```
pub extern "C" fn sdl_GetAudioStreamDevice(
  stream : SDL_AudioStream,
) -> SDL_AudioDeviceID = "SDL_GetAudioStreamDevice"

///|
/// Create a new audio stream.
/// 
/// @param src_spec the format details of the input audio.
/// @param dst_spec the format details of the output audio.
/// @return a new audio stream on success or NULL on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_PutAudioStreamData
/// @see SDL_GetAudioStreamData
/// @see SDL_GetAudioStreamAvailable
/// @see SDL_FlushAudioStream
/// @see SDL_ClearAudioStream
/// @see SDL_SetAudioStreamFormat
/// @see SDL_DestroyAudioStream
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_AudioStream * SDLCALL SDL_CreateAudioStream(const SDL_AudioSpec *src_spec, const SDL_AudioSpec *dst_spec);
/// ```
#owned(src_spec, dst_spec)
pub extern "C" fn sdl_CreateAudioStream(
  src_spec : FixedArray[SDL_AudioSpec],
  dst_spec : FixedArray[SDL_AudioSpec],
) -> SDL_AudioStream = "SDL_CreateAudioStream"

///|
/// Query the current format of an audio stream.
/// 
/// @param stream the SDL_AudioStream to query.
/// @param src_spec where to store the input audio format; ignored if NULL.
/// @param dst_spec where to store the output audio format; ignored if NULL.
/// @return true on success or false on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_SetAudioStreamFormat
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetAudioStreamFormat(SDL_AudioStream *stream, SDL_AudioSpec *src_spec, SDL_AudioSpec *dst_spec);
/// ```
#owned(src_spec, dst_spec)
pub extern "C" fn sdl_GetAudioStreamFormat(
  stream : SDL_AudioStream,
  src_spec : FixedArray[SDL_AudioSpec],
  dst_spec : FixedArray[SDL_AudioSpec],
) -> Bool = "SDL_GetAudioStreamFormat"

///|
/// Change the input and output formats of an audio stream.
/// 
/// @param stream the stream the format is being changed.
/// @param src_spec the new format of the audio input; if NULL, it is not
///                 changed.
/// @param dst_spec the new format of the audio output; if NULL, it is not
///                 changed.
/// @return true on success or false on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetAudioStreamFormat
/// @see SDL_SetAudioStreamFrequencyRatio
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetAudioStreamFormat(SDL_AudioStream *stream, const SDL_AudioSpec *src_spec, const SDL_AudioSpec *dst_spec);
/// ```
#owned(src_spec, dst_spec)
pub extern "C" fn sdl_SetAudioStreamFormat(
  stream : SDL_AudioStream,
  src_spec : FixedArray[SDL_AudioSpec],
  dst_spec : FixedArray[SDL_AudioSpec],
) -> Bool = "SDL_SetAudioStreamFormat"

///|
/// Get the frequency ratio of an audio stream.
/// 
/// @param stream the SDL_AudioStream to query.
/// @return the frequency ratio of the stream or 0.0 on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_SetAudioStreamFrequencyRatio
/// 
/// ```c
/// extern SDL_DECLSPEC float SDLCALL SDL_GetAudioStreamFrequencyRatio(SDL_AudioStream *stream);
/// ```
pub extern "C" fn sdl_GetAudioStreamFrequencyRatio(
  stream : SDL_AudioStream,
) -> Float = "SDL_GetAudioStreamFrequencyRatio"

///|
/// Change the frequency ratio of an audio stream.
/// 
/// The frequency ratio is used to adjust the rate at which input data is
/// consumed. Changing this effectively modifies the speed and pitch of the
/// audio.
/// 
/// @param stream the stream on which the frequency ratio is being changed.
/// @param ratio the frequency ratio. 1.0 is normal speed. Must be between 0.01
///              and 100.
/// @return true on success or false on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetAudioStreamFrequencyRatio
/// @see SDL_SetAudioStreamFormat
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetAudioStreamFrequencyRatio(SDL_AudioStream *stream, float ratio);
/// ```
pub extern "C" fn sdl_SetAudioStreamFrequencyRatio(
  stream : SDL_AudioStream,
  ratio : Float,
) -> Bool = "SDL_SetAudioStreamFrequencyRatio"

///|
/// Get the gain of an audio stream.
/// 
/// The gain of a stream is its volume; a larger gain means a louder output,
/// with a gain of zero being silence.
/// 
/// Audio streams default to a gain of 1.0f (no change in output).
/// 
/// @param stream the SDL_AudioStream to query.
/// @return the gain of the stream or -1.0f on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_SetAudioStreamGain
/// 
/// ```c
/// extern SDL_DECLSPEC float SDLCALL SDL_GetAudioStreamGain(SDL_AudioStream *stream);
/// ```
pub extern "C" fn sdl_GetAudioStreamGain(stream : SDL_AudioStream) -> Float = "SDL_GetAudioStreamGain"

///|
/// Change the gain of an audio stream.
/// 
/// The gain of a stream is its volume; a larger gain means a louder output,
/// with a gain of zero being silence.
/// 
/// Audio streams default to a gain of 1.0f (no change in output).
/// 
/// @param stream the stream on which the gain is being changed.
/// @param gain the gain. 1.0f is no change, 0.0f is silence.
/// @return true on success or false on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetAudioStreamGain
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetAudioStreamGain(SDL_AudioStream *stream, float gain);
/// ```
pub extern "C" fn sdl_SetAudioStreamGain(
  stream : SDL_AudioStream,
  gain : Float,
) -> Bool = "SDL_SetAudioStreamGain"

///|
/// Add data to the stream.
/// 
/// This data must match the format/channels/samplerate specified in the latest
/// call to SDL_SetAudioStreamFormat, or the format specified when creating the
/// stream if it hasn't been changed.
/// 
/// @param stream the stream the audio data is being added to.
/// @param buf a pointer to the audio data to add.
/// @param len the number of bytes to write to the stream.
/// @return true on success or false on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_ClearAudioStream
/// @see SDL_FlushAudioStream
/// @see SDL_GetAudioStreamData
/// @see SDL_GetAudioStreamQueued
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_PutAudioStreamData(SDL_AudioStream *stream, const void *buf, int len);
/// ```
pub extern "C" fn sdl_PutAudioStreamData(
  stream : SDL_AudioStream,
  buf : VoidPtr,
  len : Int,
) -> Bool = "SDL_PutAudioStreamData"

///|
/// Get converted/resampled data from the stream.
/// 
/// The input/output data format/channels/samplerate is specified when creating
/// the stream, and can be changed after creation by calling
/// SDL_SetAudioStreamFormat.
/// 
/// @param stream the stream the audio is being requested from.
/// @param buf a buffer to fill with audio data.
/// @param len the maximum number of bytes to fill.
/// @return the number of bytes read from the stream or -1 on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_ClearAudioStream
/// @see SDL_GetAudioStreamAvailable
/// @see SDL_PutAudioStreamData
/// 
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetAudioStreamData(SDL_AudioStream *stream, void *buf, int len);
/// ```
pub extern "C" fn sdl_GetAudioStreamData(
  stream : SDL_AudioStream,
  buf : VoidPtr,
  len : Int,
) -> Int = "SDL_GetAudioStreamData"

///|
/// Get the number of converted/resampled bytes available.
/// 
/// The stream may be buffering data behind the scenes until it has enough to
/// resample correctly, so this number might be lower than what you expect, or
/// even be zero.
/// 
/// @param stream the audio stream to query.
/// @return the number of converted/resampled bytes available or -1 on
///          failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetAudioStreamData
/// @see SDL_PutAudioStreamData
/// 
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetAudioStreamAvailable(SDL_AudioStream *stream);
/// ```
pub extern "C" fn sdl_GetAudioStreamAvailable(stream : SDL_AudioStream) -> Int = "SDL_GetAudioStreamAvailable"

///|
/// Get the number of bytes currently queued.
/// 
/// This is the number of bytes put into a stream as input, not the number that
/// can be retrieved as output.
/// 
/// @param stream the audio stream to query.
/// @return the number of bytes queued or -1 on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_PutAudioStreamData
/// @see SDL_ClearAudioStream
/// 
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetAudioStreamQueued(SDL_AudioStream *stream);
/// ```
pub extern "C" fn sdl_GetAudioStreamQueued(stream : SDL_AudioStream) -> Int = "SDL_GetAudioStreamQueued"

///|
/// Tell the stream that you're done sending data, and anything being buffered
/// should be converted/resampled and made available immediately.
/// 
/// It is legal to add more data to a stream after flushing, but there may be
/// audio gaps in the output.
/// 
/// @param stream the audio stream to flush.
/// @return true on success or false on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_PutAudioStreamData
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_FlushAudioStream(SDL_AudioStream *stream);
/// ```
pub extern "C" fn sdl_FlushAudioStream(stream : SDL_AudioStream) -> Bool = "SDL_FlushAudioStream"

///|
/// Clear any pending data in the stream.
/// 
/// This drops any queued data, so there will be nothing to read from the
/// stream until more is added.
/// 
/// @param stream the audio stream to clear.
/// @return true on success or false on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetAudioStreamAvailable
/// @see SDL_GetAudioStreamData
/// @see SDL_GetAudioStreamQueued
/// @see SDL_PutAudioStreamData
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_ClearAudioStream(SDL_AudioStream *stream);
/// ```
pub extern "C" fn sdl_ClearAudioStream(stream : SDL_AudioStream) -> Bool = "SDL_ClearAudioStream"

///|
/// Set a callback that runs when data is requested from an audio stream.
/// 
/// This callback is called _before_ data is obtained from the stream, giving
/// the callback the chance to add more on-demand.
/// 
/// @param stream the audio stream to set the new callback on.
/// @param callback the new callback function to call when data is requested
///                 from the stream.
/// @param userdata an opaque pointer provided to the callback for its own
///                 personal use.
/// @return true on success or false on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_SetAudioStreamPutCallback
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetAudioStreamGetCallback(SDL_AudioStream *stream, SDL_AudioStreamCallback callback, void *userdata);
/// ```
pub extern "C" fn sdl_SetAudioStreamGetCallback(
  stream : SDL_AudioStream,
  callback : SDL_AudioStreamCallback,
  userdata : VoidPtr,
) -> Bool = "SDL_SetAudioStreamGetCallback"

///|
/// Set a callback that runs when data is added to an audio stream.
/// 
/// This callback is called _after_ the data is added to the stream, giving the
/// callback the chance to obtain it immediately.
/// 
/// @param stream the audio stream to set the new callback on.
/// @param callback the new callback function to call when data is added to the
///                 stream.
/// @param userdata an opaque pointer provided to the callback for its own
///                 personal use.
/// @return true on success or false on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_SetAudioStreamGetCallback
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetAudioStreamPutCallback(SDL_AudioStream *stream, SDL_AudioStreamCallback callback, void *userdata);
/// ```
pub extern "C" fn sdl_SetAudioStreamPutCallback(
  stream : SDL_AudioStream,
  callback : SDL_AudioStreamCallback,
  userdata : VoidPtr,
) -> Bool = "SDL_SetAudioStreamPutCallback"

///|
/// Free an audio stream.
/// 
/// This will release all allocated data, including any audio that is still
/// queued. You do not need to manually clear the stream first.
/// 
/// @param stream the audio stream to destroy.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_CreateAudioStream
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_DestroyAudioStream(SDL_AudioStream *stream);
/// ```
pub extern "C" fn sdl_DestroyAudioStream(stream : SDL_AudioStream) = "SDL_DestroyAudioStream"

///|
/// Convenience function for straightforward audio init for the common case.
/// 
/// If all your app intends to do is provide a single source of PCM audio, this
/// function allows you to do all your audio setup in a single call.
/// 
/// @param devid an audio device to open, or SDL_AUDIO_DEVICE_DEFAULT_PLAYBACK
///              or SDL_AUDIO_DEVICE_DEFAULT_RECORDING.
/// @param spec the audio stream's data format. Can be NULL.
/// @param callback a callback where the app will provide new data for
///                 playback, or receive new data for recording. Can be NULL.
/// @param userdata app-controlled pointer passed to callback. Can be NULL.
/// @return an audio stream on success, ready to use, or NULL on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetAudioStreamDevice
/// @see SDL_ResumeAudioStreamDevice
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_AudioStream * SDLCALL SDL_OpenAudioDeviceStream(SDL_AudioDeviceID devid, const SDL_AudioSpec *spec, SDL_AudioStreamCallback callback, void *userdata);
/// ```
#owned(spec)
pub extern "C" fn sdl_OpenAudioDeviceStream(
  devid : SDL_AudioDeviceID,
  spec : FixedArray[SDL_AudioSpec],
  callback : SDL_AudioStreamCallback,
  userdata : VoidPtr,
) -> SDL_AudioStream = "SDL_OpenAudioDeviceStream"

///|
/// Load the audio data of a WAVE file into memory.
/// 
/// @param path the file path of the WAV file to open.
/// @param spec a pointer to an SDL_AudioSpec that will be set to the WAVE
///             data's format details on successful return.
/// @param audio_buf a pointer filled with the audio data, allocated by the
///                  function.
/// @param audio_len a pointer filled with the length of the audio data buffer
///                  in bytes.
/// @return true on success.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_free
/// @see SDL_LoadWAV_IO
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_LoadWAV(const char *path, SDL_AudioSpec *spec, Uint8 **audio_buf, Uint32 *audio_len);
/// ```
pub fn sdl_LoadWAV(
  path : String,
  spec : FixedArray[SDL_AudioSpec],
  audio_buf : FixedArray[FixedArray[UInt]],
  audio_len : FixedArray[UInt],
) -> Bool {
  __sdl_LoadWAV(string_to_cbytes(path), spec, audio_buf, audio_len)
}

///|
#owned(path, spec, audio_buf, audio_len)
extern "C" fn __sdl_LoadWAV(
  path : Bytes,
  spec : FixedArray[SDL_AudioSpec],
  audio_buf : FixedArray[FixedArray[UInt]],
  audio_len : FixedArray[UInt],
) -> Bool = "SDL_LoadWAV"

///|
/// Mix audio data in a specified format.
/// 
/// This takes an audio buffer `src` of `len` bytes of `format` data and mixes
/// it into `dst`, performing addition, volume adjustment, and overflow
/// clipping.
/// 
/// @param dst the destination for the mixed audio.
/// @param src the source audio buffer to be mixed.
/// @param format the SDL_AudioFormat structure representing the desired audio
///               format.
/// @param len the length of the audio buffer in bytes.
/// @param volume ranges from 0.0 - 1.0, and should be set to 1.0 for full
///               audio volume.
/// @return true on success or false on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_MixAudio(Uint8 *dst, const Uint8 *src, SDL_AudioFormat format, Uint32 len, float volume);
/// ```
#owned(dst, src)
pub extern "C" fn sdl_MixAudio(
  dst : FixedArray[UInt],
  src : FixedArray[UInt],
  format : SDL_AudioFormat,
  len : UInt,
  volume : Float,
) -> Bool = "SDL_MixAudio"

///|
/// Convert some audio data of one format to another format.
/// 
/// @param src_spec the format details of the input audio.
/// @param src_data the audio data to be converted.
/// @param src_len the len of src_data.
/// @param dst_spec the format details of the output audio.
/// @param dst_data will be filled with a pointer to converted audio data,
///                 which should be freed with SDL_free(). On error, it will be
///                 NULL.
/// @param dst_len will be filled with the len of dst_data.
/// @return true on success or false on failure.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_ConvertAudioSamples(const SDL_AudioSpec *src_spec, const Uint8 *src_data, int src_len, const SDL_AudioSpec *dst_spec, Uint8 **dst_data, int *dst_len);
/// ```
#owned(src_spec, src_data, dst_spec, dst_data, dst_len)
pub extern "C" fn sdl_ConvertAudioSamples(
  src_spec : FixedArray[SDL_AudioSpec],
  src_data : FixedArray[UInt],
  src_len : Int,
  dst_spec : FixedArray[SDL_AudioSpec],
  dst_data : FixedArray[FixedArray[UInt]],
  dst_len : FixedArray[Int],
) -> Bool = "SDL_ConvertAudioSamples"

///|
/// Get the human readable name of an audio format.
/// 
/// @param format the audio format to query.
/// @return the human readable name of the specified audio format or
///          "SDL_AUDIO_UNKNOWN" if the format isn't recognized.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetAudioFormatName(SDL_AudioFormat format);
/// ```
pub fn sdl_GetAudioFormatName(format : SDL_AudioFormat) -> String {
  let cres = __sdl_GetAudioFormatName(format)
  let res = cres.to_string()
  free_cstr(cres)
  res
}

///|
extern "C" fn __sdl_GetAudioFormatName(format : SDL_AudioFormat) -> CStr = "SDL_GetAudioFormatName"
