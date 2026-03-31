/// Simple DirectMedia Layer
/// Copyright (C) 2001-2025 Sam Lantinga <slouken@libsdl.org>
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

/// # CategorySDLTTF
/// 
/// Header file for SDL_ttf library
/// 
/// This library is a wrapper around the excellent FreeType 2.0 library,
/// available at: https://www.freetype.org/

///|
/// Printable format: "%d.%d.%d", MAJOR, MINOR, MICRO
pub const SDL_TTF_MAJOR_VERSION : Int = 3

///|
pub const SDL_TTF_MINOR_VERSION : Int = 2

///|
pub const SDL_TTF_MICRO_VERSION : Int = 2

///|
#external
pub type TTF_Font

///|
/// Font style flags for TTF_Font
/// 
/// These are the flags which can be used to set the style of a font in
/// SDL_ttf. A combination of these flags can be used with functions that set
/// or query font style, such as TTF_SetFontStyle or TTF_GetFontStyle.
/// 
/// @since This datatype is available since SDL_ttf 3.0.0.
/// 
/// @see TTF_SetFontStyle
/// @see TTF_GetFontStyle
/// 
/// ```c
/// typedef Uint32 TTF_FontStyleFlags;
/// ```
pub type TTF_FontStyleFlags = UInt

///|
/// No special style
pub const TTF_STYLE_NORMAL : UInt = 0x00

///|
/// Bold style
pub const TTF_STYLE_BOLD : UInt = 0x01

///|
/// Italic style  
pub const TTF_STYLE_ITALIC : UInt = 0x02

///|
/// Underlined text
pub const TTF_STYLE_UNDERLINE : UInt = 0x04

///|
/// Strikethrough text
pub const TTF_STYLE_STRIKETHROUGH : UInt = 0x08

///|
/// Hinting flags for TTF (TrueType Fonts)
/// 
/// This enum specifies the level of hinting to be applied to the font
/// rendering. The hinting level determines how much the font's outlines are
/// adjusted for better alignment on the pixel grid.
/// 
/// @since This enum is available since SDL_ttf 3.0.0.
/// 
/// @see TTF_SetFontHinting
/// @see TTF_GetFontHinting
/// 
/// ```c
/// typedef enum TTF_HintingFlags
/// {
///     TTF_HINTING_INVALID = -1,
///     TTF_HINTING_NORMAL,         /**< Normal hinting applies standard grid-fitting. */
///     TTF_HINTING_LIGHT,          /**< Light hinting applies subtle adjustments to improve rendering. */
///     TTF_HINTING_MONO,           /**< Monochrome hinting adjusts the font for better rendering at lower resolutions. */
///     TTF_HINTING_NONE,           /**< No hinting, the font is rendered without any grid-fitting. */
///     TTF_HINTING_LIGHT_SUBPIXEL  /**< Light hinting with subpixel rendering for more precise font edges. */
/// } TTF_HintingFlags;
/// ```
pub(all) enum TTF_HintingFlags {
  /// Normal hinting applies standard grid-fitting.
  /// Light hinting applies subtle adjustments to improve rendering.
  /// Monochrome hinting adjusts the font for better rendering at lower resolutions.
  /// No hinting, the font is rendered without any grid-fitting.
  /// Light hinting with subpixel rendering for more precise font edges.
  TTF_HINTING_NORMAL
  TTF_HINTING_LIGHT
  TTF_HINTING_MONO
  TTF_HINTING_NONE
  TTF_HINTING_LIGHT_SUBPIXEL
  TTF_HINTING_INVALID = 0xffff_ffff
}

///|
/// The horizontal alignment used when rendering wrapped text.
/// 
/// @since This enum is available since SDL_ttf 3.0.0.
/// 
/// ```c
/// typedef enum TTF_HorizontalAlignment
/// {
///     TTF_HORIZONTAL_ALIGN_INVALID = -1,
///     TTF_HORIZONTAL_ALIGN_LEFT,
///     TTF_HORIZONTAL_ALIGN_CENTER,
///     TTF_HORIZONTAL_ALIGN_RIGHT
/// } TTF_HorizontalAlignment;
/// ```
pub(all) enum TTF_HorizontalAlignment {
  TTF_HORIZONTAL_ALIGN_LEFT
  TTF_HORIZONTAL_ALIGN_CENTER
  TTF_HORIZONTAL_ALIGN_RIGHT
  TTF_HORIZONTAL_ALIGN_INVALID = 0xffff_ffff
}

