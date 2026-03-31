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

/// # CategoryCPUInfo
///
/// CPU feature detection for SDL.

///|
/// A guess for the cacheline size used for padding.
///
/// ```c
/// #define SDL_CACHELINE_SIZE  128
/// ```
pub const SDL_CACHELINE_SIZE : Int = 128

///|
/// Get the number of logical CPU cores available.
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetNumLogicalCPUCores(void);
/// ```
pub extern "C" fn sdl_GetNumLogicalCPUCores() -> Int = "SDL_GetNumLogicalCPUCores"

///|
/// Determine the L1 cache line size of the CPU.
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetCPUCacheLineSize(void);
/// ```
pub extern "C" fn sdl_GetCPUCacheLineSize() -> Int = "SDL_GetCPUCacheLineSize"

///|
/// Determine whether the CPU has AltiVec features.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasAltiVec(void);
/// ```
pub extern "C" fn sdl_HasAltiVec() -> Bool = "SDL_HasAltiVec"

///|
/// Determine whether the CPU has MMX features.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasMMX(void);
/// ```
pub extern "C" fn sdl_HasMMX() -> Bool = "SDL_HasMMX"

///|
/// Determine whether the CPU has SSE features.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasSSE(void);
/// ```
pub extern "C" fn sdl_HasSSE() -> Bool = "SDL_HasSSE"

///|
/// Determine whether the CPU has SSE2 features.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasSSE2(void);
/// ```
pub extern "C" fn sdl_HasSSE2() -> Bool = "SDL_HasSSE2"

///|
/// Determine whether the CPU has SSE3 features.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasSSE3(void);
/// ```
pub extern "C" fn sdl_HasSSE3() -> Bool = "SDL_HasSSE3"

///|
/// Determine whether the CPU has SSE4.1 features.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasSSE41(void);
/// ```
pub extern "C" fn sdl_HasSSE41() -> Bool = "SDL_HasSSE41"

///|
/// Determine whether the CPU has SSE4.2 features.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasSSE42(void);
/// ```
pub extern "C" fn sdl_HasSSE42() -> Bool = "SDL_HasSSE42"

///|
/// Determine whether the CPU has AVX features.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasAVX(void);
/// ```
pub extern "C" fn sdl_HasAVX() -> Bool = "SDL_HasAVX"

///|
/// Determine whether the CPU has AVX2 features.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasAVX2(void);
/// ```
pub extern "C" fn sdl_HasAVX2() -> Bool = "SDL_HasAVX2"

///|
/// Determine whether the CPU has AVX-512F (foundation) features.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasAVX512F(void);
/// ```
pub extern "C" fn sdl_HasAVX512F() -> Bool = "SDL_HasAVX512F"

///|
/// Determine whether the CPU has ARM SIMD (ARMv6) features.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasARMSIMD(void);
/// ```
pub extern "C" fn sdl_HasARMSIMD() -> Bool = "SDL_HasARMSIMD"

///|
/// Determine whether the CPU has NEON (ARM SIMD) features.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasNEON(void);
/// ```
pub extern "C" fn sdl_HasNEON() -> Bool = "SDL_HasNEON"

///|
/// Determine whether the CPU has LSX (LOONGARCH SIMD) features.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasLSX(void);
/// ```
pub extern "C" fn sdl_HasLSX() -> Bool = "SDL_HasLSX"

///|
/// Determine whether the CPU has LASX (LOONGARCH SIMD) features.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasLASX(void);
/// ```
pub extern "C" fn sdl_HasLASX() -> Bool = "SDL_HasLASX"

///|
/// Get the amount of RAM configured in the system.
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetSystemRAM(void);
/// ```
pub extern "C" fn sdl_GetSystemRAM() -> Int = "SDL_GetSystemRAM"

///|
/// Report the alignment this system needs for SIMD allocations.
///
/// ```c
/// extern SDL_DECLSPEC size_t SDLCALL SDL_GetSIMDAlignment(void);
/// ```
pub extern "C" fn sdl_GetSIMDAlignment() -> Int = "SDL_GetSIMDAlignment"
