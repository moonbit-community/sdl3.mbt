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

/// # CategoryBlendmode
///
/// Blend modes decide how two colors will mix together. There are both
/// standard modes for basic needs and a means to create custom modes,
/// dictating what sort of math to do on what color components.

///|
/// A set of blend modes used in drawing operations.
///
/// ```c
/// typedef Uint32 SDL_BlendMode;
///
/// #define SDL_BLENDMODE_NONE                  0x00000000u /**< no blending: dstRGBA = srcRGBA */
/// #define SDL_BLENDMODE_BLEND                 0x00000001u /**< alpha blending: dstRGB = (srcRGB * srcA) + (dstRGB * (1-srcA)), dstA = srcA + (dstA * (1-srcA)) */
/// #define SDL_BLENDMODE_BLEND_PREMULTIPLIED   0x00000010u /**< pre-multiplied alpha blending: dstRGBA = srcRGBA + (dstRGBA * (1-srcA)) */
/// #define SDL_BLENDMODE_ADD                   0x00000002u /**< additive blending: dstRGB = (srcRGB * srcA) + dstRGB, dstA = dstA */
/// #define SDL_BLENDMODE_ADD_PREMULTIPLIED     0x00000020u /**< pre-multiplied additive blending: dstRGB = srcRGB + dstRGB, dstA = dstA */
/// #define SDL_BLENDMODE_MOD                   0x00000004u /**< color modulate: dstRGB = srcRGB * dstRGB, dstA = dstA */
/// #define SDL_BLENDMODE_MUL                   0x00000008u /**< color multiply: dstRGB = (srcRGB * dstRGB) + (dstRGB * (1-srcA)), dstA = dstA */
/// #define SDL_BLENDMODE_INVALID               0x7FFFFFFFu
/// ```
pub(all) enum SDL_BlendMode {
  SDL_BLENDMODE_NONE = 0x00000000
  SDL_BLENDMODE_BLEND = 0x00000001
  SDL_BLENDMODE_BLEND_PREMULTIPLIED = 0x00000010
  SDL_BLENDMODE_ADD = 0x00000002
  SDL_BLENDMODE_ADD_PREMULTIPLIED = 0x00000020
  SDL_BLENDMODE_MOD = 0x00000004
  SDL_BLENDMODE_MUL = 0x00000008
  SDL_BLENDMODE_INVALID = 0x7FFFFFFF
}

///| The blend operation used when combining source and destination pixel

///|
/// components.
///
/// ```c
/// typedef enum SDL_BlendOperation
/// {
///     SDL_BLENDOPERATION_ADD              = 0x1,  /**< dst + src: supported by all renderers */
///     SDL_BLENDOPERATION_SUBTRACT         = 0x2,  /**< src - dst : supported by D3D, OpenGL, OpenGLES, and Vulkan */
///     SDL_BLENDOPERATION_REV_SUBTRACT     = 0x3,  /**< dst - src : supported by D3D, OpenGL, OpenGLES, and Vulkan */
///     SDL_BLENDOPERATION_MINIMUM          = 0x4,  /**< min(dst, src) : supported by D3D, OpenGL, OpenGLES, and Vulkan */
///     SDL_BLENDOPERATION_MAXIMUM          = 0x5   /**< max(dst, src) : supported by D3D, OpenGL, OpenGLES, and Vulkan */
/// } SDL_BlendOperation;
/// ```
pub(all) enum SDL_BlendOperation {
  SDL_BLENDOPERATION_ADD = 1
  SDL_BLENDOPERATION_SUBTRACT = 2
  SDL_BLENDOPERATION_REV_SUBTRACT = 3
  SDL_BLENDOPERATION_MINIMUM = 4
  SDL_BLENDOPERATION_MAXIMUM = 5
}

///|
/// The normalized factor used to multiply pixel components.
///
/// ```c
/// typedef enum SDL_BlendFactor
/// {
///     SDL_BLENDFACTOR_ZERO                = 0x1,  /**< 0, 0, 0, 0 */
///     SDL_BLENDFACTOR_ONE                 = 0x2,  /**< 1, 1, 1, 1 */
///     SDL_BLENDFACTOR_SRC_COLOR           = 0x3,  /**< srcR, srcG, srcB, srcA */
///     SDL_BLENDFACTOR_ONE_MINUS_SRC_COLOR = 0x4,  /**< 1-srcR, 1-srcG, 1-srcB, 1-srcA */
///     SDL_BLENDFACTOR_SRC_ALPHA           = 0x5,  /**< srcA, srcA, srcA, srcA */
///     SDL_BLENDFACTOR_ONE_MINUS_SRC_ALPHA = 0x6,  /**< 1-srcA, 1-srcA, 1-srcA, 1-srcA */
///     SDL_BLENDFACTOR_DST_COLOR           = 0x7,  /**< dstR, dstG, dstB, dstA */
///     SDL_BLENDFACTOR_ONE_MINUS_DST_COLOR = 0x8,  /**< 1-dstR, 1-dstG, 1-dstB, 1-dstA */
///     SDL_BLENDFACTOR_DST_ALPHA           = 0x9,  /**< dstA, dstA, dstA, dstA */
///     SDL_BLENDFACTOR_ONE_MINUS_DST_ALPHA = 0xA   /**< 1-dstA, 1-dstA, 1-dstA, 1-dstA */
/// } SDL_BlendFactor;
/// ```
pub(all) enum SDL_BlendFactor {
  SDL_BLENDFACTOR_ZERO = 1
  SDL_BLENDFACTOR_ONE = 2
  SDL_BLENDFACTOR_SRC_COLOR = 3
  SDL_BLENDFACTOR_ONE_MINUS_SRC_COLOR = 4
  SDL_BLENDFACTOR_SRC_ALPHA = 5
  SDL_BLENDFACTOR_ONE_MINUS_SRC_ALPHA = 6
  SDL_BLENDFACTOR_DST_COLOR = 7
  SDL_BLENDFACTOR_ONE_MINUS_DST_COLOR = 8
  SDL_BLENDFACTOR_DST_ALPHA = 9
  SDL_BLENDFACTOR_ONE_MINUS_DST_ALPHA = 10
}

///|
/// Compose a custom blend mode for renderers.
///
/// ```c
/// extern SDL_DECLSPEC SDL_BlendMode SDLCALL SDL_ComposeCustomBlendMode(SDL_BlendFactor srcColorFactor,
///                                                                  SDL_BlendFactor dstColorFactor,
///                                                                  SDL_BlendOperation colorOperation,
///                                                                  SDL_BlendFactor srcAlphaFactor,
///                                                                  SDL_BlendFactor dstAlphaFactor,
///                                                                  SDL_BlendOperation alphaOperation);
/// ```
pub extern "C" fn sdl_ComposeCustomBlendMode(
  srcColorFactor : SDL_BlendFactor,
  dstColorFactor : SDL_BlendFactor,
  colorOperation : SDL_BlendOperation,
  srcAlphaFactor : SDL_BlendFactor,
  dstAlphaFactor : SDL_BlendFactor,
  alphaOperation : SDL_BlendOperation,
) -> SDL_BlendMode = "SDL_ComposeCustomBlendMode"
