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

/// # CategoryPixels
/// 
/// SDL offers facilities for pixel management.
/// 
/// Largely these facilities deal with pixel _format_: what does this set of
/// bits represent?
/// 
/// If you mostly want to think of a pixel as some combination of red, green,
/// blue, and maybe alpha intensities, this is all pretty straightforward, and
/// in many cases, is enough information to build a perfectly fine game.
/// 
/// However, the actual definition of a pixel is more complex than that:
/// 
/// Pixels are a representation of a color in a particular color space.
/// 
/// The first characteristic of a color space is the color type. SDL
/// understands two different color types, RGB and YCbCr, or in SDL also
/// referred to as YUV.
/// 
/// RGB colors consist of red, green, and blue channels of color that are added
/// together to represent the colors we see on the screen.
/// 
/// https://en.wikipedia.org/wiki/RGB_color_model
/// 
/// YCbCr colors represent colors as a Y luma brightness component and red and
/// blue chroma color offsets. This color representation takes advantage of the
/// fact that the human eye is more sensitive to brightness than the color in
/// an image. The Cb and Cr components are often compressed and have lower
/// resolution than the luma component.
/// 
/// https://en.wikipedia.org/wiki/YCbCr
/// 
/// When the color information in YCbCr is compressed, the Y pixels are left at
/// full resolution and each Cr and Cb pixel represents an average of the color
/// information in a block of Y pixels. The chroma location determines where in
/// that block of pixels the color information is coming from.
/// 
/// The color range defines how much of the pixel to use when converting a
/// pixel into a color on the display. When the full color range is used, the
/// entire numeric range of the pixel bits is significant. When narrow color
/// range is used, for historical reasons, the pixel uses only a portion of the
/// numeric range to represent colors.
/// 
/// The color primaries and white point are a definition of the colors in the
/// color space relative to the standard XYZ color space.
/// 
/// https://en.wikipedia.org/wiki/CIE_1931_color_space
/// 
/// The transfer characteristic, or opto-electrical transfer function (OETF),
/// is the way a color is converted from mathematically linear space into a
/// non-linear output signals.
/// 
/// https://en.wikipedia.org/wiki/Rec._709#Transfer_characteristics
/// 
/// The matrix coefficients are used to convert between YCbCr and RGB colors.

// Alpha constants

///|
/// A fully opaque 8-bit alpha value.
pub const SDL_ALPHA_OPAQUE : UInt = 255U

///|
/// A fully opaque floating point alpha value.
pub const SDL_ALPHA_OPAQUE_FLOAT : Float = 1.0

///|
/// A fully transparent 8-bit alpha value.
pub const SDL_ALPHA_TRANSPARENT : UInt = 0U

///|
/// A fully transparent floating point alpha value.
pub const SDL_ALPHA_TRANSPARENT_FLOAT : Float = 0.0

///|
/// Pixel type.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_PixelType
/// {
///     SDL_PIXELTYPE_UNKNOWN,
///     SDL_PIXELTYPE_INDEX1,
///     SDL_PIXELTYPE_INDEX4,
///     SDL_PIXELTYPE_INDEX8,
///     SDL_PIXELTYPE_PACKED8,
///     SDL_PIXELTYPE_PACKED16,
///     SDL_PIXELTYPE_PACKED32,
///     SDL_PIXELTYPE_ARRAYU8,
///     SDL_PIXELTYPE_ARRAYU16,
///     SDL_PIXELTYPE_ARRAYU32,
///     SDL_PIXELTYPE_ARRAYF16,
///     SDL_PIXELTYPE_ARRAYF32,
///     /* appended at the end for compatibility with sdl2-compat:  */
///     SDL_PIXELTYPE_INDEX2
/// } SDL_PixelType;
/// ```
pub(all) enum SDL_PixelType {
  SDL_PIXELTYPE_UNKNOWN
  SDL_PIXELTYPE_INDEX1
  SDL_PIXELTYPE_INDEX4
  SDL_PIXELTYPE_INDEX8
  SDL_PIXELTYPE_PACKED8
  SDL_PIXELTYPE_PACKED16
  SDL_PIXELTYPE_PACKED32
  SDL_PIXELTYPE_ARRAYU8
  SDL_PIXELTYPE_ARRAYU16
  SDL_PIXELTYPE_ARRAYU32
  SDL_PIXELTYPE_ARRAYF16
  SDL_PIXELTYPE_ARRAYF32
  SDL_PIXELTYPE_INDEX2
}

///|
/// Bitmap pixel order, high bit -> low bit.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_BitmapOrder
/// {
///     SDL_BITMAPORDER_NONE,
///     SDL_BITMAPORDER_4321,
///     SDL_BITMAPORDER_1234
/// } SDL_BitmapOrder;
/// ```
pub(all) enum SDL_BitmapOrder {
  SDL_BITMAPORDER_NONE
  SDL_BITMAPORDER_4321
  SDL_BITMAPORDER_1234
}

///|
/// Packed component order, high bit -> low bit.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_PackedOrder
/// {
///     SDL_PACKEDORDER_NONE,
///     SDL_PACKEDORDER_XRGB,
///     SDL_PACKEDORDER_RGBX,
///     SDL_PACKEDORDER_ARGB,
///     SDL_PACKEDORDER_RGBA,
///     SDL_PACKEDORDER_XBGR,
///     SDL_PACKEDORDER_BGRX,
///     SDL_PACKEDORDER_ABGR,
///     SDL_PACKEDORDER_BGRA
/// } SDL_PackedOrder;
/// ```
pub(all) enum SDL_PackedOrder {
  SDL_PACKEDORDER_NONE
  SDL_PACKEDORDER_XRGB
  SDL_PACKEDORDER_RGBX
  SDL_PACKEDORDER_ARGB
  SDL_PACKEDORDER_RGBA
  SDL_PACKEDORDER_XBGR
  SDL_PACKEDORDER_BGRX
  SDL_PACKEDORDER_ABGR
  SDL_PACKEDORDER_BGRA
}

