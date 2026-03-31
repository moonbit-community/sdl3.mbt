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

/// # CategorySDLImage
///
/// Header file for SDL_image library
///
/// A simple library to load images of various formats as SDL surfaces

///|
/// SDL_image version constants
pub const SDL_IMAGE_MAJOR_VERSION : Int = 3

///|
pub const SDL_IMAGE_MINOR_VERSION : Int = 2

///|
pub const SDL_IMAGE_MICRO_VERSION : Int = 4

///|
/// Animation support structure
///
/// Currently only animated GIFs and WEBP images are supported.
///
/// ```c
/// typedef struct IMG_Animation
/// {
///     int w, h;
///     int count;
///     SDL_Surface **frames;
///     int *delays;
/// } IMG_Animation;
/// ```
#external
pub type IMG_Animation

///|
/// Get the version of the dynamically linked SDL_image library.
///
/// @return SDL_image version.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL IMG_Version(void);
/// ```
pub extern "C" fn img_Version() -> Int = "IMG_Version"

///|
/// Load an image from a filesystem path into a software surface.
///
/// An SDL_Surface is a buffer of pixels in memory accessible by the CPU. Use
/// this if you plan to hand the data to something else or manipulate it
/// further in code.
///
/// @param file a path on the filesystem to load an image from.
/// @return a new SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_Load(const char *file);
/// ```
#owned(file)
extern "C" fn __img_Load(file : Bytes) -> SDL_Surface = "IMG_Load"

///|
pub fn img_Load(file : String) -> SDL_Surface {
  __img_Load(string_to_cbytes(file))
}

///|
/// Load an image from an SDL data source into a software surface.
///
/// @param src an SDL_IOStream that data will be read from.
/// @param closeio true to close/free the SDL_IOStream before returning, false
///                to leave it open.
/// @return a new SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_Load_IO(SDL_IOStream *src, bool closeio);
/// ```
pub extern "C" fn img_Load_IO(
  src : SDL_IOStream,
  closeio : Bool,
) -> SDL_Surface = "IMG_Load_IO"

///|
/// Load an image from an SDL data source into a software surface.
///
/// @param src an SDL_IOStream that data will be read from.
/// @param closeio true to close/free the SDL_IOStream before returning, false
///                to leave it open.
/// @param type a filename extension that represent this data ("BMP", "GIF",
///             "PNG", etc).
/// @return a new SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadTyped_IO(SDL_IOStream *src, bool closeio, const char *type);
/// ```
#owned(type_)
extern "C" fn __img_LoadTyped_IO(
  src : SDL_IOStream,
  closeio : Bool,
  type_ : Bytes,
) -> SDL_Surface = "IMG_LoadTyped_IO"

///|
pub fn img_LoadTyped_IO(
  src : SDL_IOStream,
  closeio : Bool,
  type_ : String,
) -> SDL_Surface {
  __img_LoadTyped_IO(src, closeio, string_to_cbytes(type_))
}

///|
/// Load an image from a filesystem path into a GPU texture.
///
/// @param renderer the SDL_Renderer to use to create the GPU texture.
/// @param file a path on the filesystem to load an image from.
/// @return a new texture, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Texture * SDLCALL IMG_LoadTexture(SDL_Renderer *renderer, const char *file);
/// ```
#owned(file)
extern "C" fn __img_LoadTexture(
  renderer : SDL_Renderer,
  file : Bytes,
) -> SDL_Texture = "IMG_LoadTexture"

///|
pub fn img_LoadTexture(renderer : SDL_Renderer, file : String) -> SDL_Texture {
  __img_LoadTexture(renderer, string_to_cbytes(file))
}

///|
/// Load an image from an SDL data source into a GPU texture.
///
/// @param renderer the SDL_Renderer to use to create the GPU texture.
/// @param src an SDL_IOStream that data will be read from.
/// @param closeio true to close/free the SDL_IOStream before returning, false
///                to leave it open.
/// @return a new texture, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Texture * SDLCALL IMG_LoadTexture_IO(SDL_Renderer *renderer, SDL_IOStream *src, bool closeio);
/// ```
pub extern "C" fn img_LoadTexture_IO(
  renderer : SDL_Renderer,
  src : SDL_IOStream,
  closeio : Bool,
) -> SDL_Texture = "IMG_LoadTexture_IO"

