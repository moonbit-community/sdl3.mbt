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

/// # CategorySurface
/// 
/// SDL surfaces are buffers of pixels in system RAM. These are useful for
/// passing around and manipulating images that are not stored in GPU memory.
/// 
/// SDL_Surface makes serious efforts to manage images in various formats, and
/// provides a reasonable toolbox for transforming the data, including copying
/// between surfaces, filling rectangles in the image data, etc.
/// 
/// There is also a simple .bmp loader, SDL_LoadBMP(). SDL itself does not
/// provide loaders for various other file formats, but there are several
/// excellent external libraries that do, including its own satellite library,
/// [SDL_image](https://wiki.libsdl.org/SDL3_image)
/// :
/// 
/// https://github.com/libsdl-org/SDL_image

///|
/// The flags on an SDL_Surface.
/// 
/// These are generally considered read-only.
/// 
/// @since This datatype is available since SDL 3.2.0.
/// 
/// ```c
/// typedef Uint32 SDL_SurfaceFlags;
/// ```
pub type SDL_SurfaceFlags = UInt

///|
/// Surface uses preallocated pixel memory
pub const SDL_SURFACE_PREALLOCATED : UInt = 0x00000001

///|
/// Surface needs to be locked to access pixels
pub const SDL_SURFACE_LOCK_NEEDED : UInt = 0x00000002

///|
/// Surface is currently locked
pub const SDL_SURFACE_LOCKED : UInt = 0x00000004

///|
/// Surface uses pixel memory allocated with SDL_aligned_alloc()
pub const SDL_SURFACE_SIMD_ALIGNED : UInt = 0x00000008

///|
/// The scaling mode.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_ScaleMode
/// {
///     SDL_SCALEMODE_INVALID = -1,
///     SDL_SCALEMODE_NEAREST,  /**< nearest pixel sampling */
///     SDL_SCALEMODE_LINEAR,   /**< linear filtering */
///     SDL_SCALEMODE_PIXELART  /**< nearest pixel sampling with improved scaling for pixel art */
/// } SDL_ScaleMode;
/// ```
pub(all) enum SDL_ScaleMode {
  SDL_SCALEMODE_NEAREST
  SDL_SCALEMODE_LINEAR
  SDL_SCALEMODE_PIXELART
}

///|
/// The flip mode.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_FlipMode
/// {
///     SDL_FLIP_NONE,          /**< Do not flip */
///     SDL_FLIP_HORIZONTAL,    /**< flip horizontally */
///     SDL_FLIP_VERTICAL       /**< flip vertically */
/// } SDL_FlipMode;
/// ```
pub(all) enum SDL_FlipMode {
  ///< Do not flip
  ///< flip horizontally
  ///< flip vertically
  SDL_FLIP_NONE
  SDL_FLIP_HORIZONTAL
  SDL_FLIP_VERTICAL
}

///|
#external
pub type SDL_Surface

// SDL_PixelFormat is already defined in pixels.mbt as an enum
// SDL_Colorspace is defined as external type in video/pixels modules  
// SDL_PropertiesID is handled as UInt throughout the codebase

///|
/// Allocate a new surface with a specific pixel format.
/// 
/// The pixels of the new surface are initialized to zero.
/// 
/// @param width the width of the surface.
/// @param height the height of the surface.
/// @param format the SDL_PixelFormat for the new surface's pixel format.
/// @return the new SDL_Surface structure that is created or NULL on failure;
///          call SDL_GetError() for more information.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_CreateSurfaceFrom
/// @see SDL_DestroySurface
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL SDL_CreateSurface(int width, int height, SDL_PixelFormat format);
/// ```
pub extern "C" fn sdl_CreateSurface(
  width : Int,
  height : Int,
  format : SDL_PixelFormat,
) -> SDL_Surface = "SDL_CreateSurface"