///|
/// Direction flags
/// 
/// The values here are chosen to match
/// [hb_direction_t](https://harfbuzz.github.io/harfbuzz-hb-common.html#hb-direction-t).
/// 
/// @since This enum is available since SDL_ttf 3.0.0.
/// 
/// @see TTF_SetFontDirection
/// 
/// ```c
/// typedef enum TTF_Direction
/// {
///   TTF_DIRECTION_INVALID = 0,
///   TTF_DIRECTION_LTR = 4,        /**< Left to Right */
///   TTF_DIRECTION_RTL,            /**< Right to Left */
///   TTF_DIRECTION_TTB,            /**< Top to Bottom */
///   TTF_DIRECTION_BTT             /**< Bottom to Top */
/// } TTF_Direction;
/// ```
pub(all) enum TTF_Direction {
  TTF_DIRECTION_INVALID = 0
  /// Left to Right
  /// Right to Left
  /// Top to Bottom
  /// Bottom to Top
  TTF_DIRECTION_LTR = 4
  TTF_DIRECTION_RTL
  TTF_DIRECTION_TTB
  TTF_DIRECTION_BTT
}

///|
/// The type of data in a glyph image
/// 
/// @since This enum is available since SDL_ttf 3.0.0.
/// 
/// ```c
/// typedef enum TTF_ImageType
/// {
///     TTF_IMAGE_INVALID,
///     TTF_IMAGE_ALPHA,    /**< The color channels are white */
///     TTF_IMAGE_COLOR,    /**< The color channels have image data */
///     TTF_IMAGE_SDF,      /**< The alpha channel has signed distance field information */
/// } TTF_ImageType;
/// ```
pub(all) enum TTF_ImageType {
  TTF_IMAGE_INVALID
  /// The color channels are white
  /// The color channels have image data
  /// The alpha channel has signed distance field information
  TTF_IMAGE_ALPHA
  TTF_IMAGE_COLOR
  TTF_IMAGE_SDF
}

// Font weight constants

///|
/// Thin (100) named font weight value
pub const TTF_FONT_WEIGHT_THIN : Int = 100

///|
/// ExtraLight (200) named font weight value
pub const TTF_FONT_WEIGHT_EXTRA_LIGHT : Int = 200

///|
/// Light (300) named font weight value
pub const TTF_FONT_WEIGHT_LIGHT : Int = 300

///|
/// Normal (400) named font weight value
pub const TTF_FONT_WEIGHT_NORMAL : Int = 400

///|
/// Medium (500) named font weight value
pub const TTF_FONT_WEIGHT_MEDIUM : Int = 500

///|
/// SemiBold (600) named font weight value
pub const TTF_FONT_WEIGHT_SEMI_BOLD : Int = 600

///|
/// Bold (700) named font weight value
pub const TTF_FONT_WEIGHT_BOLD : Int = 700

///|
/// ExtraBold (800) named font weight value
pub const TTF_FONT_WEIGHT_EXTRA_BOLD : Int = 800

///|
/// Black (900) named font weight value
pub const TTF_FONT_WEIGHT_BLACK : Int = 900

///|
/// ExtraBlack (950) named font weight value
pub const TTF_FONT_WEIGHT_EXTRA_BLACK : Int = 950

// Property name constants

///|
pub const TTF_PROP_FONT_CREATE_FILENAME_STRING : String = "SDL_ttf.font.create.filename"

///|
pub const TTF_PROP_FONT_CREATE_IOSTREAM_POINTER : String = "SDL_ttf.font.create.iostream"

///|
pub const TTF_PROP_FONT_CREATE_IOSTREAM_OFFSET_NUMBER : String = "SDL_ttf.font.create.iostream.offset"

///|
pub const TTF_PROP_FONT_CREATE_IOSTREAM_AUTOCLOSE_BOOLEAN : String = "SDL_ttf.font.create.iostream.autoclose"

///|
pub const TTF_PROP_FONT_CREATE_SIZE_FLOAT : String = "SDL_ttf.font.create.size"