///|
/// Load an image from an SDL data source into a GPU texture.
///
/// @param renderer the SDL_Renderer to use to create the GPU texture.
/// @param src an SDL_IOStream that data will be read from.
/// @param closeio true to close/free the SDL_IOStream before returning, false
///                to leave it open.
/// @param type a filename extension that represent this data ("BMP", "GIF",
///             "PNG", etc).
/// @return a new texture, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Texture * SDLCALL IMG_LoadTextureTyped_IO(SDL_Renderer *renderer, SDL_IOStream *src, bool closeio, const char *type);
/// ```
#owned(type_)
extern "C" fn __img_LoadTextureTyped_IO(
  renderer : SDL_Renderer,
  src : SDL_IOStream,
  closeio : Bool,
  type_ : Bytes,
) -> SDL_Texture = "IMG_LoadTextureTyped_IO"

///|
pub fn img_LoadTextureTyped_IO(
  renderer : SDL_Renderer,
  src : SDL_IOStream,
  closeio : Bool,
  type_ : String,
) -> SDL_Texture {
  __img_LoadTextureTyped_IO(renderer, src, closeio, string_to_cbytes(type_))
}

///| Detect image format functions
///
/// These functions attempt to determine if a file is a given filetype,
/// reading the least amount possible from the SDL_IOStream.

///|
/// Detect AVIF image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is AVIF data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isAVIF(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isAVIF(src : SDL_IOStream) -> Bool = "IMG_isAVIF"

///|
/// Detect ICO image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is ICO data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isICO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isICO(src : SDL_IOStream) -> Bool = "IMG_isICO"

///|
/// Detect CUR image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is CUR data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isCUR(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isCUR(src : SDL_IOStream) -> Bool = "IMG_isCUR"

///|
/// Detect BMP image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is BMP data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isBMP(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isBMP(src : SDL_IOStream) -> Bool = "IMG_isBMP"

///|
/// Detect GIF image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is GIF data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isGIF(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isGIF(src : SDL_IOStream) -> Bool = "IMG_isGIF"

///|
/// Detect JPG image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is JPG data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isJPG(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isJPG(src : SDL_IOStream) -> Bool = "IMG_isJPG"

///|
/// Detect JXL image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is JXL data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isJXL(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isJXL(src : SDL_IOStream) -> Bool = "IMG_isJXL"

///|
/// Detect LBM image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is LBM data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isLBM(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isLBM(src : SDL_IOStream) -> Bool = "IMG_isLBM"

///|
/// Detect PCX image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is PCX data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isPCX(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isPCX(src : SDL_IOStream) -> Bool = "IMG_isPCX"

///|
/// Detect PNG image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is PNG data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isPNG(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isPNG(src : SDL_IOStream) -> Bool = "IMG_isPNG"

///|
/// Detect PNM image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is PNM data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isPNM(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isPNM(src : SDL_IOStream) -> Bool = "IMG_isPNM"

///|
/// Detect SVG image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is SVG data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isSVG(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isSVG(src : SDL_IOStream) -> Bool = "IMG_isSVG"

///|
/// Detect QOI image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is QOI data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isQOI(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isQOI(src : SDL_IOStream) -> Bool = "IMG_isQOI"

///|
/// Detect TIFF image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is TIFF data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isTIF(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isTIF(src : SDL_IOStream) -> Bool = "IMG_isTIF"

///|
/// Detect XCF image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is XCF data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isXCF(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isXCF(src : SDL_IOStream) -> Bool = "IMG_isXCF"

///|
/// Detect XPM image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is XPM data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isXPM(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isXPM(src : SDL_IOStream) -> Bool = "IMG_isXPM"