///|
/// Allocate a new surface with a specific pixel format and existing pixel
/// data.
/// 
/// No copy is made of the pixel data. Pixel data is not managed automatically;
/// you must free the surface before you free the pixel data.
/// 
/// Pitch is the offset in bytes from one row of pixels to the next, e.g.
/// `width*4` for `SDL_PIXELFORMAT_RGBA8888`.
/// 
/// You may pass NULL for pixels and 0 for pitch to create a surface that you
/// will fill in with valid values later.
/// 
/// @param width the width of the surface.
/// @param height the height of the surface.
/// @param format the SDL_PixelFormat for the new surface's pixel format.
/// @param pixels a pointer to existing pixel data.
/// @param pitch the number of bytes between each row, including padding.
/// @return the new SDL_Surface structure that is created or NULL on failure;
///          call SDL_GetError() for more information.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_CreateSurface
/// @see SDL_DestroySurface
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL SDL_CreateSurfaceFrom(int width, int height, SDL_PixelFormat format, void *pixels, int pitch);
/// ```
pub extern "C" fn sdl_CreateSurfaceFrom(
  width : Int,
  height : Int,
  format : SDL_PixelFormat,
  pixels : VoidPtr,
  pitch : Int,
) -> SDL_Surface = "SDL_CreateSurfaceFrom"

///|
/// Free a surface.
/// 
/// It is safe to pass NULL to this function.
/// 
/// @param surface the SDL_Surface to free.
/// 
/// @threadsafety No other thread should be using the surface when it is freed.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_CreateSurface
/// @see SDL_CreateSurfaceFrom
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_DestroySurface(SDL_Surface *surface);
/// ```
pub extern "C" fn sdl_DestroySurface(surface : SDL_Surface) = "SDL_DestroySurface"

///|
/// Get the properties associated with a surface.
/// 
/// The following properties are understood by SDL:
/// 
/// - `SDL_PROP_SURFACE_SDR_WHITE_POINT_FLOAT`: for HDR10 and floating point
///   surfaces, this defines the value of 100% diffuse white, with higher
///   values being displayed in the High Dynamic Range headroom. This defaults
///   to 203 for HDR10 surfaces and 1.0 for floating point surfaces.
/// - `SDL_PROP_SURFACE_HDR_HEADROOM_FLOAT`: for HDR10 and floating point
///   surfaces, this defines the maximum dynamic range used by the content, in
///   terms of the SDR white point. This defaults to 0.0, which disables tone
///   mapping.
/// - `SDL_PROP_SURFACE_TONEMAP_OPERATOR_STRING`: the tone mapping operator
///   used when compressing from a surface with high dynamic range to another
///   with lower dynamic range. Currently this supports "chrome", which uses
///   the same tone mapping that Chrome uses for HDR content, the form "*=N",
///   where N is a floating point scale factor applied in linear space, and
///   "none", which disables tone mapping. This defaults to "chrome".
/// - `SDL_PROP_SURFACE_HOTSPOT_X_NUMBER`: the hotspot pixel offset from the
///   left edge of the image, if this surface is being used as a cursor.
/// - `SDL_PROP_SURFACE_HOTSPOT_Y_NUMBER`: the hotspot pixel offset from the
///   top edge of the image, if this surface is being used as a cursor.
/// 
/// @param surface the SDL_Surface structure to query.
/// @return a valid property ID on success or 0 on failure; call
///          SDL_GetError() for more information.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_PropertiesID SDLCALL SDL_GetSurfaceProperties(SDL_Surface *surface);
/// ```
pub extern "C" fn sdl_GetSurfaceProperties(surface : SDL_Surface) -> UInt = "SDL_GetSurfaceProperties"

///|
pub const SDL_PROP_SURFACE_SDR_WHITE_POINT_FLOAT : String = "SDL.surface.SDR_white_point"

///|
pub const SDL_PROP_SURFACE_HDR_HEADROOM_FLOAT : String = "SDL.surface.HDR_headroom"

///|
pub const SDL_PROP_SURFACE_TONEMAP_OPERATOR_STRING : String = "SDL.surface.tonemap"