///|
/// Array component order, low byte -> high byte.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_ArrayOrder
/// {
///     SDL_ARRAYORDER_NONE,
///     SDL_ARRAYORDER_RGB,
///     SDL_ARRAYORDER_RGBA,
///     SDL_ARRAYORDER_ARGB,
///     SDL_ARRAYORDER_BGR,
///     SDL_ARRAYORDER_BGRA,
///     SDL_ARRAYORDER_ABGR
/// } SDL_ArrayOrder;
/// ```
pub(all) enum SDL_ArrayOrder {
  SDL_ARRAYORDER_NONE
  SDL_ARRAYORDER_RGB
  SDL_ARRAYORDER_RGBA
  SDL_ARRAYORDER_ARGB
  SDL_ARRAYORDER_BGR
  SDL_ARRAYORDER_BGRA
  SDL_ARRAYORDER_ABGR
}

///|
/// Packed component layout.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_PackedLayout
/// {
///     SDL_PACKEDLAYOUT_NONE,
///     SDL_PACKEDLAYOUT_332,
///     SDL_PACKEDLAYOUT_4444,
///     SDL_PACKEDLAYOUT_1555,
///     SDL_PACKEDLAYOUT_5551,
///     SDL_PACKEDLAYOUT_565,
///     SDL_PACKEDLAYOUT_8888,
///     SDL_PACKEDLAYOUT_2101010,
///     SDL_PACKEDLAYOUT_1010102
/// } SDL_PackedLayout;
/// ```
pub(all) enum SDL_PackedLayout {
  SDL_PACKEDLAYOUT_NONE
  SDL_PACKEDLAYOUT_332
  SDL_PACKEDLAYOUT_4444
  SDL_PACKEDLAYOUT_1555
  SDL_PACKEDLAYOUT_5551
  SDL_PACKEDLAYOUT_565
  SDL_PACKEDLAYOUT_8888
  SDL_PACKEDLAYOUT_2101010
  SDL_PACKEDLAYOUT_1010102
}