///|
/// Detect XV image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is XV data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isXV(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isXV(src : SDL_IOStream) -> Bool = "IMG_isXV"

///|
/// Detect WEBP image data on a readable/seekable SDL_IOStream.
///
/// @param src a seekable/readable SDL_IOStream to provide image data.
/// @return non-zero if this is WEBP data, zero otherwise.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_isWEBP(SDL_IOStream *src);
/// ```
pub extern "C" fn img_isWEBP(src : SDL_IOStream) -> Bool = "IMG_isWEBP"

///| Format-specific loading functions
///
/// If you know you definitely have a specific image format, you can call
/// these functions, which will skip SDL_image's file format detection routines.

///|
/// Load a AVIF image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadAVIF_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadAVIF_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadAVIF_IO"

///|
/// Load a ICO image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadICO_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadICO_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadICO_IO"

///|
/// Load a CUR image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadCUR_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadCUR_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadCUR_IO"

///|
/// Load a BMP image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadBMP_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadBMP_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadBMP_IO"

///|
/// Load a GIF image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadGIF_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadGIF_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadGIF_IO"

///|
/// Load a JPG image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadJPG_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadJPG_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadJPG_IO"

///|
/// Load a JXL image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadJXL_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadJXL_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadJXL_IO"

///|
/// Load a LBM image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadLBM_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadLBM_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadLBM_IO"

///|
/// Load a PCX image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadPCX_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadPCX_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadPCX_IO"

///|
/// Load a PNG image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadPNG_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadPNG_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadPNG_IO"

///|
/// Load a PNM image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadPNM_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadPNM_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadPNM_IO"

///|
/// Load a SVG image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadSVG_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadSVG_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadSVG_IO"

///|
/// Load a QOI image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadQOI_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadQOI_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadQOI_IO"

///|
/// Load a TGA image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadTGA_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadTGA_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadTGA_IO"

///|
/// Load a TIFF image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadTIF_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadTIF_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadTIF_IO"

///|
/// Load a XCF image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadXCF_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadXCF_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadXCF_IO"

///|
/// Load a XPM image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadXPM_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadXPM_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadXPM_IO"

///|
/// Load a XV image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadXV_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadXV_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadXV_IO"

///|
/// Load a WEBP image directly.
///
/// @param src an SDL_IOStream to load image data from.
/// @return SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadWEBP_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadWEBP_IO(src : SDL_IOStream) -> SDL_Surface = "IMG_LoadWEBP_IO"

///|
/// Load an SVG image, scaled to a specific size.
///
/// Since SVG files are resolution-independent, you specify the size you would
/// like the output image to be and it will be generated at those dimensions.
///
/// Either width or height may be 0 and the image will be auto-sized to
/// preserve aspect ratio.
///
/// @param src an SDL_IOStream to load SVG data from.
/// @param width desired width of the generated surface, in pixels.
/// @param height desired height of the generated surface, in pixels.
/// @return a new SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_LoadSizedSVG_IO(SDL_IOStream *src, int width, int height);
/// ```
pub extern "C" fn img_LoadSizedSVG_IO(
  src : SDL_IOStream,
  width : Int,
  height : Int,
) -> SDL_Surface = "IMG_LoadSizedSVG_IO"

///|
/// Load an XPM image from a memory array.
///
/// The returned surface will be an 8bpp indexed surface, if possible,
/// otherwise it will be 32bpp.
///
/// @param xpm a null-terminated array of strings that comprise XPM data.
/// @return a new SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_ReadXPMFromArray(char **xpm);
/// ```
#owned(xpm)
pub extern "C" fn img_ReadXPMFromArray(xpm : FixedArray[Bytes]) -> SDL_Surface = "IMG_ReadXPMFromArray"

///|
/// Load an XPM image from a memory array.
///
/// The returned surface will always be a 32-bit RGB surface.
///
/// @param xpm a null-terminated array of strings that comprise XPM data.
/// @return a new SDL surface, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL IMG_ReadXPMFromArrayToRGB888(char **xpm);
/// ```
#owned(xpm)
pub extern "C" fn img_ReadXPMFromArrayToRGB888(
  xpm : FixedArray[Bytes],
) -> SDL_Surface = "IMG_ReadXPMFromArrayToRGB888"