///|
pub const TTF_PROP_FONT_CREATE_FACE_NUMBER : String = "SDL_ttf.font.create.face"

///|
pub const TTF_PROP_FONT_CREATE_HORIZONTAL_DPI_NUMBER : String = "SDL_ttf.font.create.hdpi"

///|
pub const TTF_PROP_FONT_CREATE_VERTICAL_DPI_NUMBER : String = "SDL_ttf.font.create.vdpi"

///|
pub const TTF_PROP_FONT_CREATE_EXISTING_FONT : String = "SDL_ttf.font.create.existing_font"

// Public API functions

///|
/// This function gets the version of the dynamically linked SDL_ttf library.
/// 
/// @return SDL_ttf version.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// ```c
/// extern SDL_DECLSPEC int SDLCALL TTF_Version(void);
/// ```
pub fn ttf_Version() -> Int {
  __ttf_Version()
}

///|
extern "C" fn __ttf_Version() -> Int = "TTF_Version"

///|
/// Query the version of the FreeType library in use.
/// 
/// TTF_Init() should be called before calling this function.
/// 
/// @return tuple of (major, minor, patch) version numbers.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// @see TTF_Init
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL TTF_GetFreeTypeVersion(int *major, int *minor, int *patch);
/// ```
pub fn ttf_GetFreeTypeVersion() -> (Int, Int, Int) {
  let major = FixedArray::make(1, 0)
  let minor = FixedArray::make(1, 0)
  let patch = FixedArray::make(1, 0)
  __ttf_GetFreeTypeVersion(major, minor, patch)
  (major[0], minor[0], patch[0])
}

///|
#owned(major, minor, patch)
extern "C" fn __ttf_GetFreeTypeVersion(
  major : FixedArray[Int],
  minor : FixedArray[Int],
  patch : FixedArray[Int],
) = "TTF_GetFreeTypeVersion"

///|
/// Query the version of the HarfBuzz library in use.
/// 
/// If HarfBuzz is not available, the version reported is 0.0.0.
/// 
/// @return tuple of (major, minor, patch) version numbers.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL TTF_GetHarfBuzzVersion(int *major, int *minor, int *patch);
/// ```
pub fn ttf_GetHarfBuzzVersion() -> (Int, Int, Int) {
  let major = FixedArray::make(1, 0)
  let minor = FixedArray::make(1, 0)
  let patch = FixedArray::make(1, 0)
  __ttf_GetHarfBuzzVersion(major, minor, patch)
  (major[0], minor[0], patch[0])
}

///|
#owned(major, minor, patch)
extern "C" fn __ttf_GetHarfBuzzVersion(
  major : FixedArray[Int],
  minor : FixedArray[Int],
  patch : FixedArray[Int],
) = "TTF_GetHarfBuzzVersion"

///|
/// Initialize SDL_ttf.
/// 
/// You must successfully call this function before it is safe to call any
/// other function in this library.
/// 
/// It is safe to call this more than once, and each successful TTF_Init() call
/// should be paired with a matching TTF_Quit() call.
/// 
/// @return true on success or false on failure; call SDL_GetError() for more
///         information.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// @see TTF_Quit
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL TTF_Init(void);
/// ```
pub fn ttf_Init() -> Bool {
  __ttf_Init()
}

///|
extern "C" fn __ttf_Init() -> Bool = "TTF_Init"

///|
/// Deinitialize SDL_ttf.
/// 
/// You should call this function when done with the library. Every TTF_Init() call
/// should be paired with a matching TTF_Quit() call.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// @see TTF_Init
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL TTF_Quit(void);
/// ```
pub fn ttf_Quit() -> Unit {
  __ttf_Quit()
}

///|
extern "C" fn __ttf_Quit() = "TTF_Quit"