///|
/// Pixel format.
/// 
/// SDL's pixel formats have the following naming convention:
/// 
/// - Names with a list of components and a single bit count, such as RGB24 and
///   ABGR32, define a platform-independent encoding into bytes in the order
///   specified. For example, in RGB24 data, each pixel is encoded in 3 bytes
///   (red, green, blue) in that order, and in ABGR32 data, each pixel is
///   encoded in 4 bytes (alpha, blue, green, red) in that order. Use these
///   names if the property of a format that is important to you is the order
///   of the bytes in memory or on disk.
/// - Names with a bit count per component, such as ARGB8888 and XRGB1555, are
///   "packed" into an appropriately-sized integer in the platform's native
///   endianness. For example, ARGB8888 is a sequence of 32-bit integers; in
///   each integer, the most significant bits are alpha, and the least
///   significant bits are blue. On a little-endian CPU such as x86, the least
///   significant bits of each integer are arranged first in memory, but on a
///   big-endian CPU such as s390x, the most significant bits are arranged
///   first. Use these names if the property of a format that is important to
///   you is the meaning of each bit position within a native-endianness
///   integer.
/// - In indexed formats such as INDEX4LSB, each pixel is represented by
///   encoding an index into the palette into the indicated number of bits,
///   with multiple pixels packed into each byte if appropriate. In LSB
///   formats, the first (leftmost) pixel is stored in the least-significant
///   bits of the byte; in MSB formats, it's stored in the most-significant
///   bits. INDEX8 does not need LSB/MSB variants, because each pixel exactly
///   fills one byte.
/// 
/// The 32-bit byte-array encodings such as RGBA32 are aliases for the
/// appropriate 8888 encoding for the current platform. For example, RGBA32 is
/// an alias for ABGR8888 on little-endian CPUs like x86, or an alias for
/// RGBA8888 on big-endian CPUs.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_PixelFormat
/// {
///     SDL_PIXELFORMAT_UNKNOWN = 0,
///     SDL_PIXELFORMAT_INDEX1LSB = 0x11100100u,
///     SDL_PIXELFORMAT_INDEX1MSB = 0x11200100u,
///     SDL_PIXELFORMAT_INDEX2LSB = 0x1c100200u,
///     SDL_PIXELFORMAT_INDEX2MSB = 0x1c200200u,
///     SDL_PIXELFORMAT_INDEX4LSB = 0x12100400u,
///     SDL_PIXELFORMAT_INDEX4MSB = 0x12200400u,
///     SDL_PIXELFORMAT_INDEX8 = 0x13000801u,
///     SDL_PIXELFORMAT_RGB332 = 0x14110801u,
///     SDL_PIXELFORMAT_XRGB4444 = 0x15120c02u,
///     SDL_PIXELFORMAT_XBGR4444 = 0x15520c02u,
///     SDL_PIXELFORMAT_XRGB1555 = 0x15130f02u,
///     SDL_PIXELFORMAT_XBGR1555 = 0x15530f02u,
///     SDL_PIXELFORMAT_ARGB4444 = 0x15321002u,
///     SDL_PIXELFORMAT_RGBA4444 = 0x15421002u,
///     SDL_PIXELFORMAT_ABGR4444 = 0x15721002u,
///     SDL_PIXELFORMAT_BGRA4444 = 0x15821002u,
///     SDL_PIXELFORMAT_ARGB1555 = 0x15331002u,
///     SDL_PIXELFORMAT_RGBA5551 = 0x15441002u,
///     SDL_PIXELFORMAT_ABGR1555 = 0x15731002u,
///     SDL_PIXELFORMAT_BGRA5551 = 0x15841002u,
///     SDL_PIXELFORMAT_RGB565 = 0x15151002u,
///     SDL_PIXELFORMAT_BGR565 = 0x15551002u,
///     SDL_PIXELFORMAT_RGB24 = 0x17101803u,
///     SDL_PIXELFORMAT_BGR24 = 0x17401803u,
///     SDL_PIXELFORMAT_XRGB8888 = 0x16161804u,
///     SDL_PIXELFORMAT_RGBX8888 = 0x16261804u,
///     SDL_PIXELFORMAT_XBGR8888 = 0x16561804u,
///     SDL_PIXELFORMAT_BGRX8888 = 0x16661804u,
///     SDL_PIXELFORMAT_ARGB8888 = 0x16362004u,
///     SDL_PIXELFORMAT_RGBA8888 = 0x16462004u,
///     SDL_PIXELFORMAT_ABGR8888 = 0x16762004u,
///     SDL_PIXELFORMAT_BGRA8888 = 0x16862004u,
///     SDL_PIXELFORMAT_XRGB2101010 = 0x16172004u,
///     SDL_PIXELFORMAT_XBGR2101010 = 0x16572004u,
///     SDL_PIXELFORMAT_ARGB2101010 = 0x16372004u,
///     SDL_PIXELFORMAT_ABGR2101010 = 0x16772004u,
///     SDL_PIXELFORMAT_RGB48 = 0x18103006u,
///     SDL_PIXELFORMAT_BGR48 = 0x18403006u,
///     SDL_PIXELFORMAT_RGBA64 = 0x18204008u,
///     SDL_PIXELFORMAT_ARGB64 = 0x18304008u,
///     SDL_PIXELFORMAT_BGRA64 = 0x18504008u,
///     SDL_PIXELFORMAT_ABGR64 = 0x18604008u,
///     SDL_PIXELFORMAT_RGB48_FLOAT = 0x1a103006u,
///     SDL_PIXELFORMAT_BGR48_FLOAT = 0x1a403006u,
///     SDL_PIXELFORMAT_RGBA64_FLOAT = 0x1a204008u,
///     SDL_PIXELFORMAT_ARGB64_FLOAT = 0x1a304008u,
///     SDL_PIXELFORMAT_BGRA64_FLOAT = 0x1a504008u,
///     SDL_PIXELFORMAT_ABGR64_FLOAT = 0x1a604008u,
///     SDL_PIXELFORMAT_RGB96_FLOAT = 0x1b10600cu,
///     SDL_PIXELFORMAT_BGR96_FLOAT = 0x1b40600cu,
///     SDL_PIXELFORMAT_RGBA128_FLOAT = 0x1b208010u,
///     SDL_PIXELFORMAT_ARGB128_FLOAT = 0x1b308010u,
///     SDL_PIXELFORMAT_BGRA128_FLOAT = 0x1b508010u,
///     SDL_PIXELFORMAT_ABGR128_FLOAT = 0x1b608010u,
///     SDL_PIXELFORMAT_YV12 = 0x32315659u,
///     SDL_PIXELFORMAT_IYUV = 0x56555949u,
///     SDL_PIXELFORMAT_YUY2 = 0x32595559u,
///     SDL_PIXELFORMAT_UYVY = 0x59565955u,
///     SDL_PIXELFORMAT_YVYU = 0x55595659u,
///     SDL_PIXELFORMAT_NV12 = 0x3231564eu,
///     SDL_PIXELFORMAT_NV21 = 0x3132564eu,
///     SDL_PIXELFORMAT_P010 = 0x30313050u,
///     SDL_PIXELFORMAT_EXTERNAL_OES = 0x2053454fu,
///     SDL_PIXELFORMAT_MJPG = 0x47504a4du,
///     SDL_PIXELFORMAT_RGBA32 = SDL_PIXELFORMAT_ABGR8888,
///     SDL_PIXELFORMAT_ARGB32 = SDL_PIXELFORMAT_BGRA8888,
///     SDL_PIXELFORMAT_BGRA32 = SDL_PIXELFORMAT_ARGB8888,
///     SDL_PIXELFORMAT_ABGR32 = SDL_PIXELFORMAT_RGBA8888,
///     SDL_PIXELFORMAT_RGBX32 = SDL_PIXELFORMAT_XBGR8888,
///     SDL_PIXELFORMAT_XRGB32 = SDL_PIXELFORMAT_BGRX8888,
///     SDL_PIXELFORMAT_BGRX32 = SDL_PIXELFORMAT_XRGB8888,
///     SDL_PIXELFORMAT_XBGR32 = SDL_PIXELFORMAT_RGBX8888
/// } SDL_PixelFormat;
/// ```
pub(all) enum SDL_PixelFormat {
  SDL_PIXELFORMAT_UNKNOWN = 0
  SDL_PIXELFORMAT_INDEX1LSB = 0x11100100
  SDL_PIXELFORMAT_INDEX1MSB = 0x11200100
  SDL_PIXELFORMAT_INDEX2LSB = 0x1c100200
  SDL_PIXELFORMAT_INDEX2MSB = 0x1c200200
  SDL_PIXELFORMAT_INDEX4LSB = 0x12100400
  SDL_PIXELFORMAT_INDEX4MSB = 0x12200400
  SDL_PIXELFORMAT_INDEX8 = 0x13000801
  SDL_PIXELFORMAT_RGB332 = 0x14110801
  SDL_PIXELFORMAT_XRGB4444 = 0x15120c02
  SDL_PIXELFORMAT_XBGR4444 = 0x15520c02
  SDL_PIXELFORMAT_XRGB1555 = 0x15130f02
  SDL_PIXELFORMAT_XBGR1555 = 0x15530f02
  SDL_PIXELFORMAT_ARGB4444 = 0x15321002
  SDL_PIXELFORMAT_RGBA4444 = 0x15421002
  SDL_PIXELFORMAT_ABGR4444 = 0x15721002
  SDL_PIXELFORMAT_BGRA4444 = 0x15821002
  SDL_PIXELFORMAT_ARGB1555 = 0x15331002
  SDL_PIXELFORMAT_RGBA5551 = 0x15441002
  SDL_PIXELFORMAT_ABGR1555 = 0x15731002
  SDL_PIXELFORMAT_BGRA5551 = 0x15841002
  SDL_PIXELFORMAT_RGB565 = 0x15151002
  SDL_PIXELFORMAT_BGR565 = 0x15551002
  SDL_PIXELFORMAT_RGB24 = 0x17101803
  SDL_PIXELFORMAT_BGR24 = 0x17401803
  SDL_PIXELFORMAT_XRGB8888 = 0x16161804
  SDL_PIXELFORMAT_RGBX8888 = 0x16261804
  SDL_PIXELFORMAT_XBGR8888 = 0x16561804
  SDL_PIXELFORMAT_BGRX8888 = 0x16661804
  SDL_PIXELFORMAT_ARGB8888 = 0x16362004
  SDL_PIXELFORMAT_RGBA8888 = 0x16462004
  SDL_PIXELFORMAT_ABGR8888 = 0x16762004
  SDL_PIXELFORMAT_BGRA8888 = 0x16862004
  SDL_PIXELFORMAT_XRGB2101010 = 0x16172004
  SDL_PIXELFORMAT_XBGR2101010 = 0x16572004
  SDL_PIXELFORMAT_ARGB2101010 = 0x16372004
  SDL_PIXELFORMAT_ABGR2101010 = 0x16772004
  SDL_PIXELFORMAT_RGB48 = 0x18103006
  SDL_PIXELFORMAT_BGR48 = 0x18403006
  SDL_PIXELFORMAT_RGBA64 = 0x18204008
  SDL_PIXELFORMAT_ARGB64 = 0x18304008
  SDL_PIXELFORMAT_BGRA64 = 0x18504008
  SDL_PIXELFORMAT_ABGR64 = 0x18604008
  SDL_PIXELFORMAT_RGB48_FLOAT = 0x1a103006
  SDL_PIXELFORMAT_BGR48_FLOAT = 0x1a403006
  SDL_PIXELFORMAT_RGBA64_FLOAT = 0x1a204008
  SDL_PIXELFORMAT_ARGB64_FLOAT = 0x1a304008
  SDL_PIXELFORMAT_BGRA64_FLOAT = 0x1a504008
  SDL_PIXELFORMAT_ABGR64_FLOAT = 0x1a604008
  SDL_PIXELFORMAT_RGB96_FLOAT = 0x1b10600c
  SDL_PIXELFORMAT_BGR96_FLOAT = 0x1b40600c
  SDL_PIXELFORMAT_RGBA128_FLOAT = 0x1b208010
  SDL_PIXELFORMAT_ARGB128_FLOAT = 0x1b308010
  SDL_PIXELFORMAT_BGRA128_FLOAT = 0x1b508010
  SDL_PIXELFORMAT_ABGR128_FLOAT = 0x1b608010
  SDL_PIXELFORMAT_YV12 = 0x32315659
  SDL_PIXELFORMAT_IYUV = 0x56555949
  SDL_PIXELFORMAT_YUY2 = 0x32595559
  SDL_PIXELFORMAT_UYVY = 0x59565955
  SDL_PIXELFORMAT_YVYU = 0x55595659
  SDL_PIXELFORMAT_NV12 = 0x3231564e
  SDL_PIXELFORMAT_NV21 = 0x3132564e
  SDL_PIXELFORMAT_P010 = 0x30313050
  SDL_PIXELFORMAT_EXTERNAL_OES = 0x2053454f
  SDL_PIXELFORMAT_MJPG = 0x47504a4d
}