///|
pub const SDL_PROP_SURFACE_HOTSPOT_X_NUMBER : String = "SDL.surface.hotspot.x"

///|
pub const SDL_PROP_SURFACE_HOTSPOT_Y_NUMBER : String = "SDL.surface.hotspot.y"

///|
/// Set the colorspace used by a surface.
/// 
/// Setting the colorspace doesn't change the pixels, only how they are
/// interpreted in color operations.
/// 
/// @param surface the SDL_Surface structure to update.
/// @param colorspace an SDL_Colorspace value describing the surface
///                   colorspace.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function is not thread safe.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetSurfaceColorspace
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetSurfaceColorspace(SDL_Surface *surface, SDL_Colorspace colorspace);
/// ```
pub extern "C" fn sdl_SetSurfaceColorspace(
  surface : SDL_Surface,
  colorspace : SDL_Colorspace,
) -> Bool = "SDL_SetSurfaceColorspace"

///|
/// Get the colorspace used by a surface.
/// 
/// The colorspace defaults to SDL_COLORSPACE_SRGB_LINEAR for floating point
/// formats, SDL_COLORSPACE_HDR10 for 10-bit formats, SDL_COLORSPACE_SRGB for
/// other RGB surfaces and SDL_COLORSPACE_BT709_FULL for YUV textures.
/// 
/// @param surface the SDL_Surface structure to query.
/// @return the colorspace used by the surface, or SDL_COLORSPACE_UNKNOWN if
///          the surface is NULL.
/// 
/// @threadsafety This function is not thread safe.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_SetSurfaceColorspace
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_Colorspace SDLCALL SDL_GetSurfaceColorspace(SDL_Surface *surface);
/// ```
pub extern "C" fn sdl_GetSurfaceColorspace(
  surface : SDL_Surface,
) -> SDL_Colorspace = "SDL_GetSurfaceColorspace"

///|
/// Perform a fast blit from the source surface to the destination surface.
/// 
/// @param src the SDL_Surface structure to be copied from.
/// @param srcrect the SDL_Rect structure representing the rectangle to be
///                copied, or NULL to copy the entire surface.
/// @param dst the SDL_Surface structure that is the blit target.
/// @param dstrect the SDL_Rect structure representing the target rectangle in
///                the destination surface, or NULL to fill the entire
///                destination surface.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety Only one thread should be using the `src` and `dst` surfaces
///               at any given time.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_BlitSurfaceScaled
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_BlitSurface(SDL_Surface *src, const SDL_Rect *srcrect, SDL_Surface *dst, const SDL_Rect *dstrect);
/// ```
#owned(srcrect, dstrect)
pub extern "C" fn sdl_BlitSurface(
  src : SDL_Surface,
  srcrect : FixedArray[SDL_Rect],
  dst : SDL_Surface,
  dstrect : FixedArray[SDL_Rect],
) -> Bool = "SDL_BlitSurface"

///|
/// Perform a scaled blit to a destination surface, which may be of a different
/// format.
/// 
/// @param src the SDL_Surface structure to be copied from.
/// @param srcrect the SDL_Rect structure representing the rectangle to be
///                copied, or NULL to copy the entire surface.
/// @param dst the SDL_Surface structure that is the blit target.
/// @param dstrect the SDL_Rect structure representing the target rectangle in
///                the destination surface, or NULL to fill the entire
///                destination surface.
/// @param scaleMode the SDL_ScaleMode to be used.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety Only one thread should be using the `src` and `dst` surfaces
///               at any given time.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_BlitSurface
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_BlitSurfaceScaled(SDL_Surface *src, const SDL_Rect *srcrect, SDL_Surface *dst, const SDL_Rect *dstrect, SDL_ScaleMode scaleMode);
/// ```
#owned(srcrect, dstrect)
pub extern "C" fn sdl_BlitSurfaceScaled(
  src : SDL_Surface,
  srcrect : FixedArray[SDL_Rect],
  dst : SDL_Surface,
  dstrect : FixedArray[SDL_Rect],
  scaleMode : SDL_ScaleMode,
) -> Bool = "SDL_BlitSurfaceScaled"