///|
/// Create a font from a file, using a specified point size.
/// 
/// Some .fon fonts will have several sizes embedded in the file, so the point
/// size becomes the index of choosing which size. If the value is too high,
/// the last indexed size will be the default.
/// 
/// When done with the returned TTF_Font, use TTF_CloseFont() to dispose of it.
/// 
/// @param file path to font file.
/// @param ptsize point size to use for the newly-opened font.
/// @return a valid TTF_Font, or NULL on failure; call SDL_GetError() for more
///         information.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// @see TTF_CloseFont
/// 
/// ```c
/// extern SDL_DECLSPEC TTF_Font * SDLCALL TTF_OpenFont(const char *file, float ptsize);
/// ```
pub fn ttf_OpenFont(file : String, ptsize : Float) -> TTF_Font {
  let file_bytes = string_to_cbytes(file)
  __ttf_OpenFont(file_bytes, ptsize)
}

///|
#owned(file)
extern "C" fn __ttf_OpenFont(file : Bytes, ptsize : Float) -> TTF_Font = "TTF_OpenFont"

///|
/// Create a font from an SDL_IOStream, using a specified point size.
/// 
/// Some .fon fonts will have several sizes embedded in the file, so the point
/// size becomes the index of choosing which size. If the value is too high,
/// the last indexed size will be the default.
/// 
/// If `closeio` is true, `src` will be automatically closed once the font is
/// closed. Otherwise you should close `src` yourself after closing the font.
/// 
/// When done with the returned TTF_Font, use TTF_CloseFont() to dispose of it.
/// 
/// @param src an SDL_IOStream to provide a font file's data.
/// @param closeio true to close `src` when the font is closed, false to leave
///                it open.
/// @param ptsize point size to use for the newly-opened font.
/// @return a valid TTF_Font, or NULL on failure; call SDL_GetError() for more
///         information.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// @see TTF_CloseFont
/// 
/// ```c
/// extern SDL_DECLSPEC TTF_Font * SDLCALL TTF_OpenFontIO(SDL_IOStream *src, bool closeio, float ptsize);
/// ```
pub fn ttf_OpenFontIO(
  src : SDL_IOStream,
  closeio : Bool,
  ptsize : Float,
) -> TTF_Font {
  __ttf_OpenFontIO(src, closeio, ptsize)
}

///|
extern "C" fn __ttf_OpenFontIO(
  src : SDL_IOStream,
  closeio : Bool,
  ptsize : Float,
) -> TTF_Font = "TTF_OpenFontIO"

///|
/// Dispose of a previously-created font.
/// 
/// Call this when done with a font. This function will free any resources
/// associated with it. It is safe to call this function with a NULL pointer,
/// and it is safe to call this function multiple times with the same font.
/// This function should not be called on a font that is still referenced by
/// a text object.
/// 
/// @param font the font to dispose of.
/// 
/// @threadsafety This function should be called on the thread that created the
///               font.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// @see TTF_OpenFont
/// @see TTF_OpenFontIO
/// @see TTF_OpenFontWithProperties
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL TTF_CloseFont(TTF_Font *font);
/// ```
pub fn ttf_CloseFont(font : TTF_Font) -> Unit {
  __ttf_CloseFont(font)
}

///|
extern "C" fn __ttf_CloseFont(font : TTF_Font) = "TTF_CloseFont"

///|
/// Get the size of a font.
/// 
/// @param font the font to query.
/// @return the size of the font, or 0.0f on failure; call SDL_GetError() for
///         more information.
/// 
/// @threadsafety This function should be called on the thread that created the
///               font.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// @see TTF_SetFontSize
/// @see TTF_SetFontSizeDPI
/// 
/// ```c
/// extern SDL_DECLSPEC float SDLCALL TTF_GetFontSize(TTF_Font *font);
/// ```
pub fn ttf_GetFontSize(font : TTF_Font) -> Float {
  __ttf_GetFontSize(font)
}

///|
extern "C" fn __ttf_GetFontSize(font : TTF_Font) -> Float = "TTF_GetFontSize"

///|
/// Set a font's size dynamically.
/// 
/// This updates any TTF_Text objects using this font, and clears
/// already-generated glyphs, if any, from the cache.
/// 
/// @param font the font to resize.
/// @param ptsize the new point size.
/// @return true on success or false on failure; call SDL_GetError() for more
///         information.
/// 
/// @threadsafety This function should be called on the thread that created the
///               font.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// @see TTF_GetFontSize
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL TTF_SetFontSize(TTF_Font *font, float ptsize);
/// ```
pub fn ttf_SetFontSize(font : TTF_Font, ptsize : Float) -> Bool {
  __ttf_SetFontSize(font, ptsize)
}