///|
/// Colorspace color type.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_ColorType
/// {
///     SDL_COLOR_TYPE_UNKNOWN = 0,
///     SDL_COLOR_TYPE_RGB = 1,
///     SDL_COLOR_TYPE_YCBCR = 2
/// } SDL_ColorType;
/// ```
pub(all) enum SDL_ColorType {
  SDL_COLOR_TYPE_UNKNOWN = 0
  SDL_COLOR_TYPE_RGB = 1
  SDL_COLOR_TYPE_YCBCR = 2
}

///|
/// Colorspace color range, as described by
/// https://www.itu.int/rec/R-REC-BT.2100-2-201807-I/en
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_ColorRange
/// {
///     SDL_COLOR_RANGE_UNKNOWN = 0,
///     SDL_COLOR_RANGE_LIMITED = 1,
///     SDL_COLOR_RANGE_FULL = 2
/// } SDL_ColorRange;
/// ```
pub(all) enum SDL_ColorRange {
  SDL_COLOR_RANGE_UNKNOWN = 0
  SDL_COLOR_RANGE_LIMITED = 1
  SDL_COLOR_RANGE_FULL = 2
}

///|
/// Colorspace color primaries, as described by
/// https://www.itu.int/rec/T-REC-H.273-201612-S/en
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_ColorPrimaries
/// {
///     SDL_COLOR_PRIMARIES_UNKNOWN = 0,
///     SDL_COLOR_PRIMARIES_BT709 = 1,
///     SDL_COLOR_PRIMARIES_UNSPECIFIED = 2,
///     SDL_COLOR_PRIMARIES_BT470M = 4,
///     SDL_COLOR_PRIMARIES_BT470BG = 5,
///     SDL_COLOR_PRIMARIES_BT601 = 6,
///     SDL_COLOR_PRIMARIES_SMPTE240 = 7,
///     SDL_COLOR_PRIMARIES_GENERIC_FILM = 8,
///     SDL_COLOR_PRIMARIES_BT2020 = 9,
///     SDL_COLOR_PRIMARIES_XYZ = 10,
///     SDL_COLOR_PRIMARIES_SMPTE431 = 11,
///     SDL_COLOR_PRIMARIES_SMPTE432 = 12,
///     SDL_COLOR_PRIMARIES_EBU3213 = 22,
///     SDL_COLOR_PRIMARIES_CUSTOM = 31
/// } SDL_ColorPrimaries;
/// ```
pub(all) enum SDL_ColorPrimaries {
  SDL_COLOR_PRIMARIES_UNKNOWN = 0
  SDL_COLOR_PRIMARIES_BT709 = 1
  SDL_COLOR_PRIMARIES_UNSPECIFIED = 2
  SDL_COLOR_PRIMARIES_BT470M = 4
  SDL_COLOR_PRIMARIES_BT470BG = 5
  SDL_COLOR_PRIMARIES_BT601 = 6
  SDL_COLOR_PRIMARIES_SMPTE240 = 7
  SDL_COLOR_PRIMARIES_GENERIC_FILM = 8
  SDL_COLOR_PRIMARIES_BT2020 = 9
  SDL_COLOR_PRIMARIES_XYZ = 10
  SDL_COLOR_PRIMARIES_SMPTE431 = 11
  SDL_COLOR_PRIMARIES_SMPTE432 = 12
  SDL_COLOR_PRIMARIES_EBU3213 = 22
  SDL_COLOR_PRIMARIES_CUSTOM = 31
}