///|
/// Perform a tiled blit to a destination surface, which may be of a different
/// format.
/// 
/// The pixels in `srcrect` will be repeated as many times as needed to
/// completely fill `dstrect`.
/// 
/// @param src the SDL_Surface structure to be copied from.
/// @param srcrect the SDL_Rect structure representing the rectangle to be
///                copied, or NULL to copy the entire surface.
/// @param dst the SDL_Surface structure that is the blit target.
/// @param dstrect the SDL_Rect structure representing the target rectangle in
///                the destination surface, or NULL to fill the entire surface.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety Only one thread should be using the `src` and `dst` surfaces
///               at any given time.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_BlitSurface
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_BlitSurfaceTiled(SDL_Surface *src, const SDL_Rect *srcrect, SDL_Surface *dst, const SDL_Rect *dstrect);
/// ```
#owned(srcrect, dstrect)
pub extern "C" fn sdl_BlitSurfaceTiled(
  src : SDL_Surface,
  srcrect : FixedArray[SDL_Rect],
  dst : SDL_Surface,
  dstrect : FixedArray[SDL_Rect],
) -> Bool = "SDL_BlitSurfaceTiled"

///|
/// Map an RGB triple to an opaque pixel value for a surface.
/// 
/// This function maps the RGB color value to the specified pixel format and
/// returns the pixel value best approximating the given RGB color value for
/// the given pixel format.
/// 
/// If the surface has a palette, the index of the closest matching color in
/// the palette will be returned.
/// 
/// If the surface pixel format has an alpha component it will be returned as
/// all 1 bits (fully opaque).
/// 
/// If the pixel format bpp (color depth) is less than 32-bpp then the unused
/// upper bits of the return value can safely be ignored (e.g., with a 16-bpp
/// format the return value can be assigned to a Uint16, and similarly a Uint8
/// for an 8-bpp format).
/// 
/// @param surface the surface to use for the pixel format and palette.
/// @param r the red component of the pixel in the range 0-255.
/// @param g the green component of the pixel in the range 0-255.
/// @param b the blue component of the pixel in the range 0-255.
/// @return a pixel value.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_MapSurfaceRGBA
/// 
/// ```c
/// extern SDL_DECLSPEC Uint32 SDLCALL SDL_MapSurfaceRGB(SDL_Surface *surface, Uint8 r, Uint8 g, Uint8 b);
/// ```
pub extern "C" fn sdl_MapSurfaceRGB(
  surface : SDL_Surface,
  r : Byte,
  g : Byte,
  b : Byte,
) -> UInt = "SDL_MapSurfaceRGB"

///|
/// Map an RGBA quadruple to a pixel value for a surface.
/// 
/// This function maps the RGBA color value to the specified pixel format and
/// returns the pixel value best approximating the given RGBA color value for
/// the given pixel format.
/// 
/// If the surface pixel format has no alpha component the alpha value will be
/// ignored (as it will be in formats with a palette).
/// 
/// If the surface has a palette, the index of the closest matching color in
/// the palette will be returned.
/// 
/// If the pixel format bpp (color depth) is less than 32-bpp then the unused
/// upper bits of the return value can safely be ignored (e.g., with a 16-bpp
/// format the return value can be assigned to a Uint16, and similarly a Uint8
/// for an 8-bpp format).
/// 
/// @param surface the surface to use for the pixel format and palette.
/// @param r the red component of the pixel in the range 0-255.
/// @param g the green component of the pixel in the range 0-255.
/// @param b the blue component of the pixel in the range 0-255.
/// @param a the alpha component of the pixel in the range 0-255.
/// @return a pixel value.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_MapSurfaceRGB
/// 
/// ```c
/// extern SDL_DECLSPEC Uint32 SDLCALL SDL_MapSurfaceRGBA(SDL_Surface *surface, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
/// ```
pub extern "C" fn sdl_MapSurfaceRGBA(
  surface : SDL_Surface,
  r : Byte,
  g : Byte,
  b : Byte,
  a : Byte,
) -> UInt = "SDL_MapSurfaceRGBA"