///|
extern "C" fn __ttf_SetFontSize(font : TTF_Font, ptsize : Float) -> Bool = "TTF_SetFontSize"

///|
/// Set a font's current style.
/// 
/// This updates any TTF_Text objects using this font, and clears
/// already-generated glyphs, if any, from the cache.
/// 
/// The font styles are a set of bit flags, OR'd together:
/// 
/// - `TTF_STYLE_NORMAL` (is zero)
/// - `TTF_STYLE_BOLD`
/// - `TTF_STYLE_ITALIC`
/// - `TTF_STYLE_UNDERLINE`
/// - `TTF_STYLE_STRIKETHROUGH`
/// 
/// @param font the font to set a new style on.
/// @param style the new style values to set, OR'd together.
/// 
/// @threadsafety This function should be called on the thread that created the
///               font.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// @see TTF_GetFontStyle
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL TTF_SetFontStyle(TTF_Font *font, TTF_FontStyleFlags style);
/// ```
pub fn ttf_SetFontStyle(font : TTF_Font, style : TTF_FontStyleFlags) -> Unit {
  __ttf_SetFontStyle(font, style)
}

///|
extern "C" fn __ttf_SetFontStyle(font : TTF_Font, style : TTF_FontStyleFlags) = "TTF_SetFontStyle"

///|
/// Query a font's current style.
/// 
/// The font styles are a set of bit flags, OR'd together:
/// 
/// - `TTF_STYLE_NORMAL` (is zero)
/// - `TTF_STYLE_BOLD`
/// - `TTF_STYLE_ITALIC`
/// - `TTF_STYLE_UNDERLINE`
/// - `TTF_STYLE_STRIKETHROUGH`
/// 
/// @param font the font to query.
/// @return the current font style, as a set of bit flags.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// @see TTF_SetFontStyle
/// 
/// ```c
/// extern SDL_DECLSPEC TTF_FontStyleFlags SDLCALL TTF_GetFontStyle(const TTF_Font *font);
/// ```
pub fn ttf_GetFontStyle(font : TTF_Font) -> TTF_FontStyleFlags {
  __ttf_GetFontStyle(font)
}

///|
extern "C" fn __ttf_GetFontStyle(font : TTF_Font) -> TTF_FontStyleFlags = "TTF_GetFontStyle"

///|
/// Query the total height of a font.
/// 
/// This is usually equal to point size.
/// 
/// @param font the font to query.
/// @return the font's height.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// ```c
/// extern SDL_DECLSPEC int SDLCALL TTF_GetFontHeight(const TTF_Font *font);
/// ```
pub fn ttf_GetFontHeight(font : TTF_Font) -> Int {
  __ttf_GetFontHeight(font)
}

///|
extern "C" fn __ttf_GetFontHeight(font : TTF_Font) -> Int = "TTF_GetFontHeight"

///|
/// Query the offset from the baseline to the top of a font.
/// 
/// This is a positive value, relative to the baseline.
/// 
/// @param font the font to query.
/// @return the font's ascent.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// ```c
/// extern SDL_DECLSPEC int SDLCALL TTF_GetFontAscent(const TTF_Font *font);
/// ```
pub fn ttf_GetFontAscent(font : TTF_Font) -> Int {
  __ttf_GetFontAscent(font)
}

///|
extern "C" fn __ttf_GetFontAscent(font : TTF_Font) -> Int = "TTF_GetFontAscent"

///|
/// Query the offset from the baseline to the bottom of a font.
/// 
/// This is a negative value, relative to the baseline.
/// 
/// @param font the font to query.
/// @return the font's descent.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// ```c
/// extern SDL_DECLSPEC int SDLCALL TTF_GetFontDescent(const TTF_Font *font);
/// ```
pub fn ttf_GetFontDescent(font : TTF_Font) -> Int {
  __ttf_GetFontDescent(font)
}

///|
extern "C" fn __ttf_GetFontDescent(font : TTF_Font) -> Int = "TTF_GetFontDescent"