///|
/// Colorspace transfer characteristics.
/// 
/// These are as described by https://www.itu.int/rec/T-REC-H.273-201612-S/en
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_TransferCharacteristics
/// {
///     SDL_TRANSFER_CHARACTERISTICS_UNKNOWN = 0,
///     SDL_TRANSFER_CHARACTERISTICS_BT709 = 1,
///     SDL_TRANSFER_CHARACTERISTICS_UNSPECIFIED = 2,
///     SDL_TRANSFER_CHARACTERISTICS_GAMMA22 = 4,
///     SDL_TRANSFER_CHARACTERISTICS_GAMMA28 = 5,
///     SDL_TRANSFER_CHARACTERISTICS_BT601 = 6,
///     SDL_TRANSFER_CHARACTERISTICS_SMPTE240 = 7,
///     SDL_TRANSFER_CHARACTERISTICS_LINEAR = 8,
///     SDL_TRANSFER_CHARACTERISTICS_LOG100 = 9,
///     SDL_TRANSFER_CHARACTERISTICS_LOG100_SQRT10 = 10,
///     SDL_TRANSFER_CHARACTERISTICS_IEC61966 = 11,
///     SDL_TRANSFER_CHARACTERISTICS_BT1361 = 12,
///     SDL_TRANSFER_CHARACTERISTICS_SRGB = 13,
///     SDL_TRANSFER_CHARACTERISTICS_BT2020_10BIT = 14,
///     SDL_TRANSFER_CHARACTERISTICS_BT2020_12BIT = 15,
///     SDL_TRANSFER_CHARACTERISTICS_PQ = 16,
///     SDL_TRANSFER_CHARACTERISTICS_SMPTE428 = 17,
///     SDL_TRANSFER_CHARACTERISTICS_HLG = 18,
///     SDL_TRANSFER_CHARACTERISTICS_CUSTOM = 31
/// } SDL_TransferCharacteristics;
/// ```
pub(all) enum SDL_TransferCharacteristics {
  SDL_TRANSFER_CHARACTERISTICS_UNKNOWN = 0
  SDL_TRANSFER_CHARACTERISTICS_BT709 = 1
  SDL_TRANSFER_CHARACTERISTICS_UNSPECIFIED = 2
  SDL_TRANSFER_CHARACTERISTICS_GAMMA22 = 4
  SDL_TRANSFER_CHARACTERISTICS_GAMMA28 = 5
  SDL_TRANSFER_CHARACTERISTICS_BT601 = 6
  SDL_TRANSFER_CHARACTERISTICS_SMPTE240 = 7
  SDL_TRANSFER_CHARACTERISTICS_LINEAR = 8
  SDL_TRANSFER_CHARACTERISTICS_LOG100 = 9
  SDL_TRANSFER_CHARACTERISTICS_LOG100_SQRT10 = 10
  SDL_TRANSFER_CHARACTERISTICS_IEC61966 = 11
  SDL_TRANSFER_CHARACTERISTICS_BT1361 = 12
  SDL_TRANSFER_CHARACTERISTICS_SRGB = 13
  SDL_TRANSFER_CHARACTERISTICS_BT2020_10BIT = 14
  SDL_TRANSFER_CHARACTERISTICS_BT2020_12BIT = 15
  SDL_TRANSFER_CHARACTERISTICS_PQ = 16
  SDL_TRANSFER_CHARACTERISTICS_SMPTE428 = 17
  SDL_TRANSFER_CHARACTERISTICS_HLG = 18
  SDL_TRANSFER_CHARACTERISTICS_CUSTOM = 31
}

///|
/// Colorspace matrix coefficients.
/// 
/// These are as described by https://www.itu.int/rec/T-REC-H.273-201612-S/en
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_MatrixCoefficients
/// {
///     SDL_MATRIX_COEFFICIENTS_IDENTITY = 0,
///     SDL_MATRIX_COEFFICIENTS_BT709 = 1,
///     SDL_MATRIX_COEFFICIENTS_UNSPECIFIED = 2,
///     SDL_MATRIX_COEFFICIENTS_FCC = 4,
///     SDL_MATRIX_COEFFICIENTS_BT470BG = 5,
///     SDL_MATRIX_COEFFICIENTS_BT601 = 6,
///     SDL_MATRIX_COEFFICIENTS_SMPTE240 = 7,
///     SDL_MATRIX_COEFFICIENTS_YCGCO = 8,
///     SDL_MATRIX_COEFFICIENTS_BT2020_NCL = 9,
///     SDL_MATRIX_COEFFICIENTS_BT2020_CL = 10,
///     SDL_MATRIX_COEFFICIENTS_SMPTE2085 = 11,
///     SDL_MATRIX_COEFFICIENTS_CHROMA_DERIVED_NCL = 12,
///     SDL_MATRIX_COEFFICIENTS_CHROMA_DERIVED_CL = 13,
///     SDL_MATRIX_COEFFICIENTS_ICTCP = 14,
///     SDL_MATRIX_COEFFICIENTS_CUSTOM = 31
/// } SDL_MatrixCoefficients;
/// ```
pub(all) enum SDL_MatrixCoefficients {
  SDL_MATRIX_COEFFICIENTS_IDENTITY = 0
  SDL_MATRIX_COEFFICIENTS_BT709 = 1
  SDL_MATRIX_COEFFICIENTS_UNSPECIFIED = 2
  SDL_MATRIX_COEFFICIENTS_FCC = 4
  SDL_MATRIX_COEFFICIENTS_BT470BG = 5
  SDL_MATRIX_COEFFICIENTS_BT601 = 6
  SDL_MATRIX_COEFFICIENTS_SMPTE240 = 7
  SDL_MATRIX_COEFFICIENTS_YCGCO = 8
  SDL_MATRIX_COEFFICIENTS_BT2020_NCL = 9
  SDL_MATRIX_COEFFICIENTS_BT2020_CL = 10
  SDL_MATRIX_COEFFICIENTS_SMPTE2085 = 11
  SDL_MATRIX_COEFFICIENTS_CHROMA_DERIVED_NCL = 12
  SDL_MATRIX_COEFFICIENTS_CHROMA_DERIVED_CL = 13
  SDL_MATRIX_COEFFICIENTS_ICTCP = 14
  SDL_MATRIX_COEFFICIENTS_CUSTOM = 31
}