///|
/// Save an SDL_Surface into a AVIF image file.
///
/// If the file already exists, it will be overwritten.
///
/// @param surface the SDL surface to save.
/// @param file path on the filesystem to write new file to.
/// @param quality the desired quality, ranging between 0 (lowest) and 100
///                (highest).
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_SaveAVIF(SDL_Surface *surface, const char *file, int quality);
/// ```
#owned(file)
extern "C" fn __img_SaveAVIF(
  surface : SDL_Surface,
  file : Bytes,
  quality : Int,
) -> Bool = "IMG_SaveAVIF"

///|
pub fn img_SaveAVIF(
  surface : SDL_Surface,
  file : String,
  quality : Int,
) -> Bool {
  __img_SaveAVIF(surface, string_to_cbytes(file), quality)
}

///|
/// Save an SDL_Surface into AVIF image data, via an SDL_IOStream.
///
/// @param surface the SDL surface to save.
/// @param dst the SDL_IOStream to save the image data to.
/// @param closeio true to close/free the SDL_IOStream before returning, false
///                to leave it open.
/// @param quality the desired quality, ranging between 0 (lowest) and 100
///                (highest).
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_SaveAVIF_IO(SDL_Surface *surface, SDL_IOStream *dst, bool closeio, int quality);
/// ```
pub extern "C" fn img_SaveAVIF_IO(
  surface : SDL_Surface,
  dst : SDL_IOStream,
  closeio : Bool,
  quality : Int,
) -> Bool = "IMG_SaveAVIF_IO"

///|
/// Save an SDL_Surface into a PNG image file.
///
/// If the file already exists, it will be overwritten.
///
/// @param surface the SDL surface to save.
/// @param file path on the filesystem to write new file to.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_SavePNG(SDL_Surface *surface, const char *file);
/// ```
#owned(file)
extern "C" fn __img_SavePNG(surface : SDL_Surface, file : Bytes) -> Bool = "IMG_SavePNG"

///|
pub fn img_SavePNG(surface : SDL_Surface, file : String) -> Bool {
  __img_SavePNG(surface, string_to_cbytes(file))
}

///|
/// Save an SDL_Surface into PNG image data, via an SDL_IOStream.
///
/// @param surface the SDL surface to save.
/// @param dst the SDL_IOStream to save the image data to.
/// @param closeio true to close/free the SDL_IOStream before returning, false
///                to leave it open.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_SavePNG_IO(SDL_Surface *surface, SDL_IOStream *dst, bool closeio);
/// ```
pub extern "C" fn img_SavePNG_IO(
  surface : SDL_Surface,
  dst : SDL_IOStream,
  closeio : Bool,
) -> Bool = "IMG_SavePNG_IO"

///|
/// Save an SDL_Surface into a JPEG image file.
///
/// If the file already exists, it will be overwritten.
///
/// @param surface the SDL surface to save.
/// @param file path on the filesystem to write new file to.
/// @param quality [0; 33] is Lowest quality, [34; 66] is Middle quality, [67;
///                100] is Highest quality.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_SaveJPG(SDL_Surface *surface, const char *file, int quality);
/// ```
#owned(file)
extern "C" fn __img_SaveJPG(
  surface : SDL_Surface,
  file : Bytes,
  quality : Int,
) -> Bool = "IMG_SaveJPG"

///|
pub fn img_SaveJPG(surface : SDL_Surface, file : String, quality : Int) -> Bool {
  __img_SaveJPG(surface, string_to_cbytes(file), quality)
}