///|
/// Query whether or not kerning is enabled for a font.
/// 
/// @param font the font to query.
/// @return true if kerning is enabled, false otherwise.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// @see TTF_SetFontKerning
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL TTF_GetFontKerning(const TTF_Font *font);
/// ```
pub fn ttf_GetFontKerning(font : TTF_Font) -> Bool {
  __ttf_GetFontKerning(font)
}

///|
extern "C" fn __ttf_GetFontKerning(font : TTF_Font) -> Bool = "TTF_GetFontKerning"

///|
/// Query whether a font is fixed-width.
/// 
/// A "fixed-width" font means all glyphs are the same width across; a
/// lowercase 'i' will be the same size across as a capital 'W', for example.
/// This is common for terminals and text editors, and other apps that treat
/// text as a grid. Most other things (WYSIWYG word processors, web pages, etc)
/// are more likely to not be fixed-width in most cases.
/// 
/// @param font the font to query.
/// @return true if the font is fixed-width, false otherwise.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL TTF_FontIsFixedWidth(const TTF_Font *font);
/// ```
pub fn ttf_FontIsFixedWidth(font : TTF_Font) -> Bool {
  __ttf_FontIsFixedWidth(font)
}

///|
extern "C" fn __ttf_FontIsFixedWidth(font : TTF_Font) -> Bool = "TTF_FontIsFixedWidth"

///|
/// Query a font's family name.
/// 
/// This string is dictated by the contents of the font file.
/// 
/// Note that the returned string is to internal storage, and should not be
/// modified or free'd by the caller. The string becomes invalid, with the rest
/// of the font, when `font` is handed to TTF_CloseFont().
/// 
/// @param font the font to query.
/// @return the font's family name.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL TTF_GetFontFamilyName(const TTF_Font *font);
/// ```
pub fn ttf_GetFontFamilyName(font : TTF_Font) -> String {
  let cstr = __ttf_GetFontFamilyName(font)
  let res = cstr.to_string()
  // Note: Do not free this string as it's managed by SDL_ttf
  res
}

///|
extern "C" fn __ttf_GetFontFamilyName(font : TTF_Font) -> CStr = "TTF_GetFontFamilyName"

///|
/// Query a font's style name.
/// 
/// This string is dictated by the contents of the font file.
/// 
/// Note that the returned string is to internal storage, and should not be
/// modified or free'd by the caller. The string becomes invalid, with the rest
/// of the font, when `font` is handed to TTF_CloseFont().
/// 
/// @param font the font to query.
/// @return the font's style name.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL TTF_GetFontStyleName(const TTF_Font *font);
/// ```
pub fn ttf_GetFontStyleName(font : TTF_Font) -> String {
  let cstr = __ttf_GetFontStyleName(font)
  let res = cstr.to_string()
  // Note: Do not free this string as it's managed by SDL_ttf  
  res
}

///|
extern "C" fn __ttf_GetFontStyleName(font : TTF_Font) -> CStr = "TTF_GetFontStyleName"

///|
/// Check whether a glyph is provided by the font for a UNICODE codepoint.
/// 
/// @param font the font to query.
/// @param ch the codepoint to check.
/// @return true if font provides a glyph for this character, false if not.
/// 
/// @threadsafety This function should be called on the thread that created the
///               font.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL TTF_FontHasGlyph(TTF_Font *font, Uint32 ch);
/// ```
pub fn ttf_FontHasGlyph(font : TTF_Font, ch : UInt) -> Bool {
  __ttf_FontHasGlyph(font, ch)
}

///|
extern "C" fn __ttf_FontHasGlyph(font : TTF_Font, ch : UInt) -> Bool = "TTF_FontHasGlyph"

///|
/// Calculate the dimensions of a rendered string of UTF-8 text.
/// 
/// This will report the width and height, in pixels, of the space that the
/// specified string will take to fully render.
/// 
/// @param font the font to query.
/// @param text text to calculate, in UTF-8 encoding.
/// @return tuple of (success, width, height) where success indicates if the call was 
///         successful and width/height are the dimensions in pixels.
/// 
/// @threadsafety This function should be called on the thread that created the
///               font.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL TTF_GetStringSize(TTF_Font *font, const char *text, size_t length, int *w, int *h);
/// ```
pub fn ttf_GetStringSize(font : TTF_Font, text : String) -> (Bool, Int, Int) {
  let text_bytes = string_to_cbytes(text)
  let w = FixedArray::make(1, 0)
  let h = FixedArray::make(1, 0)
  let success = __ttf_GetStringSize(font, text_bytes, 0, w, h)
  (success, w[0], h[0])
}