///|
/// Colorspace chroma sample location.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// ```c
/// typedef enum SDL_ChromaLocation
/// {
///     SDL_CHROMA_LOCATION_NONE = 0,
///     SDL_CHROMA_LOCATION_LEFT = 1,
///     SDL_CHROMA_LOCATION_CENTER = 2,
///     SDL_CHROMA_LOCATION_TOPLEFT = 3
/// } SDL_ChromaLocation;
/// ```
pub(all) enum SDL_ChromaLocation {
  SDL_CHROMA_LOCATION_NONE = 0
  SDL_CHROMA_LOCATION_LEFT = 1
  SDL_CHROMA_LOCATION_CENTER = 2
  SDL_CHROMA_LOCATION_TOPLEFT = 3
}

///|
/// Colorspace definitions.
/// 
/// Since similar colorspaces may vary in their details (matrix, transfer
/// function, etc.), this is not an exhaustive list, but rather a
/// representative sample of the kinds of colorspaces supported in SDL.
/// 
/// @since This enum is available since SDL 3.2.0.
/// 
/// @see SDL_ColorPrimaries
/// @see SDL_ColorRange
/// @see SDL_ColorType
/// @see SDL_MatrixCoefficients
/// @see SDL_TransferCharacteristics
/// 
/// ```c
/// typedef enum SDL_Colorspace
/// {
///     SDL_COLORSPACE_UNKNOWN = 0,
///     SDL_COLORSPACE_SRGB = 0x120005a0u,
///     SDL_COLORSPACE_SRGB_LINEAR = 0x12000500u,
///     SDL_COLORSPACE_HDR10 = 0x12002600u,
///     SDL_COLORSPACE_JPEG = 0x220004c6u,
///     SDL_COLORSPACE_BT601_LIMITED = 0x211018c6u,
///     SDL_COLORSPACE_BT601_FULL = 0x221018c6u,
///     SDL_COLORSPACE_BT709_LIMITED = 0x21100421u,
///     SDL_COLORSPACE_BT709_FULL = 0x22100421u,
///     SDL_COLORSPACE_BT2020_LIMITED = 0x21102609u,
///     SDL_COLORSPACE_BT2020_FULL = 0x22102609u,
///     SDL_COLORSPACE_RGB_DEFAULT = SDL_COLORSPACE_SRGB,
///     SDL_COLORSPACE_YUV_DEFAULT = SDL_COLORSPACE_JPEG
/// } SDL_Colorspace;
/// ```
pub(all) enum SDL_Colorspace {
  SDL_COLORSPACE_UNKNOWN = 0
  SDL_COLORSPACE_SRGB = 0x120005a0
  SDL_COLORSPACE_SRGB_LINEAR = 0x12000500
  SDL_COLORSPACE_HDR10 = 0x12002600
  SDL_COLORSPACE_JPEG = 0x220004c6
  SDL_COLORSPACE_BT601_LIMITED = 0x211018c6
  SDL_COLORSPACE_BT601_FULL = 0x221018c6
  SDL_COLORSPACE_BT709_LIMITED = 0x21100421
  SDL_COLORSPACE_BT709_FULL = 0x22100421
  SDL_COLORSPACE_BT2020_LIMITED = 0x21102609
  SDL_COLORSPACE_BT2020_FULL = 0x22102609
}

///|
/// A structure that represents a color as RGBA components.
/// 
/// The bits of this structure can be directly reinterpreted as an
/// integer-packed color which uses the SDL_PIXELFORMAT_RGBA32 format
/// (SDL_PIXELFORMAT_ABGR8888 on little-endian systems and
/// SDL_PIXELFORMAT_RGBA8888 on big-endian systems).
/// 
/// @since This struct is available since SDL 3.2.0.
/// 
/// ```c
/// typedef struct SDL_Color
/// {
///     Uint8 r;
///     Uint8 g;
///     Uint8 b;
///     Uint8 a;
/// } SDL_Color;
/// ```
pub(all) struct SDL_Color {
  r : UInt
  g : UInt
  b : UInt
  a : UInt
}

///|
/// The bits of this structure can be directly reinterpreted as a float-packed
/// color which uses the SDL_PIXELFORMAT_RGBA128_FLOAT format
/// 
/// @since This struct is available since SDL 3.2.0.
/// 
/// ```c
/// typedef struct SDL_FColor
/// {
///     float r;
///     float g;
///     float b;
///     float a;
/// } SDL_FColor;
/// ```
pub(all) struct SDL_FColor {
  r : Float
  g : Float
  b : Float
  a : Float
}

///|
/// A set of indexed colors representing a palette.
/// 
/// @since This struct is available since SDL 3.2.0.
/// 
/// @see SDL_SetPaletteColors
/// 
/// ```c
/// typedef struct SDL_Palette
/// {
///     int ncolors;
///     SDL_Color *colors;
///     Uint32 version;
///     int refcount;
/// } SDL_Palette;
/// ```
#external
pub type SDL_Palette

///|
/// Details about the format of a pixel.
/// 
/// @since This struct is available since SDL 3.2.0.
/// 
/// ```c
/// typedef struct SDL_PixelFormatDetails
/// {
///     SDL_PixelFormat format;
///     Uint8 bits_per_pixel;
///     Uint8 bytes_per_pixel;
///     Uint8 padding[2];
///     Uint32 Rmask;
///     Uint32 Gmask;
///     Uint32 Bmask;
///     Uint32 Amask;
///     Uint8 Rbits;
///     Uint8 Gbits;
///     Uint8 Bbits;
///     Uint8 Abits;
///     Uint8 Rshift;
///     Uint8 Gshift;
///     Uint8 Bshift;
///     Uint8 Ashift;
/// } SDL_PixelFormatDetails;
/// ```
#external
pub type SDL_PixelFormatDetails

// Function bindings