///|
/// Save an SDL_Surface into JPEG image data, via an SDL_IOStream.
///
/// @param surface the SDL surface to save.
/// @param dst the SDL_IOStream to save the image data to.
/// @param closeio true to close/free the SDL_IOStream before returning, false
///                to leave it open.
/// @param quality [0; 33] is Lowest quality, [34; 66] is Middle quality, [67;
///                100] is Highest quality.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL IMG_SaveJPG_IO(SDL_Surface *surface, SDL_IOStream *dst, bool closeio, int quality);
/// ```
pub extern "C" fn img_SaveJPG_IO(
  surface : SDL_Surface,
  dst : SDL_IOStream,
  closeio : Bool,
  quality : Int,
) -> Bool = "IMG_SaveJPG_IO"

///| Animation support functions

///|
/// Load an animation from a file.
///
/// When done with the returned animation, the app should dispose of it with a
/// call to IMG_FreeAnimation().
///
/// @param file path on the filesystem containing an animated image.
/// @return a new IMG_Animation, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC IMG_Animation * SDLCALL IMG_LoadAnimation(const char *file);
/// ```
#owned(file)
extern "C" fn __img_LoadAnimation(file : Bytes) -> IMG_Animation = "IMG_LoadAnimation"

///|
pub fn img_LoadAnimation(file : String) -> IMG_Animation {
  __img_LoadAnimation(string_to_cbytes(file))
}

///|
/// Load an animation from an SDL_IOStream.
///
/// @param src an SDL_IOStream that data will be read from.
/// @param closeio true to close/free the SDL_IOStream before returning, false
///                to leave it open.
/// @return a new IMG_Animation, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC IMG_Animation * SDLCALL IMG_LoadAnimation_IO(SDL_IOStream *src, bool closeio);
/// ```
pub extern "C" fn img_LoadAnimation_IO(
  src : SDL_IOStream,
  closeio : Bool,
) -> IMG_Animation = "IMG_LoadAnimation_IO"

///|
/// Load an animation from an SDL datasource
///
/// @param src an SDL_IOStream that data will be read from.
/// @param closeio true to close/free the SDL_IOStream before returning, false
///                to leave it open.
/// @param type a filename extension that represent this data ("GIF", etc).
/// @return a new IMG_Animation, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC IMG_Animation * SDLCALL IMG_LoadAnimationTyped_IO(SDL_IOStream *src, bool closeio, const char *type);
/// ```
#owned(type_)
extern "C" fn __img_LoadAnimationTyped_IO(
  src : SDL_IOStream,
  closeio : Bool,
  type_ : Bytes,
) -> IMG_Animation = "IMG_LoadAnimationTyped_IO"

///|
pub fn img_LoadAnimationTyped_IO(
  src : SDL_IOStream,
  closeio : Bool,
  type_ : String,
) -> IMG_Animation {
  __img_LoadAnimationTyped_IO(src, closeio, string_to_cbytes(type_))
}

///|
/// Dispose of an IMG_Animation and free its resources.
///
/// The provided `anim` pointer is not valid once this call returns.
///
/// @param anim IMG_Animation to dispose of.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC void SDLCALL IMG_FreeAnimation(IMG_Animation *anim);
/// ```
pub extern "C" fn img_FreeAnimation(anim : IMG_Animation) -> Unit = "IMG_FreeAnimation"

///|
/// Load a GIF animation directly.
///
/// @param src an SDL_IOStream that data will be read from.
/// @return a new IMG_Animation, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC IMG_Animation * SDLCALL IMG_LoadGIFAnimation_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadGIFAnimation_IO(src : SDL_IOStream) -> IMG_Animation = "IMG_LoadGIFAnimation_IO"

///|
/// Load a WEBP animation directly.
///
/// @param src an SDL_IOStream that data will be read from.
/// @return a new IMG_Animation, or NULL on error.
///
/// @since This function is available since SDL_image 3.0.0.
///
/// ```c
/// extern SDL_DECLSPEC IMG_Animation * SDLCALL IMG_LoadWEBPAnimation_IO(SDL_IOStream *src);
/// ```
pub extern "C" fn img_LoadWEBPAnimation_IO(src : SDL_IOStream) -> IMG_Animation = "IMG_LoadWEBPAnimation_IO"