///|
/// Retrieves a single pixel from a surface.
/// 
/// This function prioritizes correctness over speed: it is suitable for unit
/// tests, but is not intended for use in a game engine.
/// 
/// Like SDL_GetRGBA, this uses the entire 0..255 range when converting color
/// components from pixel formats with less than 8 bits per RGB component.
/// 
/// @param surface the surface to read.
/// @param x the horizontal coordinate, 0 <= x < width.
/// @param y the vertical coordinate, 0 <= y < height.
/// @param r a pointer filled in with the red channel, 0-255, or NULL to ignore
///          this channel.
/// @param g a pointer filled in with the green channel, 0-255, or NULL to
///          ignore this channel.
/// @param b a pointer filled in with the blue channel, 0-255, or NULL to
///          ignore this channel.
/// @param a a pointer filled in with the alpha channel, 0-255, or NULL to
///          ignore this channel.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function is not thread safe.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_ReadSurfacePixel(SDL_Surface *surface, int x, int y, Uint8 *r, Uint8 *g, Uint8 *b, Uint8 *a);
/// ```
#owned(r, g, b, a)
pub extern "C" fn sdl_ReadSurfacePixel(
  surface : SDL_Surface,
  x : Int,
  y : Int,
  r : FixedArray[Byte],
  g : FixedArray[Byte],
  b : FixedArray[Byte],
  a : FixedArray[Byte],
) -> Bool = "SDL_ReadSurfacePixel"

///|
/// Writes a single pixel to a surface.
/// 
/// This function prioritizes correctness over speed: it is suitable for unit
/// tests, but is not intended for use in a game engine.
/// 
/// Like SDL_MapRGBA, this uses the entire 0..255 range when converting color
/// components from pixel formats with less than 8 bits per RGB component.
/// 
/// @param surface the surface to write.
/// @param x the horizontal coordinate, 0 <= x < width.
/// @param y the vertical coordinate, 0 <= y < height.
/// @param r the red channel value, 0-255.
/// @param g the green channel value, 0-255.
/// @param b the blue channel value, 0-255.
/// @param a the alpha channel value, 0-255.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function is not thread safe.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_WriteSurfacePixel(SDL_Surface *surface, int x, int y, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
/// ```
pub extern "C" fn sdl_WriteSurfacePixel(
  surface : SDL_Surface,
  x : Int,
  y : Int,
  r : Byte,
  g : Byte,
  b : Byte,
  a : Byte,
) -> Bool = "SDL_WriteSurfacePixel"

///|
/// Load a BMP image from a file.
/// 
/// @param file the BMP file to load.
/// @return a new SDL_Surface with the loaded image, or NULL on error.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL SDL_LoadBMP(const char *file);
/// ```
#owned(file)
extern "C" fn __sdl_LoadBMP(file : Bytes) -> SDL_Surface = "SDL_LoadBMP"

///|
pub fn sdl_LoadBMP(file : String) -> SDL_Surface {
  __sdl_LoadBMP(string_to_cbytes(file))
}

///|
/// Save a BMP image to a file.
/// 
/// @param surface the surface to save.
/// @param file the BMP file to save to.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety This function should only be called on the main thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SaveBMP(SDL_Surface *surface, const char *file);
/// ```
#owned(file)
extern "C" fn __sdl_SaveBMP(surface : SDL_Surface, file : Bytes) -> Bool = "SDL_SaveBMP"

///|
pub fn sdl_SaveBMP(surface : SDL_Surface, file : String) -> Bool {
  __sdl_SaveBMP(surface, string_to_cbytes(file))
}