///|
/// Get the human readable name of a pixel format.
/// 
/// @param format the pixel format to query.
/// @return the human readable name of the specified pixel format or
///          "SDL_PIXELFORMAT_UNKNOWN" if the format isn't recognized.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetPixelFormatName(SDL_PixelFormat format);
/// ```
pub fn sdl_GetPixelFormatName(format : SDL_PixelFormat) -> String {
  let cres = __sdl_GetPixelFormatName(format)
  let res = cres.to_string()
  free_cstr(cres)
  res
}

///|
extern "C" fn __sdl_GetPixelFormatName(format : SDL_PixelFormat) -> CStr = "SDL_GetPixelFormatName"

///|
/// Convert one of the enumerated pixel formats to a bpp value and RGBA masks.
/// 
/// @param format one of the SDL_PixelFormat values.
/// @param bpp a bits per pixel value; usually 15, 16, or 32.
/// @param Rmask a pointer filled in with the red mask for the format.
/// @param Gmask a pointer filled in with the green mask for the format.
/// @param Bmask a pointer filled in with the blue mask for the format.
/// @param Amask a pointer filled in with the alpha mask for the format.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetPixelFormatForMasks
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetMasksForPixelFormat(SDL_PixelFormat format, int *bpp, Uint32 *Rmask, Uint32 *Gmask, Uint32 *Bmask, Uint32 *Amask);
/// ```
#owned(bpp, rmask, gmask, bmask, amask)
pub extern "C" fn sdl_GetMasksForPixelFormat(
  format : SDL_PixelFormat,
  bpp : FixedArray[Int],
  rmask : FixedArray[UInt],
  gmask : FixedArray[UInt],
  bmask : FixedArray[UInt],
  amask : FixedArray[UInt],
) -> Bool = "SDL_GetMasksForPixelFormat"

///|
/// Convert a bpp value and RGBA masks to an enumerated pixel format.
/// 
/// This will return `SDL_PIXELFORMAT_UNKNOWN` if the conversion wasn't
/// possible.
/// 
/// @param bpp a bits per pixel value; usually 15, 16, or 32.
/// @param Rmask the red mask for the format.
/// @param Gmask the green mask for the format.
/// @param Bmask the blue mask for the format.
/// @param Amask the alpha mask for the format.
/// @return the SDL_PixelFormat value corresponding to the format masks, or
///          SDL_PIXELFORMAT_UNKNOWN if there isn't a match.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetMasksForPixelFormat
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_PixelFormat SDLCALL SDL_GetPixelFormatForMasks(int bpp, Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask);
/// ```
pub extern "C" fn sdl_GetPixelFormatForMasks(
  bpp : Int,
  rmask : UInt,
  gmask : UInt,
  bmask : UInt,
  amask : UInt,
) -> SDL_PixelFormat = "SDL_GetPixelFormatForMasks"

///|
/// Create an SDL_PixelFormatDetails structure corresponding to a pixel format.
/// 
/// Returned structure may come from a shared global cache (i.e. not newly
/// allocated), and hence should not be modified, especially the palette. Weird
/// errors such as `Blit combination not supported` may occur.
/// 
/// @param format one of the SDL_PixelFormat values.
/// @return a pointer to a SDL_PixelFormatDetails structure or NULL on
///          failure; call SDL_GetError() for more information.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC const SDL_PixelFormatDetails * SDLCALL SDL_GetPixelFormatDetails(SDL_PixelFormat format);
/// ```
pub extern "C" fn sdl_GetPixelFormatDetails(
  format : SDL_PixelFormat,
) -> SDL_PixelFormatDetails = "SDL_GetPixelFormatDetails"

///|
/// Create a palette structure with the specified number of color entries.
/// 
/// The palette entries are initialized to white.
/// 
/// @param ncolors represents the number of color entries in the color palette.
/// @return a new SDL_Palette structure on success or NULL on failure (e.g. if
///          there wasn't enough memory); call SDL_GetError() for more
///          information.
/// 
/// @threadsafety It is safe to call this function from any thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_DestroyPalette
/// @see SDL_SetPaletteColors
/// @see SDL_SetSurfacePalette
/// 
/// ```c
/// extern SDL_DECLSPEC SDL_Palette * SDLCALL SDL_CreatePalette(int ncolors);
/// ```
pub extern "C" fn sdl_CreatePalette(ncolors : Int) -> SDL_Palette = "SDL_CreatePalette"

///|
/// Set a range of colors in a palette.
/// 
/// @param palette the SDL_Palette structure to modify.
/// @param colors an array of SDL_Color structures to copy into the palette.
/// @param firstcolor the index of the first palette entry to modify.
/// @param ncolors the number of entries to modify.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
/// 
/// @threadsafety It is safe to call this function from any thread, as long as
///               the palette is not modified or destroyed in another thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetPaletteColors(SDL_Palette *palette, const SDL_Color *colors, int firstcolor, int ncolors);
/// ```
#owned(colors)
pub extern "C" fn sdl_SetPaletteColors(
  palette : SDL_Palette,
  colors : FixedArray[SDL_Color],
  firstcolor : Int,
  ncolors : Int,
) -> Bool = "SDL_SetPaletteColors"

///|
/// Free a palette created with SDL_CreatePalette().
/// 
/// @param palette the SDL_Palette structure to be freed.
/// 
/// @threadsafety It is safe to call this function from any thread, as long as
///               the palette is not modified or destroyed in another thread.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_CreatePalette
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_DestroyPalette(SDL_Palette *palette);
/// ```
pub extern "C" fn sdl_DestroyPalette(palette : SDL_Palette) = "SDL_DestroyPalette"