///|
#owned(text, w, h)
extern "C" fn __ttf_GetStringSize(
  font : TTF_Font,
  text : Bytes,
  length : UInt64,
  w : FixedArray[Int],
  h : FixedArray[Int],
) -> Bool = "TTF_GetStringSize"

///|
/// Render UTF-8 text at fast quality to a new 8-bit surface.
/// 
/// This function will allocate a new 8-bit, palettized surface. The surface's
/// 0 pixel will be the colorkey, giving a transparent background. The 1 pixel
/// will be set to the text color.
/// 
/// This will not word-wrap the string; you'll get a surface with a single line
/// of text, as long as the string requires. You can use
/// TTF_RenderText_Solid_Wrapped() instead if you need to wrap the output to
/// multiple lines.
/// 
/// This will not wrap on newline characters.
/// 
/// You can render at other quality levels with TTF_RenderText_Shaded,
/// TTF_RenderText_Blended, and TTF_RenderText_LCD.
/// 
/// @param font the font to render with.
/// @param text text to render, in UTF-8 encoding.
/// @param fg the foreground color for the text.
/// @return a new 8-bit, palettized surface, or NULL if there was an error.
/// 
/// @threadsafety This function should be called on the thread that created the
///               font.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// @see TTF_RenderText_Blended
/// @see TTF_RenderText_LCD
/// @see TTF_RenderText_Shaded
/// @see TTF_RenderText_Solid_Wrapped
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL TTF_RenderText_Solid(TTF_Font *font, const char *text, size_t length, SDL_Color fg);
/// ```
pub fn ttf_RenderText_Solid(
  font : TTF_Font,
  text : String,
  fg : SDL_Color,
) -> SDL_Surface {
  let text_bytes = string_to_cbytes(text)
  __ttf_RenderText_Solid(font, text_bytes, 0, fg)
}

///|
#owned(text, fg)
extern "C" fn __ttf_RenderText_Solid(
  font : TTF_Font,
  text : Bytes,
  length : UInt64,
  fg : SDL_Color,
) -> SDL_Surface = "TTF_RenderText_Solid"

///|
/// Render UTF-8 text at high quality to a new ARGB surface.
/// 
/// This function will allocate a new 32-bit, ARGB surface, using alpha
/// blending to dither the font with the given color. This function returns the
/// new surface, or NULL if there was an error.
/// 
/// This will not word-wrap the string; you'll get a surface with a single line
/// of text, as long as the string requires. You can use
/// TTF_RenderText_Blended_Wrapped() instead if you need to wrap the output to
/// multiple lines.
/// 
/// This will not wrap on newline characters.
/// 
/// You can render at other quality levels with TTF_RenderText_Solid,
/// TTF_RenderText_Shaded, and TTF_RenderText_LCD.
/// 
/// @param font the font to render with.
/// @param text text to render, in UTF-8 encoding.
/// @param fg the foreground color for the text.
/// @return a new 32-bit, ARGB surface, or NULL if there was an error.
/// 
/// @threadsafety This function should be called on the thread that created the
///               font.
/// 
/// @since This function is available since SDL_ttf 3.0.0.
/// 
/// @see TTF_RenderText_Blended_Wrapped
/// @see TTF_RenderText_LCD
/// @see TTF_RenderText_Shaded
/// @see TTF_RenderText_Solid
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_Surface * SDLCALL TTF_RenderText_Blended(TTF_Font *font, const char *text, size_t length, SDL_Color fg);
/// ```
pub fn ttf_RenderText_Blended(
  font : TTF_Font,
  text : String,
  fg : SDL_Color,
) -> SDL_Surface {
  let text_bytes = string_to_cbytes(text)
  __ttf_RenderText_Blended(font, text_bytes, 0, fg)
}

///|
#owned(text, fg)
extern "C" fn __ttf_RenderText_Blended(
  font : TTF_Font,
  text : Bytes,
  length : UInt64,
  fg : SDL_Color,
) -> SDL_Surface = "TTF_RenderText_Blended"