///|
/// Map an RGB triple to an opaque pixel value for a given pixel format.
/// 
/// This function maps the RGB color value to the specified pixel format and
/// returns the pixel value best approximating the given RGB color value for
/// the given pixel format.
/// 
/// If the format has a palette (8-bit) the index of the closest matching color
/// in the palette will be returned.
/// 
/// If the specified pixel format has an alpha component it will be returned as
/// all 1 bits (fully opaque).
/// 
/// If the pixel format bpp (color depth) is less than 32-bpp then the unused
/// upper bits of the return value can safely be ignored (e.g., with a 16-bpp
/// format the return value can be assigned to a Uint16, and similarly a Uint8
/// for an 8-bpp format).
/// 
/// @param format a pointer to SDL_PixelFormatDetails describing the pixel
///               format.
/// @param palette an optional palette for indexed formats, may be NULL.
/// @param r the red component of the pixel in the range 0-255.
/// @param g the green component of the pixel in the range 0-255.
/// @param b the blue component of the pixel in the range 0-255.
/// @return a pixel value.
/// 
/// @threadsafety It is safe to call this function from any thread, as long as
///               the palette is not modified.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetPixelFormatDetails
/// @see SDL_GetRGB
/// @see SDL_MapRGBA
/// @see SDL_MapSurfaceRGB
/// 
/// ```c
/// extern SDL_DECLSPEC Uint32 SDLCALL SDL_MapRGB(const SDL_PixelFormatDetails *format, const SDL_Palette *palette, Uint8 r, Uint8 g, Uint8 b);
/// ```
pub extern "C" fn sdl_MapRGB(
  format : SDL_PixelFormatDetails,
  palette : SDL_Palette,
  r : UInt,
  g : UInt,
  b : UInt,
) -> UInt = "SDL_MapRGB"

///|
/// Map an RGBA quadruple to a pixel value for a given pixel format.
/// 
/// This function maps the RGBA color value to the specified pixel format and
/// returns the pixel value best approximating the given RGBA color value for
/// the given pixel format.
/// 
/// If the specified pixel format has no alpha component the alpha value will
/// be ignored (as it will be in formats with a palette).
/// 
/// If the format has a palette (8-bit) the index of the closest matching color
/// in the palette will be returned.
/// 
/// If the pixel format bpp (color depth) is less than 32-bpp then the unused
/// upper bits of the return value can safely be ignored (e.g., with a 16-bpp
/// format the return value can be assigned to a Uint16, and similarly a Uint8
/// for an 8-bpp format).
/// 
/// @param format a pointer to SDL_PixelFormatDetails describing the pixel
///               format.
/// @param palette an optional palette for indexed formats, may be NULL.
/// @param r the red component of the pixel in the range 0-255.
/// @param g the green component of the pixel in the range 0-255.
/// @param b the blue component of the pixel in the range 0-255.
/// @param a the alpha component of the pixel in the range 0-255.
/// @return a pixel value.
/// 
/// @threadsafety It is safe to call this function from any thread, as long as
///               the palette is not modified.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetPixelFormatDetails
/// @see SDL_GetRGBA
/// @see SDL_MapRGB
/// @see SDL_MapSurfaceRGBA
/// 
/// ```c
/// extern SDL_DECLSPEC Uint32 SDLCALL SDL_MapRGBA(const SDL_PixelFormatDetails *format, const SDL_Palette *palette, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
/// ```
pub extern "C" fn sdl_MapRGBA(
  format : SDL_PixelFormatDetails,
  palette : SDL_Palette,
  r : UInt,
  g : UInt,
  b : UInt,
  a : UInt,
) -> UInt = "SDL_MapRGBA"

///|
/// Get RGB values from a pixel in the specified format.
/// 
/// This function uses the entire 8-bit [0..255] range when converting color
/// components from pixel formats with less than 8-bits per RGB component
/// (e.g., a completely white pixel in 16-bit RGB565 format would return [0xff,
/// 0xff, 0xff] not [0xf8, 0xfc, 0xf8]).
/// 
/// @param pixelvalue a pixel value.
/// @param format a pointer to SDL_PixelFormatDetails describing the pixel
///               format.
/// @param palette an optional palette for indexed formats, may be NULL.
/// @param r a pointer filled in with the red component, may be NULL.
/// @param g a pointer filled in with the green component, may be NULL.
/// @param b a pointer filled in with the blue component, may be NULL.
/// 
/// @threadsafety It is safe to call this function from any thread, as long as
///               the palette is not modified.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetPixelFormatDetails
/// @see SDL_GetRGBA
/// @see SDL_MapRGB
/// @see SDL_MapRGBA
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_GetRGB(Uint32 pixelvalue, const SDL_PixelFormatDetails *format, const SDL_Palette *palette, Uint8 *r, Uint8 *g, Uint8 *b);
/// ```
#owned(r, g, b)
pub extern "C" fn sdl_GetRGB(
  pixelvalue : UInt,
  format : SDL_PixelFormatDetails,
  palette : SDL_Palette,
  r : FixedArray[UInt],
  g : FixedArray[UInt],
  b : FixedArray[UInt],
) = "SDL_GetRGB"

///|
/// Get RGBA values from a pixel in the specified format.
/// 
/// This function uses the entire 8-bit [0..255] range when converting color
/// components from pixel formats with less than 8-bits per RGB component
/// (e.g., a completely white pixel in 16-bit RGB565 format would return [0xff,
/// 0xff, 0xff] not [0xf8, 0xfc, 0xf8]).
/// 
/// If the surface has no alpha component, the alpha will be returned as 0xff
/// (100% opaque).
/// 
/// @param pixelvalue a pixel value.
/// @param format a pointer to SDL_PixelFormatDetails describing the pixel
///               format.
/// @param palette an optional palette for indexed formats, may be NULL.
/// @param r a pointer filled in with the red component, may be NULL.
/// @param g a pointer filled in with the green component, may be NULL.
/// @param b a pointer filled in with the blue component, may be NULL.
/// @param a a pointer filled in with the alpha component, may be NULL.
/// 
/// @threadsafety It is safe to call this function from any thread, as long as
///               the palette is not modified.
/// 
/// @since This function is available since SDL 3.2.0.
/// 
/// @see SDL_GetPixelFormatDetails
/// @see SDL_GetRGB
/// @see SDL_MapRGB
/// @see SDL_MapRGBA
/// 
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_GetRGBA(Uint32 pixelvalue, const SDL_PixelFormatDetails *format, const SDL_Palette *palette, Uint8 *r, Uint8 *g, Uint8 *b, Uint8 *a);
/// ```
#owned(r, g, b, a)
pub extern "C" fn sdl_GetRGBA(
  pixelvalue : UInt,
  format : SDL_PixelFormatDetails,
  palette : SDL_Palette,
  r : FixedArray[UInt],
  g : FixedArray[UInt],
  b : FixedArray[UInt],
  a : FixedArray[UInt],
) = "SDL_GetRGBA"
