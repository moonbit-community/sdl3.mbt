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

/// # CategoryRender
///
/// Header file for SDL 2D rendering functions.
///
/// This API supports the following features:
///
/// - single pixel points
/// - single pixel lines
/// - filled rectangles
/// - texture images
/// - 2D polygons
///
/// The primitives may be drawn in opaque, blended, or additive modes.
///
/// The texture images may be drawn in opaque, blended, or additive modes. They
/// can have an additional color tint or alpha modulation applied to them, and
/// may also be stretched with linear interpolation.
///
/// This API is designed to accelerate simple 2D operations. You may want more
/// functionality such as polygons and particle effects and in that case you
/// should use SDL's OpenGL/Direct3D support, the SDL3 GPU API, or one of the
/// many good 3D engines.
///
/// These functions must be called from the main thread. See this bug for
/// details: https://github.com/libsdl-org/SDL/issues/986

#external
pub type SDL_Renderer

pub fn SDL_Renderer::is_null(self: Self) -> Bool {
  is_nullptr(self)
}

#external
pub type SDL_Texture

pub const SDL_SOFTWARE_RENDERER = "software"

///| Vertex structure.
///
/// @since This struct is available since SDL 3.2.0.
///
/// ```c
/// typedef struct SDL_Vertex
/// {
///     SDL_FPoint position;
///     SDL_FColor color;
///     SDL_FPoint tex_coord;
/// } SDL_Vertex;
/// ```
pub(all) struct SDL_Vertex {
  position: SDL_FPoint
  color: SDL_FColor
  tex_coord: SDL_FPoint
}

///| The access pattern allowed for a texture.
///
/// @since This enum is available since SDL 3.2.0.
///
/// ```c
/// typedef enum SDL_TextureAccess
/// {
///     SDL_TEXTUREACCESS_STATIC,
///     SDL_TEXTUREACCESS_STREAMING,
///     SDL_TEXTUREACCESS_TARGET
/// } SDL_TextureAccess;
/// ```
pub(all) enum SDL_TextureAccess {
  SDL_TEXTUREACCESS_STATIC
  SDL_TEXTUREACCESS_STREAMING
  SDL_TEXTUREACCESS_TARGET
}

///| The addressing mode for a texture when used in SDL_RenderGeometry().
///
/// This affects how texture coordinates are interpreted outside of [0, 1]
///
/// @since This enum is available since SDL 3.4.0.
///
/// ```c
/// typedef enum SDL_TextureAddressMode
/// {
///     SDL_TEXTURE_ADDRESS_INVALID = -1,
///     SDL_TEXTURE_ADDRESS_AUTO,
///     SDL_TEXTURE_ADDRESS_CLAMP,
///     SDL_TEXTURE_ADDRESS_WRAP
/// } SDL_TextureAddressMode;
/// ```
pub(all) enum SDL_TextureAddressMode {
  SDL_TEXTURE_ADDRESS_AUTO
  SDL_TEXTURE_ADDRESS_CLAMP
  SDL_TEXTURE_ADDRESS_WRAP
  SDL_TEXTURE_ADDRESS_INVALID = 0xffff_ffff
}

///| How the logical size is mapped to the output.
///
/// @since This enum is available since SDL 3.2.0.
///
/// ```c
/// typedef enum SDL_RendererLogicalPresentation
/// {
///     SDL_LOGICAL_PRESENTATION_DISABLED,
///     SDL_LOGICAL_PRESENTATION_STRETCH,
///     SDL_LOGICAL_PRESENTATION_LETTERBOX,
///     SDL_LOGICAL_PRESENTATION_OVERSCAN,
///     SDL_LOGICAL_PRESENTATION_INTEGER_SCALE
/// } SDL_RendererLogicalPresentation;
/// ```
pub(all) enum SDL_RendererLogicalPresentation {
  SDL_LOGICAL_PRESENTATION_DISABLED
  SDL_LOGICAL_PRESENTATION_STRETCH
  SDL_LOGICAL_PRESENTATION_LETTERBOX
  SDL_LOGICAL_PRESENTATION_OVERSCAN
  SDL_LOGICAL_PRESENTATION_INTEGER_SCALE
}

///| Get the number of 2D rendering drivers available for the current display.
///
/// A render driver is a set of code that handles rendering and texture
/// management on a particular display. Normally there is only one, but some
/// drivers may have several available with different capabilities.
///
/// There may be none if SDL was compiled without render support.
///
/// @return the number of built in render drivers.
///
/// @threadsafety It is safe to call this function from any thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_CreateRenderer
/// @see SDL_GetRenderDriver
///
/// ```c
/// extern SDL_DECLSPEC int SDLCALL SDL_GetNumRenderDrivers(void);
/// ```
pub extern "C" fn sdl_GetNumRenderDrivers() -> Int = "SDL_GetNumRenderDrivers"

///| Use this function to get the name of a built in 2D rendering driver.
///
/// The list of rendering drivers is given in the order that they are normally
/// initialized by default; the drivers that seem more reasonable to choose
/// first (as far as the SDL developers believe) are earlier in the list.
///
/// The names of drivers are all simple, low-ASCII identifiers, like "opengl",
/// "direct3d12" or "metal". These never have Unicode characters, and are not
/// meant to be proper names.
///
/// @param index the index of the rendering driver; the value ranges from 0 to
///              SDL_GetNumRenderDrivers() - 1.
/// @return the name of the rendering driver at the requested index, or NULL
///          if an invalid index was specified.
///
/// @threadsafety It is safe to call this function from any thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetNumRenderDrivers
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetRenderDriver(int index);
/// ```
pub fn sdl_GetRenderDriver(index: Int) -> String {
  let cstr = __SDL_GetRenderDriver(index)
  let res = cstr.to_string()
  free_cstr(cstr)
  res
}

pub extern "C" fn __SDL_GetRenderDriver(index: Int) -> CStr = "SDL_GetRenderDriver"

///| Create a window and default renderer.
///
/// @param title the title of the window, in UTF-8 encoding.
/// @param width the width of the window.
/// @param height the height of the window.
/// @param window_flags the flags used to create the window (see
///                     SDL_CreateWindow()).
/// @param window a pointer filled with the window, or NULL on error.
/// @param renderer a pointer filled with the renderer, or NULL on error.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_CreateRenderer
/// @see SDL_CreateWindow
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_CreateWindowAndRenderer(const char *title, int width, int height, SDL_WindowFlags window_flags, SDL_Window **window, SDL_Renderer **renderer);
/// ```
pub fn sdl_CreateWindowAndRenderer(title: String, width: Int, height: Int, window_flags: SDL_WindowFlags, window: FixedArray[SDL_Window], renderer: FixedArray[SDL_Renderer]) -> Bool {
    let c_title = string_to_cbytes(title)
    __SDL_CreateWindowAndRenderer(c_title, width, height, window_flags, window, renderer)
}

pub extern "C" fn __SDL_CreateWindowAndRenderer(title: Bytes, width: Int, height: Int, window_flags: SDL_WindowFlags, window: FixedArray[SDL_Window], renderer: FixedArray[SDL_Renderer]) -> Bool = "SDL_CreateWindowAndRenderer"

///| Create a 2D rendering context for a window.
///
/// If you want a specific renderer, you can specify its name here. A list of
/// available renderers can be obtained by calling SDL_GetRenderDriver()
/// multiple times, with indices from 0 to SDL_GetNumRenderDrivers()-1. If you
/// don't need a specific renderer, specify NULL and SDL will attempt to choose
/// the best option for you, based on what is available on the user's system.
///
/// If `name` is a comma-separated list, SDL will try each name, in the order
/// listed, until one succeeds or all of them fail.
///
/// By default the rendering size matches the window size in pixels, but you
/// can call SDL_SetRenderLogicalPresentation() to change the content size and
/// scaling options.
///
/// @param window the window where rendering is displayed.
/// @param name the name of the rendering driver to initialize, or NULL to let
///             SDL choose one.
/// @return a valid rendering context or NULL if there was an error; call
///          SDL_GetError() for more information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_CreateRendererWithProperties
/// @see SDL_CreateSoftwareRenderer
/// @see SDL_DestroyRenderer
/// @see SDL_GetNumRenderDrivers
/// @see SDL_GetRenderDriver
/// @see SDL_GetRendererName
///
/// ```c
/// extern SDL_DECLSPEC SDL_Renderer * SDLCALL SDL_CreateRenderer(SDL_Window *window, const char *name);
/// ```
pub fn sdl_CreateRenderer(window: SDL_Window, name: String) -> SDL_Renderer {
    let c_name = string_to_cbytes(name)
    __SDL_CreateRenderer(window, c_name)
}

pub extern "C" fn __SDL_CreateRenderer(window: SDL_Window, name: Bytes) -> SDL_Renderer = "SDL_CreateRenderer"

///| Create a 2D rendering context for a window, with the specified properties.
///
/// These are the supported properties:
///
/// - `SDL_PROP_RENDERER_CREATE_NAME_STRING`: the name of the rendering driver
///   to use, if a specific one is desired
/// - `SDL_PROP_RENDERER_CREATE_WINDOW_POINTER`: the window where rendering is
///   displayed, required if this isn't a software renderer using a surface
/// - `SDL_PROP_RENDERER_CREATE_SURFACE_POINTER`: the surface where rendering
///   is displayed, if you want a software renderer without a window
/// - `SDL_PROP_RENDERER_CREATE_OUTPUT_COLORSPACE_NUMBER`: an SDL_Colorspace
///   value describing the colorspace for output to the display, defaults to
///   SDL_COLORSPACE_SRGB. The direct3d11, direct3d12, and metal renderers
///   support SDL_COLORSPACE_SRGB_LINEAR, which is a linear color space and
///   supports HDR output. If you select SDL_COLORSPACE_SRGB_LINEAR, drawing
///   still uses the sRGB colorspace, but values can go beyond 1.0 and float
///   (linear) format textures can be used for HDR content.
/// - `SDL_PROP_RENDERER_CREATE_PRESENT_VSYNC_NUMBER`: non-zero if you want
///   present synchronized with the refresh rate. This property can take any
///   value that is supported by SDL_SetRenderVSync() for the renderer.
///
/// With the SDL GPU renderer:
///
/// - `SDL_PROP_RENDERER_CREATE_GPU_SHADERS_SPIRV_BOOLEAN`: the app is able to
///   provide SPIR-V shaders to SDL_GPURenderState, optional.
/// - `SDL_PROP_RENDERER_CREATE_GPU_SHADERS_DXIL_BOOLEAN`: the app is able to
///   provide DXIL shaders to SDL_GPURenderState, optional.
/// - `SDL_PROP_RENDERER_CREATE_GPU_SHADERS_MSL_BOOLEAN`: the app is able to
///   provide MSL shaders to SDL_GPURenderState, optional.
///
/// With the vulkan renderer:
///
/// - `SDL_PROP_RENDERER_CREATE_VULKAN_INSTANCE_POINTER`: the VkInstance to use
///   with the renderer, optional.
/// - `SDL_PROP_RENDERER_CREATE_VULKAN_SURFACE_NUMBER`: the VkSurfaceKHR to use
///   with the renderer, optional.
/// - `SDL_PROP_RENDERER_CREATE_VULKAN_PHYSICAL_DEVICE_POINTER`: the
///   VkPhysicalDevice to use with the renderer, optional.
/// - `SDL_PROP_RENDERER_CREATE_VULKAN_DEVICE_POINTER`: the VkDevice to use
///   with the renderer, optional.
/// - `SDL_PROP_RENDERER_CREATE_VULKAN_GRAPHICS_QUEUE_FAMILY_INDEX_NUMBER`: the
///   queue family index used for rendering.
/// - `SDL_PROP_RENDERER_CREATE_VULKAN_PRESENT_QUEUE_FAMILY_INDEX_NUMBER`: the
///   queue family index used for presentation.
///
/// @param props the properties to use.
/// @return a valid rendering context or NULL if there was an error; call
///          SDL_GetError() for more information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_CreateProperties
/// @see SDL_CreateRenderer
/// @see SDL_CreateSoftwareRenderer
/// @see SDL_DestroyRenderer
/// @see SDL_GetRendererName
///
/// ```c
/// extern SDL_DECLSPEC SDL_Renderer * SDLCALL SDL_CreateRendererWithProperties(SDL_PropertiesID props);
/// ```
pub extern "C" fn sdl_CreateRendererWithProperties(props: SDL_PropertiesID) -> SDL_Renderer = "SDL_CreateRendererWithProperties"

pub const SDL_PROP_RENDERER_CREATE_NAME_STRING = "SDL.renderer.create.name"
pub const SDL_PROP_RENDERER_CREATE_WINDOW_POINTER = "SDL.renderer.create.window"
pub const SDL_PROP_RENDERER_CREATE_SURFACE_POINTER = "SDL.renderer.create.surface"
pub const SDL_PROP_RENDERER_CREATE_OUTPUT_COLORSPACE_NUMBER = "SDL.renderer.create.output_colorspace"
pub const SDL_PROP_RENDERER_CREATE_PRESENT_VSYNC_NUMBER = "SDL.renderer.create.present_vsync"
pub const SDL_PROP_RENDERER_CREATE_GPU_SHADERS_SPIRV_BOOLEAN = "SDL.renderer.create.gpu.shaders_spirv"
pub const SDL_PROP_RENDERER_CREATE_GPU_SHADERS_DXIL_BOOLEAN = "SDL.renderer.create.gpu.shaders_dxil"
pub const SDL_PROP_RENDERER_CREATE_GPU_SHADERS_MSL_BOOLEAN = "SDL.renderer.create.gpu.shaders_msl"
pub const SDL_PROP_RENDERER_CREATE_VULKAN_INSTANCE_POINTER = "SDL.renderer.create.vulkan.instance"
pub const SDL_PROP_RENDERER_CREATE_VULKAN_SURFACE_NUMBER = "SDL.renderer.create.vulkan.surface"
pub const SDL_PROP_RENDERER_CREATE_VULKAN_PHYSICAL_DEVICE_POINTER = "SDL.renderer.create.vulkan.physical_device"
pub const SDL_PROP_RENDERER_CREATE_VULKAN_DEVICE_POINTER = "SDL.renderer.create.vulkan.device"
pub const SDL_PROP_RENDERER_CREATE_VULKAN_GRAPHICS_QUEUE_FAMILY_INDEX_NUMBER = "SDL.renderer.create.vulkan.graphics_queue_family_index"
pub const SDL_PROP_RENDERER_CREATE_VULKAN_PRESENT_QUEUE_FAMILY_INDEX_NUMBER = "SDL.renderer.create.vulkan.present_queue_family_index"

///| Create a 2D GPU rendering context for a window, with support for the
///| specified shader format.
///
/// This is a convenience function to create a SDL GPU backed renderer,
/// intended to be used with SDL_GPURenderState. The resulting renderer will
/// support shaders in one of the specified shader formats.
///
/// If no available GPU driver supports any of the specified shader formats,
/// this function will fail.
///
/// @param window the window where rendering is displayed.
/// @param format_flags a bitflag indicating which shader formats the app is
///                     able to provide.
/// @param device a pointer filled with the associated GPU device, or NULL on
///               error.
/// @return a valid rendering context or NULL if there was an error; call
///          SDL_GetError() for more information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.4.0.
///
/// @see SDL_CreateRendererWithProperties
/// @see SDL_GetGPUShaderFormats
/// @see SDL_CreateGPUShader
/// @see SDL_CreateGPURenderState
/// @see SDL_SetRenderGPUState
///
/// ```c
/// extern SDL_DECLSPEC SDL_Renderer * SDLCALL SDL_CreateGPURenderer(SDL_Window *window, SDL_GPUShaderFormat format_flags, SDL_GPUDevice **device);
/// ```
pub extern "C" fn sdl_CreateGPURenderer(window: SDL_Window, format_flags: SDL_GPUShaderFormat, device: FixedArray[SDL_GPUDevice]) -> SDL_Renderer = "SDL_CreateGPURenderer"

///| Create a 2D software rendering context for a surface.
///
/// Two other API which can be used to create SDL_Renderer:
/// SDL_CreateRenderer() and SDL_CreateWindowAndRenderer(). These can _also_
/// create a software renderer, but they are intended to be used with an
/// SDL_Window as the final destination and not an SDL_Surface.
///
/// @param surface the SDL_Surface structure representing the surface where
///                rendering is done.
/// @return a valid rendering context or NULL if there was an error; call
///          SDL_GetError() for more information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_DestroyRenderer
///
/// ```c
/// extern SDL_DECLSPEC SDL_Renderer * SDLCALL SDL_CreateSoftwareRenderer(SDL_Surface *surface);
/// ```
pub extern "C" fn sdl_CreateSoftwareRenderer(surface: SDL_Surface) -> SDL_Renderer = "SDL_CreateSoftwareRenderer"

///| Get the renderer associated with a window.
///
/// @param window the window to query.
/// @return the rendering context on success or NULL on failure; call
///          SDL_GetError() for more information.
///
/// @threadsafety It is safe to call this function from any thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Renderer * SDLCALL SDL_GetRenderer(SDL_Window *window);
/// ```
pub extern "C" fn sdl_GetRenderer(window: SDL_Window) -> SDL_Renderer = "SDL_GetRenderer"

///| Get the window associated with a renderer.
///
/// @param renderer the renderer to query.
/// @return the window on success or NULL on failure; call SDL_GetError() for
///          more information.
///
/// @threadsafety It is safe to call this function from any thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Window * SDLCALL SDL_GetRenderWindow(SDL_Renderer *renderer);
/// ```
pub extern "C" fn sdl_GetRenderWindow(renderer: SDL_Renderer) -> SDL_Window = "SDL_GetRenderWindow"

///| Get the name of a renderer.
///
/// @param renderer the rendering context.
/// @return the name of the selected renderer, or NULL on failure; call
///          SDL_GetError() for more information.
///
/// @threadsafety It is safe to call this function from any thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_CreateRenderer
/// @see SDL_CreateRendererWithProperties
///
/// ```c
/// extern SDL_DECLSPEC const char * SDLCALL SDL_GetRendererName(SDL_Renderer *renderer);
/// ```
pub fn sdl_GetRendererName(renderer: SDL_Renderer) -> String {
    let cstr = __SDL_GetRendererName(renderer)
    let res = cstr.to_string()
    free_cstr(cstr)
    res
}

pub extern "C" fn __SDL_GetRendererName(renderer: SDL_Renderer) -> CStr = "SDL_GetRendererName"

///| Get the properties associated with a renderer.
///
/// The following read-only properties are provided by SDL:
///
/// - `SDL_PROP_RENDERER_NAME_STRING`: the name of the rendering driver
/// - `SDL_PROP_RENDERER_WINDOW_POINTER`: the window where rendering is
///   displayed, if any
/// - `SDL_PROP_RENDERER_SURFACE_POINTER`: the surface where rendering is
///   displayed, if this is a software renderer without a window
/// - `SDL_PROP_RENDERER_VSYNC_NUMBER`: the current vsync setting
/// - `SDL_PROP_RENDERER_MAX_TEXTURE_SIZE_NUMBER`: the maximum texture width
///   and height
/// - `SDL_PROP_RENDERER_TEXTURE_FORMATS_POINTER`: a (const SDL_PixelFormat *)
///   array of pixel formats, terminated with SDL_PIXELFORMAT_UNKNOWN,
///   representing the available texture formats for this renderer.
/// - `SDL_PROP_RENDERER_OUTPUT_COLORSPACE_NUMBER`: an SDL_Colorspace value
///   describing the colorspace for output to the display, defaults to
///   SDL_COLORSPACE_SRGB.
/// - `SDL_PROP_RENDERER_HDR_ENABLED_BOOLEAN`: true if the output colorspace is
///   SDL_COLORSPACE_SRGB_LINEAR and the renderer is showing on a display with
///   HDR enabled. This property can change dynamically when
///   SDL_EVENT_WINDOW_HDR_STATE_CHANGED is sent.
/// - `SDL_PROP_RENDERER_SDR_WHITE_POINT_FLOAT`: the value of SDR white in the
///   SDL_COLORSPACE_SRGB_LINEAR colorspace. When HDR is enabled, this value is
///   automatically multiplied into the color scale. This property can change
///   dynamically when SDL_EVENT_WINDOW_HDR_STATE_CHANGED is sent.
/// - `SDL_PROP_RENDERER_HDR_HEADROOM_FLOAT`: the additional high dynamic range
///   that can be displayed, in terms of the SDR white point. When HDR is not
///   enabled, this will be 1.0. This property can change dynamically when
///   SDL_EVENT_WINDOW_HDR_STATE_CHANGED is sent.
///
/// With the direct3d renderer:
///
/// - `SDL_PROP_RENDERER_D3D9_DEVICE_POINTER`: the IDirect3DDevice9 associated
///   with the renderer
///
/// With the direct3d11 renderer:
///
/// - `SDL_PROP_RENDERER_D3D11_DEVICE_POINTER`: the ID3D11Device associated
///   with the renderer
/// - `SDL_PROP_RENDERER_D3D11_SWAPCHAIN_POINTER`: the IDXGISwapChain1
///   associated with the renderer. This may change when the window is resized.
///
/// With the direct3d12 renderer:
///
/// - `SDL_PROP_RENDERER_D3D12_DEVICE_POINTER`: the ID3D12Device associated
///   with the renderer
/// - `SDL_PROP_RENDERER_D3D12_SWAPCHAIN_POINTER`: the IDXGISwapChain4
///   associated with the renderer.
/// - `SDL_PROP_RENDERER_D3D12_COMMAND_QUEUE_POINTER`: the ID3D12CommandQueue
///   associated with the renderer
///
/// With the vulkan renderer:
///
/// - `SDL_PROP_RENDERER_VULKAN_INSTANCE_POINTER`: the VkInstance associated
///   with the renderer
/// - `SDL_PROP_RENDERER_VULKAN_SURFACE_NUMBER`: the VkSurfaceKHR associated
///   with the renderer
/// - `SDL_PROP_RENDERER_VULKAN_PHYSICAL_DEVICE_POINTER`: the VkPhysicalDevice
///   associated with the renderer
/// - `SDL_PROP_RENDERER_VULKAN_DEVICE_POINTER`: the VkDevice associated with
///   the renderer
/// - `SDL_PROP_RENDERER_VULKAN_GRAPHICS_QUEUE_FAMILY_INDEX_NUMBER`: the queue
///   family index used for rendering
/// - `SDL_PROP_RENDERER_VULKAN_PRESENT_QUEUE_FAMILY_INDEX_NUMBER`: the queue
///   family index used for presentation
/// - `SDL_PROP_RENDERER_VULKAN_SWAPCHAIN_IMAGE_COUNT_NUMBER`: the number of
///   swapchain images, or potential frames in flight, used by the Vulkan
///   renderer
///
/// With the gpu renderer:
///
/// - `SDL_PROP_RENDERER_GPU_DEVICE_POINTER`: the SDL_GPUDevice associated with
///   the renderer
///
/// @param renderer the rendering context.
/// @return a valid property ID on success or 0 on failure; call
///          SDL_GetError() for more information.
///
/// @threadsafety It is safe to call this function from any thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_PropertiesID SDLCALL SDL_GetRendererProperties(SDL_Renderer *renderer);
/// ```
pub extern "C" fn sdl_GetRendererProperties(renderer: SDL_Renderer) -> SDL_PropertiesID = "SDL_GetRendererProperties"

pub const SDL_PROP_RENDERER_NAME_STRING = "SDL.renderer.name"
pub const SDL_PROP_RENDERER_WINDOW_POINTER = "SDL.renderer.window"
pub const SDL_PROP_RENDERER_SURFACE_POINTER = "SDL.renderer.surface"
pub const SDL_PROP_RENDERER_VSYNC_NUMBER = "SDL.renderer.vsync"
pub const SDL_PROP_RENDERER_MAX_TEXTURE_SIZE_NUMBER = "SDL.renderer.max_texture_size"
pub const SDL_PROP_RENDERER_TEXTURE_FORMATS_POINTER = "SDL.renderer.texture_formats"
pub const SDL_PROP_RENDERER_OUTPUT_COLORSPACE_NUMBER = "SDL.renderer.output_colorspace"
pub const SDL_PROP_RENDERER_HDR_ENABLED_BOOLEAN = "SDL.renderer.HDR_enabled"
pub const SDL_PROP_RENDERER_SDR_WHITE_POINT_FLOAT = "SDL.renderer.SDR_white_point"
pub const SDL_PROP_RENDERER_HDR_HEADROOM_FLOAT = "SDL.renderer.HDR_headroom"
pub const SDL_PROP_RENDERER_D3D9_DEVICE_POINTER = "SDL.renderer.d3d9.device"
pub const SDL_PROP_RENDERER_D3D11_DEVICE_POINTER = "SDL.renderer.d3d11.device"
pub const SDL_PROP_RENDERER_D3D11_SWAPCHAIN_POINTER = "SDL.renderer.d3d11.swap_chain"
pub const SDL_PROP_RENDERER_D3D12_DEVICE_POINTER = "SDL.renderer.d3d12.device"
pub const SDL_PROP_RENDERER_D3D12_SWAPCHAIN_POINTER = "SDL.renderer.d3d12.swap_chain"
pub const SDL_PROP_RENDERER_D3D12_COMMAND_QUEUE_POINTER = "SDL.renderer.d3d12.command_queue"
pub const SDL_PROP_RENDERER_VULKAN_INSTANCE_POINTER = "SDL.renderer.vulkan.instance"
pub const SDL_PROP_RENDERER_VULKAN_SURFACE_NUMBER = "SDL.renderer.vulkan.surface"
pub const SDL_PROP_RENDERER_VULKAN_PHYSICAL_DEVICE_POINTER = "SDL.renderer.vulkan.physical_device"
pub const SDL_PROP_RENDERER_VULKAN_DEVICE_POINTER = "SDL.renderer.vulkan.device"
pub const SDL_PROP_RENDERER_VULKAN_GRAPHICS_QUEUE_FAMILY_INDEX_NUMBER = "SDL.renderer.vulkan.graphics_queue_family_index"
pub const SDL_PROP_RENDERER_VULKAN_PRESENT_QUEUE_FAMILY_INDEX_NUMBER = "SDL.renderer.vulkan.present_queue_family_index"
pub const SDL_PROP_RENDERER_VULKAN_SWAPCHAIN_IMAGE_COUNT_NUMBER = "SDL.renderer.vulkan.swapchain_image_count"
pub const SDL_PROP_RENDERER_GPU_DEVICE_POINTER = "SDL.renderer.gpu.device"

///| Get the output size in pixels of a rendering context.
///
/// This returns the true output size in pixels, ignoring any render targets or
/// logical size and presentation.
///
/// For the output size of the current rendering target, with logical size
/// adjustments, use SDL_GetCurrentRenderOutputSize() instead.
///
/// @param renderer the rendering context.
/// @param w a pointer filled in with the width in pixels.
/// @param h a pointer filled in with the height in pixels.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetCurrentRenderOutputSize
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRenderOutputSize(SDL_Renderer *renderer, int *w, int *h);
/// ```
pub extern "C" fn sdl_GetRenderOutputSize(renderer: SDL_Renderer, w: FixedArray[Int], h: FixedArray[Int]) -> Bool = "SDL_GetRenderOutputSize"

///| Get the current output size in pixels of a rendering context.
///
/// If a rendering target is active, this will return the size of the rendering
/// target in pixels, otherwise return the value of SDL_GetRenderOutputSize().
///
/// Rendering target or not, the output will be adjusted by the current logical
/// presentation state, dictated by SDL_SetRenderLogicalPresentation().
///
/// @param renderer the rendering context.
/// @param w a pointer filled in with the current width.
/// @param h a pointer filled in with the current height.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetRenderOutputSize
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetCurrentRenderOutputSize(SDL_Renderer *renderer, int *w, int *h);
/// ```
pub extern "C" fn sdl_GetCurrentRenderOutputSize(renderer: SDL_Renderer, w: FixedArray[Int], h: FixedArray[Int]) -> Bool = "SDL_GetCurrentRenderOutputSize"

///| Create a texture for a rendering context.
///
/// The contents of a texture when first created are not defined.
///
/// @param renderer the rendering context.
/// @param format one of the enumerated values in SDL_PixelFormat.
/// @param access one of the enumerated values in SDL_TextureAccess.
/// @param w the width of the texture in pixels.
/// @param h the height of the texture in pixels.
/// @return the created texture or NULL on failure; call SDL_GetError() for
///          more information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_CreateTextureFromSurface
/// @see SDL_CreateTextureWithProperties
/// @see SDL_DestroyTexture
/// @see SDL_GetTextureSize
/// @see SDL_UpdateTexture
///
/// ```c
/// extern SDL_DECLSPEC SDL_Texture * SDLCALL SDL_CreateTexture(SDL_Renderer *renderer, SDL_PixelFormat format, SDL_TextureAccess access, int w, int h);
/// ```
pub extern "C" fn sdl_CreateTexture(renderer: SDL_Renderer, format: SDL_PixelFormat, access: SDL_TextureAccess, w: Int, h: Int) -> SDL_Texture = "SDL_CreateTexture"

///| Create a texture from an existing surface.
///
/// The surface is not modified or freed by this function.
///
/// The SDL_TextureAccess hint for the created texture is
/// `SDL_TEXTUREACCESS_STATIC`.
///
/// The pixel format of the created texture may be different from the pixel
/// format of the surface, and can be queried using the
/// SDL_PROP_TEXTURE_FORMAT_NUMBER property.
///
/// @param renderer the rendering context.
/// @param surface the SDL_Surface structure containing pixel data used to fill
///                the texture.
/// @return the created texture or NULL on failure; call SDL_GetError() for
///          more information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_CreateTexture
/// @see SDL_CreateTextureWithProperties
/// @see SDL_DestroyTexture
///
/// ```c
/// extern SDL_DECLSPEC SDL_Texture * SDLCALL SDL_CreateTextureFromSurface(SDL_Renderer *renderer, SDL_Surface *surface);
/// ```
pub extern "C" fn sdl_CreateTextureFromSurface(renderer: SDL_Renderer, surface: SDL_Surface) -> SDL_Texture = "SDL_CreateTextureFromSurface"

///| Create a texture for a rendering context with the specified properties.
///
/// These are the supported properties:
///
/// - `SDL_PROP_TEXTURE_CREATE_COLORSPACE_NUMBER`: an SDL_Colorspace value
///   describing the texture colorspace, defaults to SDL_COLORSPACE_SRGB_LINEAR
///   for floating point textures, SDL_COLORSPACE_HDR10 for 10-bit textures,
///   SDL_COLORSPACE_SRGB for other RGB textures and SDL_COLORSPACE_JPEG for
///   YUV textures.
/// - `SDL_PROP_TEXTURE_CREATE_FORMAT_NUMBER`: one of the enumerated values in
///   SDL_PixelFormat, defaults to the best RGBA format for the renderer
/// - `SDL_PROP_TEXTURE_CREATE_ACCESS_NUMBER`: one of the enumerated values in
///   SDL_TextureAccess, defaults to SDL_TEXTUREACCESS_STATIC
/// - `SDL_PROP_TEXTURE_CREATE_WIDTH_NUMBER`: the width of the texture in
///   pixels, required
/// - `SDL_PROP_TEXTURE_CREATE_HEIGHT_NUMBER`: the height of the texture in
///   pixels, required
/// - `SDL_PROP_TEXTURE_CREATE_SDR_WHITE_POINT_FLOAT`: for HDR10 and floating
///   point textures, this defines the value of 100% diffuse white, with higher
///   values being displayed in the High Dynamic Range headroom. This defaults
///   to 100 for HDR10 textures and 1.0 for floating point textures.
/// - `SDL_PROP_TEXTURE_CREATE_HDR_HEADROOM_FLOAT`: for HDR10 and floating
///   point textures, this defines the maximum dynamic range used by the
///   content, in terms of the SDR white point. This would be equivalent to
///   maxCLL / SDL_PROP_TEXTURE_CREATE_SDR_WHITE_POINT_FLOAT for HDR10 content.
///   If this is defined, any values outside the range supported by the display
///   will be scaled into the available HDR headroom, otherwise they are
///   clipped.
///
/// With the direct3d11 renderer:
///
/// - `SDL_PROP_TEXTURE_CREATE_D3D11_TEXTURE_POINTER`: the ID3D11Texture2D
///   associated with the texture, if you want to wrap an existing texture.
/// - `SDL_PROP_TEXTURE_CREATE_D3D11_TEXTURE_U_POINTER`: the ID3D11Texture2D
///   associated with the U plane of a YUV texture, if you want to wrap an
///   existing texture.
/// - `SDL_PROP_TEXTURE_CREATE_D3D11_TEXTURE_V_POINTER`: the ID3D11Texture2D
///   associated with the V plane of a YUV texture, if you want to wrap an
///   existing texture.
///
/// With the direct3d12 renderer:
///
/// - `SDL_PROP_TEXTURE_CREATE_D3D12_TEXTURE_POINTER`: the ID3D12Resource
///   associated with the texture, if you want to wrap an existing texture.
/// - `SDL_PROP_TEXTURE_CREATE_D3D12_TEXTURE_U_POINTER`: the ID3D12Resource
///   associated with the U plane of a YUV texture, if you want to wrap an
///   existing texture.
/// - `SDL_PROP_TEXTURE_CREATE_D3D12_TEXTURE_V_POINTER`: the ID3D12Resource
///   associated with the V plane of a YUV texture, if you want to wrap an
///   existing texture.
///
/// With the metal renderer:
///
/// - `SDL_PROP_TEXTURE_CREATE_METAL_PIXELBUFFER_POINTER`: the CVPixelBufferRef
///   associated with the texture, if you want to create a texture from an
///   existing pixel buffer.
///
/// With the opengl renderer:
///
/// - `SDL_PROP_TEXTURE_CREATE_OPENGL_TEXTURE_NUMBER`: the GLuint texture
///   associated with the texture, if you want to wrap an existing texture.
/// - `SDL_PROP_TEXTURE_CREATE_OPENGL_TEXTURE_UV_NUMBER`: the GLuint texture
///   associated with the UV plane of an NV12 texture, if you want to wrap an
///   existing texture.
/// - `SDL_PROP_TEXTURE_CREATE_OPENGL_TEXTURE_U_NUMBER`: the GLuint texture
///   associated with the U plane of a YUV texture, if you want to wrap an
///   existing texture.
/// - `SDL_PROP_TEXTURE_CREATE_OPENGL_TEXTURE_V_NUMBER`: the GLuint texture
///   associated with the V plane of a YUV texture, if you want to wrap an
///   existing texture.
///
/// With the opengles2 renderer:
///
/// - `SDL_PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_NUMBER`: the GLuint texture
///   associated with the texture, if you want to wrap an existing texture.
/// - `SDL_PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_NUMBER`: the GLuint texture
///   associated with the texture, if you want to wrap an existing texture.
/// - `SDL_PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_UV_NUMBER`: the GLuint texture
///   associated with the UV plane of an NV12 texture, if you want to wrap an
///   existing texture.
/// - `SDL_PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_U_NUMBER`: the GLuint texture
///   associated with the U plane of a YUV texture, if you want to wrap an
///   existing texture.
/// - `SDL_PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_V_NUMBER`: the GLuint texture
///   associated with the V plane of a YUV texture, if you want to wrap an
///   existing texture.
///
/// With the vulkan renderer:
///
/// - `SDL_PROP_TEXTURE_CREATE_VULKAN_TEXTURE_NUMBER`: the VkImage with layout
///   VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL associated with the texture, if
///   you want to wrap an existing texture.
///
/// @param renderer the rendering context.
/// @param props the properties to use.
/// @return the created texture or NULL on failure; call SDL_GetError() for
///          more information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_CreateProperties
/// @see SDL_CreateTexture
/// @see SDL_CreateTextureFromSurface
/// @see SDL_DestroyTexture
/// @see SDL_GetTextureSize
/// @see SDL_UpdateTexture
///
/// ```c
/// extern SDL_DECLSPEC SDL_Texture * SDLCALL SDL_CreateTextureWithProperties(SDL_Renderer *renderer, SDL_PropertiesID props);
/// ```
pub extern "C" fn sdl_CreateTextureWithProperties(renderer: SDL_Renderer, props: SDL_PropertiesID) -> SDL_Texture = "SDL_CreateTextureWithProperties"

pub const SDL_PROP_TEXTURE_CREATE_COLORSPACE_NUMBER = "SDL.texture.create.colorspace"
pub const SDL_PROP_TEXTURE_CREATE_FORMAT_NUMBER = "SDL.texture.create.format"
pub const SDL_PROP_TEXTURE_CREATE_ACCESS_NUMBER = "SDL.texture.create.access"
pub const SDL_PROP_TEXTURE_CREATE_WIDTH_NUMBER = "SDL.texture.create.width"
pub const SDL_PROP_TEXTURE_CREATE_HEIGHT_NUMBER = "SDL.texture.create.height"
pub const SDL_PROP_TEXTURE_CREATE_SDR_WHITE_POINT_FLOAT = "SDL.texture.create.SDR_white_point"
pub const SDL_PROP_TEXTURE_CREATE_HDR_HEADROOM_FLOAT = "SDL.texture.create.HDR_headroom"
pub const SDL_PROP_TEXTURE_CREATE_D3D11_TEXTURE_POINTER = "SDL.texture.create.d3d11.texture"
pub const SDL_PROP_TEXTURE_CREATE_D3D11_TEXTURE_U_POINTER = "SDL.texture.create.d3d11.texture_u"
pub const SDL_PROP_TEXTURE_CREATE_D3D11_TEXTURE_V_POINTER = "SDL.texture.create.d3d11.texture_v"
pub const SDL_PROP_TEXTURE_CREATE_D3D12_TEXTURE_POINTER = "SDL.texture.create.d3d12.texture"
pub const SDL_PROP_TEXTURE_CREATE_D3D12_TEXTURE_U_POINTER = "SDL.texture.create.d3d12.texture_u"
pub const SDL_PROP_TEXTURE_CREATE_D3D12_TEXTURE_V_POINTER = "SDL.texture.create.d3d12.texture_v"
pub const SDL_PROP_TEXTURE_CREATE_METAL_PIXELBUFFER_POINTER = "SDL.texture.create.metal.pixelbuffer"
pub const SDL_PROP_TEXTURE_CREATE_OPENGL_TEXTURE_NUMBER = "SDL.texture.create.opengl.texture"
pub const SDL_PROP_TEXTURE_CREATE_OPENGL_TEXTURE_UV_NUMBER = "SDL.texture.create.opengl.texture_uv"
pub const SDL_PROP_TEXTURE_CREATE_OPENGL_TEXTURE_U_NUMBER = "SDL.texture.create.opengl.texture_u"
pub const SDL_PROP_TEXTURE_CREATE_OPENGL_TEXTURE_V_NUMBER = "SDL.texture.create.opengl.texture_v"
pub const SDL_PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_NUMBER = "SDL.texture.create.opengles2.texture"
pub const SDL_PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_UV_NUMBER = "SDL.texture.create.opengles2.texture_uv"
pub const SDL_PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_U_NUMBER = "SDL.texture.create.opengles2.texture_u"
pub const SDL_PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_V_NUMBER = "SDL.texture.create.opengles2.texture_v"
pub const SDL_PROP_TEXTURE_CREATE_VULKAN_TEXTURE_NUMBER = "SDL.texture.create.vulkan.texture"

///| Get the properties associated with a texture.
///
/// The following read-only properties are provided by SDL:
///
/// - `SDL_PROP_TEXTURE_COLORSPACE_NUMBER`: an SDL_Colorspace value describing
///   the texture colorspace.
/// - `SDL_PROP_TEXTURE_FORMAT_NUMBER`: one of the enumerated values in
///   SDL_PixelFormat.
/// - `SDL_PROP_TEXTURE_ACCESS_NUMBER`: one of the enumerated values in
///   SDL_TextureAccess.
/// - `SDL_PROP_TEXTURE_WIDTH_NUMBER`: the width of the texture in pixels.
/// - `SDL_PROP_TEXTURE_HEIGHT_NUMBER`: the height of the texture in pixels.
/// - `SDL_PROP_TEXTURE_SDR_WHITE_POINT_FLOAT`: for HDR10 and floating point
///   textures, this defines the value of 100% diffuse white, with higher
///   values being displayed in the High Dynamic Range headroom. This defaults
///   to 100 for HDR10 textures and 1.0 for other textures.
/// - `SDL_PROP_TEXTURE_HDR_HEADROOM_FLOAT`: for HDR10 and floating point
///   textures, this defines the maximum dynamic range used by the content, in
///   terms of the SDR white point. If this is defined, any values outside the
///   range supported by the display will be scaled into the available HDR
///   headroom, otherwise they are clipped. This defaults to 1.0 for SDR
///   textures, 4.0 for HDR10 textures, and no default for floating point
///   textures.
///
/// With the direct3d11 renderer:
///
/// - `SDL_PROP_TEXTURE_D3D11_TEXTURE_POINTER`: the ID3D11Texture2D associated
///   with the texture
/// - `SDL_PROP_TEXTURE_D3D11_TEXTURE_U_POINTER`: the ID3D11Texture2D
///   associated with the U plane of a YUV texture
/// - `SDL_PROP_TEXTURE_D3D11_TEXTURE_V_POINTER`: the ID3D11Texture2D
///   associated with the V plane of a YUV texture
///
/// With the direct3d12 renderer:
///
/// - `SDL_PROP_TEXTURE_D3D12_TEXTURE_POINTER`: the ID3D12Resource associated
///   with the texture
/// - `SDL_PROP_TEXTURE_D3D12_TEXTURE_U_POINTER`: the ID3D12Resource associated
///   with the U plane of a YUV texture
/// - `SDL_PROP_TEXTURE_D3D12_TEXTURE_V_POINTER`: the ID3D12Resource associated
///   with the V plane of a YUV texture
///
/// With the vulkan renderer:
///
/// - `SDL_PROP_TEXTURE_VULKAN_TEXTURE_NUMBER`: the VkImage associated with the
///   texture
///
/// With the opengl renderer:
///
/// - `SDL_PROP_TEXTURE_OPENGL_TEXTURE_NUMBER`: the GLuint texture associated
///   with the texture
/// - `SDL_PROP_TEXTURE_OPENGL_TEXTURE_UV_NUMBER`: the GLuint texture
///   associated with the UV plane of an NV12 texture
/// - `SDL_PROP_TEXTURE_OPENGL_TEXTURE_U_NUMBER`: the GLuint texture associated
///   with the U plane of a YUV texture
/// - `SDL_PROP_TEXTURE_OPENGL_TEXTURE_V_NUMBER`: the GLuint texture associated
///   with the V plane of a YUV texture
/// - `SDL_PROP_TEXTURE_OPENGL_TEXTURE_TARGET_NUMBER`: the GLenum for the
///   texture target (`GL_TEXTURE_2D`, `GL_TEXTURE_RECTANGLE_ARB`, etc)
/// - `SDL_PROP_TEXTURE_OPENGL_TEX_W_FLOAT`: the texture coordinate width of
///   the texture (0.0 - 1.0)
/// - `SDL_PROP_TEXTURE_OPENGL_TEX_H_FLOAT`: the texture coordinate height of
///   the texture (0.0 - 1.0)
///
/// With the opengles2 renderer:
///
/// - `SDL_PROP_TEXTURE_OPENGLES2_TEXTURE_NUMBER`: the GLuint texture
///   associated with the texture
/// - `SDL_PROP_TEXTURE_OPENGLES2_TEXTURE_UV_NUMBER`: the GLuint texture
///   associated with the UV plane of an NV12 texture
/// - `SDL_PROP_TEXTURE_OPENGLES2_TEXTURE_U_NUMBER`: the GLuint texture
///   associated with the U plane of a YUV texture
/// - `SDL_PROP_TEXTURE_OPENGLES2_TEXTURE_V_NUMBER`: the GLuint texture
///   associated with the V plane of a YUV texture
/// - `SDL_PROP_TEXTURE_OPENGLES2_TEXTURE_TARGET_NUMBER`: the GLenum for the
///   texture target (`GL_TEXTURE_2D`, `GL_TEXTURE_EXTERNAL_OES`, etc)
///
/// @param texture the texture to query.
/// @return a valid property ID on success or 0 on failure; call
///          SDL_GetError() for more information.
///
/// @threadsafety It is safe to call this function from any thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_PropertiesID SDLCALL SDL_GetTextureProperties(SDL_Texture *texture);
/// ```
pub extern "C" fn sdl_GetTextureProperties(texture: SDL_Texture) -> SDL_PropertiesID = "SDL_GetTextureProperties"

pub const SDL_PROP_TEXTURE_COLORSPACE_NUMBER = "SDL.texture.colorspace"
pub const SDL_PROP_TEXTURE_FORMAT_NUMBER = "SDL.texture.format"
pub const SDL_PROP_TEXTURE_ACCESS_NUMBER = "SDL.texture.access"
pub const SDL_PROP_TEXTURE_WIDTH_NUMBER = "SDL.texture.width"
pub const SDL_PROP_TEXTURE_HEIGHT_NUMBER = "SDL.texture.height"
pub const SDL_PROP_TEXTURE_SDR_WHITE_POINT_FLOAT = "SDL.texture.SDR_white_point"
pub const SDL_PROP_TEXTURE_HDR_HEADROOM_FLOAT = "SDL.texture.HDR_headroom"
pub const SDL_PROP_TEXTURE_D3D11_TEXTURE_POINTER = "SDL.texture.d3d11.texture"
pub const SDL_PROP_TEXTURE_D3D11_TEXTURE_U_POINTER = "SDL.texture.d3d11.texture_u"
pub const SDL_PROP_TEXTURE_D3D11_TEXTURE_V_POINTER = "SDL.texture.d3d11.texture_v"
pub const SDL_PROP_TEXTURE_D3D12_TEXTURE_POINTER = "SDL.texture.d3d12.texture"
pub const SDL_PROP_TEXTURE_D3D12_TEXTURE_U_POINTER = "SDL.texture.d3d12.texture_u"
pub const SDL_PROP_TEXTURE_D3D12_TEXTURE_V_POINTER = "SDL.texture.d3d12.texture_v"
pub const SDL_PROP_TEXTURE_OPENGL_TEXTURE_NUMBER = "SDL.texture.opengl.texture"
pub const SDL_PROP_TEXTURE_OPENGL_TEXTURE_UV_NUMBER = "SDL.texture.opengl.texture_uv"
pub const SDL_PROP_TEXTURE_OPENGL_TEXTURE_U_NUMBER = "SDL.texture.opengl.texture_u"
pub const SDL_PROP_TEXTURE_OPENGL_TEXTURE_V_NUMBER = "SDL.texture.opengl.texture_v"
pub const SDL_PROP_TEXTURE_OPENGL_TEXTURE_TARGET_NUMBER = "SDL.texture.opengl.target"
pub const SDL_PROP_TEXTURE_OPENGL_TEX_W_FLOAT = "SDL.texture.opengl.tex_w"
pub const SDL_PROP_TEXTURE_OPENGL_TEX_H_FLOAT = "SDL.texture.opengl.tex_h"
pub const SDL_PROP_TEXTURE_OPENGLES2_TEXTURE_NUMBER = "SDL.texture.opengles2.texture"
pub const SDL_PROP_TEXTURE_OPENGLES2_TEXTURE_UV_NUMBER = "SDL.texture.opengles2.texture_uv"
pub const SDL_PROP_TEXTURE_OPENGLES2_TEXTURE_U_NUMBER = "SDL.texture.opengles2.texture_u"
pub const SDL_PROP_TEXTURE_OPENGLES2_TEXTURE_V_NUMBER = "SDL.texture.opengles2.texture_v"
pub const SDL_PROP_TEXTURE_OPENGLES2_TEXTURE_TARGET_NUMBER = "SDL.texture.opengles2.target"
pub const SDL_PROP_TEXTURE_VULKAN_TEXTURE_NUMBER = "SDL.texture.vulkan.texture"

///| Get the renderer that created an SDL_Texture.
///
/// @param texture the texture to query.
/// @return a pointer to the SDL_Renderer that created the texture, or NULL on
///          failure; call SDL_GetError() for more information.
///
/// @threadsafety It is safe to call this function from any thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// ```c
/// extern SDL_DECLSPEC SDL_Renderer * SDLCALL SDL_GetRendererFromTexture(SDL_Texture *texture);
/// ```
pub extern "C" fn sdl_GetRendererFromTexture(texture: SDL_Texture) -> SDL_Renderer = "SDL_GetRendererFromTexture"

///| Get the size of a texture, as floating point values.
///
/// @param texture the texture to query.
/// @param w a pointer filled in with the width of the texture in pixels. This
///          argument can be NULL if you don't need this information.
/// @param h a pointer filled in with the height of the texture in pixels. This
///          argument can be NULL if you don't need this information.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetTextureSize(SDL_Texture *texture, float *w, float *h);
/// ```
pub extern "C" fn sdl_GetTextureSize(texture: SDL_Texture, w: FixedArray[Float], h: FixedArray[Float]) -> Bool = "SDL_GetTextureSize"

///| Set an additional color value multiplied into render copy operations.
///
/// When this texture is rendered, during the copy operation each source color
/// channel is modulated by the appropriate color value according to the
/// following formula:
///
/// `srcC = srcC * (color / 255)`
///
/// Color modulation is not always supported by the renderer; it will return
/// false if color modulation is not supported.
///
/// @param texture the texture to update.
/// @param r the red color value multiplied into copy operations.
/// @param g the green color value multiplied into copy operations.
/// @param b the blue color value multiplied into copy operations.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetTextureColorMod
/// @see SDL_SetTextureAlphaMod
/// @see SDL_SetTextureColorModFloat
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetTextureColorMod(SDL_Texture *texture, Uint8 r, Uint8 g, Uint8 b);
/// ```
pub extern "C" fn sdl_SetTextureColorMod(texture: SDL_Texture, r: Byte, g: Byte, b: Byte) -> Bool = "SDL_SetTextureColorMod"

///| Set an additional color value multiplied into render copy operations.
///
/// When this texture is rendered, during the copy operation each source color
/// channel is modulated by the appropriate color value according to the
/// following formula:
///
/// `srcC = srcC * color`
///
/// Color modulation is not always supported by the renderer; it will return
/// false if color modulation is not supported.
///
/// @param texture the texture to update.
/// @param r the red color value multiplied into copy operations.
/// @param g the green color value multiplied into copy operations.
/// @param b the blue color value multiplied into copy operations.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetTextureColorModFloat
/// @see SDL_SetTextureAlphaModFloat
/// @see SDL_SetTextureColorMod
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetTextureColorModFloat(SDL_Texture *texture, float r, float g, float b);
/// ```
pub extern "C" fn sdl_SetTextureColorModFloat(texture: SDL_Texture, r: Float, g: Float, b: Float) -> Bool = "SDL_SetTextureColorModFloat"

///| Get the additional color value multiplied into render copy operations.
///
/// @param texture the texture to query.
/// @param r a pointer filled in with the current red color value.
/// @param g a pointer filled in with the current green color value.
/// @param b a pointer filled in with the current blue color value.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetTextureAlphaMod
/// @see SDL_GetTextureColorModFloat
/// @see SDL_SetTextureColorMod
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetTextureColorMod(SDL_Texture *texture, Uint8 *r, Uint8 *g, Uint8 *b);
/// ```
pub extern "C" fn sdl_GetTextureColorMod(texture: SDL_Texture, r: Bytes, g: Bytes, b: Bytes) -> Bool = "SDL_GetTextureColorMod"

///| Get the additional color value multiplied into render copy operations.
///
/// @param texture the texture to query.
/// @param r a pointer filled in with the current red color value.
/// @param g a pointer filled in with the current green color value.
/// @param b a pointer filled in with the current blue color value.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetTextureAlphaModFloat
/// @see SDL_GetTextureColorMod
/// @see SDL_SetTextureColorModFloat
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetTextureColorModFloat(SDL_Texture *texture, float *r, float *g, float *b);
/// ```
pub extern "C" fn sdl_GetTextureColorModFloat(texture: SDL_Texture, r: FixedArray[Float], g: FixedArray[Float], b: FixedArray[Float]) -> Bool = "SDL_GetTextureColorModFloat"

///| Set an additional alpha value multiplied into render copy operations.
///
/// When this texture is rendered, during the copy operation the source alpha
/// value is modulated by this alpha value according to the following formula:
///
/// `srcA = srcA * (alpha / 255)`
///
/// Alpha modulation is not always supported by the renderer; it will return
/// false if alpha modulation is not supported.
///
/// @param texture the texture to update.
/// @param alpha the source alpha value multiplied into copy operations.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetTextureAlphaMod
/// @see SDL_SetTextureAlphaModFloat
/// @see SDL_SetTextureColorMod
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetTextureAlphaMod(SDL_Texture *texture, Uint8 alpha);
/// ```
pub extern "C" fn sdl_SetTextureAlphaMod(texture: SDL_Texture, alpha: Byte) -> Bool = "SDL_SetTextureAlphaMod"

///| Set an additional alpha value multiplied into render copy operations.
///
/// When this texture is rendered, during the copy operation the source alpha
/// value is modulated by this alpha value according to the following formula:
///
/// `srcA = srcA * alpha`
///
/// Alpha modulation is not always supported by the renderer; it will return
/// false if alpha modulation is not supported.
///
/// @param texture the texture to update.
/// @param alpha the source alpha value multiplied into copy operations.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetTextureAlphaModFloat
/// @see SDL_SetTextureAlphaMod
/// @see SDL_SetTextureColorModFloat
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetTextureAlphaModFloat(SDL_Texture *texture, float alpha);
/// ```
pub extern "C" fn sdl_SetTextureAlphaModFloat(texture: SDL_Texture, alpha: Float) -> Bool = "SDL_SetTextureAlphaModFloat"

///| Get the additional alpha value multiplied into render copy operations.
///
/// @param texture the texture to query.
/// @param alpha a pointer filled in with the current alpha value.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetTextureAlphaModFloat
/// @see SDL_GetTextureColorMod
/// @see SDL_SetTextureAlphaMod
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetTextureAlphaMod(SDL_Texture *texture, Uint8 *alpha);
/// ```
pub extern "C" fn sdl_GetTextureAlphaMod(texture: SDL_Texture, alpha: Bytes) -> Bool = "SDL_GetTextureAlphaMod"

///| Get the additional alpha value multiplied into render copy operations.
///
/// @param texture the texture to query.
/// @param alpha a pointer filled in with the current alpha value.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetTextureAlphaMod
/// @see SDL_GetTextureColorModFloat
/// @see SDL_SetTextureAlphaModFloat
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetTextureAlphaModFloat(SDL_Texture *texture, float *alpha);
/// ```
pub extern "C" fn sdl_GetTextureAlphaModFloat(texture: SDL_Texture, alpha: FixedArray[Float]) -> Bool = "SDL_GetTextureAlphaModFloat"

///| Set the blend mode for a texture, used by SDL_RenderTexture().
///
/// If the blend mode is not supported, the closest supported mode is chosen
/// and this function returns false.
///
/// @param texture the texture to update.
/// @param blendMode the SDL_BlendMode to use for texture blending.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetTextureBlendMode
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetTextureBlendMode(SDL_Texture *texture, SDL_BlendMode blendMode);
/// ```
pub extern "C" fn sdl_SetTextureBlendMode(texture: SDL_Texture, blendMode: SDL_BlendMode) -> Bool = "SDL_SetTextureBlendMode"

///| Get the blend mode used for texture copy operations.
///
/// @param texture the texture to query.
/// @param blendMode a pointer filled in with the current SDL_BlendMode.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_SetTextureBlendMode
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetTextureBlendMode(SDL_Texture *texture, SDL_BlendMode *blendMode);
/// ```
pub extern "C" fn sdl_GetTextureBlendMode(texture: SDL_Texture, blendMode: FixedArray[SDL_BlendMode]) -> Bool = "SDL_GetTextureBlendMode"

///| Set the scale mode used for texture scale operations.
///
/// The default texture scale mode is SDL_SCALEMODE_LINEAR.
///
/// If the scale mode is not supported, the closest supported mode is chosen.
///
/// @param texture the texture to update.
/// @param scaleMode the SDL_ScaleMode to use for texture scaling.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetTextureScaleMode
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetTextureScaleMode(SDL_Texture *texture, SDL_ScaleMode scaleMode);
/// ```
pub extern "C" fn sdl_SetTextureScaleMode(texture: SDL_Texture, scaleMode: SDL_ScaleMode) -> Bool = "SDL_SetTextureScaleMode"

///| Get the scale mode used for texture scale operations.
///
/// @param texture the texture to query.
/// @param scaleMode a pointer filled in with the current scale mode.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_SetTextureScaleMode
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetTextureScaleMode(SDL_Texture *texture, SDL_ScaleMode *scaleMode);
/// ```
pub extern "C" fn sdl_GetTextureScaleMode(texture: SDL_Texture, scaleMode: FixedArray[SDL_ScaleMode]) -> Bool = "SDL_GetTextureScaleMode"

///| Update the given texture rectangle with new pixel data.
///
/// The pixel data must be in the pixel format of the texture, which can be
/// queried using the SDL_PROP_TEXTURE_FORMAT_NUMBER property.
///
/// This is a fairly slow function, intended for use with static textures that
/// do not change often.
///
/// If the texture is intended to be updated often, it is preferred to create
/// the texture as streaming and use the locking functions referenced below.
/// While this function will work with streaming textures, for optimization
/// reasons you may not get the pixels back if you lock the texture afterward.
///
/// @param texture the texture to update.
/// @param rect an SDL_Rect structure representing the area to update, or NULL
///             to update the entire texture.
/// @param pixels the raw pixel data in the format of the texture.
/// @param pitch the number of bytes in a row of pixel data, including padding
///              between lines.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_LockTexture
/// @see SDL_UnlockTexture
/// @see SDL_UpdateNVTexture
/// @see SDL_UpdateYUVTexture
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_UpdateTexture(SDL_Texture *texture, const SDL_Rect *rect, const void *pixels, int pitch);
/// ```
pub extern "C" fn sdl_UpdateTexture(texture: SDL_Texture, rect: SDL_Rect, pixels: VoidPtr, pitch: Int) -> Bool = "SDL_UpdateTexture"

///| Update a rectangle within a planar YV12 or IYUV texture with new pixel
///| data.
///
/// You can use SDL_UpdateTexture() as long as your pixel data is a contiguous
/// block of Y and U/V planes in the proper order, but this function is
/// available if your pixel data is not contiguous.
///
/// @param texture the texture to update.
/// @param rect a pointer to the rectangle of pixels to update, or NULL to
///             update the entire texture.
/// @param Yplane the raw pixel data for the Y plane.
/// @param Ypitch the number of bytes between rows of pixel data for the Y
///               plane.
/// @param Uplane the raw pixel data for the U plane.
/// @param Upitch the number of bytes between rows of pixel data for the U
///               plane.
/// @param Vplane the raw pixel data for the V plane.
/// @param Vpitch the number of bytes between rows of pixel data for the V
///               plane.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_UpdateNVTexture
/// @see SDL_UpdateTexture
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_UpdateYUVTexture(SDL_Texture *texture,
///                                                 const SDL_Rect *rect,
///                                                 const Uint8 *Yplane, int Ypitch,
///                                                 const Uint8 *Uplane, int Upitch,
///                                                 const Uint8 *Vplane, int Vpitch);
/// ```
pub extern "C" fn sdl_UpdateYUVTexture(texture: SDL_Texture, rect: SDL_Rect, yplane: FixedArray[Byte], ypitch: Int, uplane: FixedArray[Byte], upitch: Int, vplane: FixedArray[Byte], vpitch: Int) -> Bool = "SDL_UpdateYUVTexture"

///| Update a rectangle within a planar NV12 or NV21 texture with new pixels.
///
/// You can use SDL_UpdateTexture() as long as your pixel data is a contiguous
/// block of NV12/21 planes in the proper order, but this function is available
/// if your pixel data is not contiguous.
///
/// @param texture the texture to update.
/// @param rect a pointer to the rectangle of pixels to update, or NULL to
///             update the entire texture.
/// @param Yplane the raw pixel data for the Y plane.
/// @param Ypitch the number of bytes between rows of pixel data for the Y
///               plane.
/// @param UVplane the raw pixel data for the UV plane.
/// @param UVpitch the number of bytes between rows of pixel data for the UV
///                plane.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_UpdateTexture
/// @see SDL_UpdateYUVTexture
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_UpdateNVTexture(SDL_Texture *texture,
///                                                 const SDL_Rect *rect,
///                                                 const Uint8 *Yplane, int Ypitch,
///                                                 const Uint8 *UVplane, int UVpitch);
/// ```
pub extern "C" fn sdl_UpdateNVTexture(texture: SDL_Texture, rect: SDL_Rect, yplane: FixedArray[Byte], ypitch: Int, uVplane: FixedArray[Byte], uVpitch: Int) -> Bool = "SDL_UpdateNVTexture"

///| Lock a portion of the texture for **write-only** pixel access.
///
/// As an optimization, the pixels made available for editing don't necessarily
/// contain the old texture data. This is a write-only operation, and if you
/// need to keep a copy of the texture data you should do that at the
/// application level.
///
/// You must use SDL_UnlockTexture() to unlock the pixels and apply any
/// changes.
///
/// @param texture the texture to lock for access, which was created with
///                `SDL_TEXTUREACCESS_STREAMING`.
/// @param rect an SDL_Rect structure representing the area to lock for access;
///             NULL to lock the entire texture.
/// @param pixels this is filled in with a pointer to the locked pixels,
///               appropriately offset by the locked area.
/// @param pitch this is filled in with the pitch of the locked pixels; the
///              pitch is the length of one row in bytes.
/// @return true on success or false if the texture is not valid or was not
///          created with `SDL_TEXTUREACCESS_STREAMING`; call SDL_GetError()
///          for more information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_LockTextureToSurface
/// @see SDL_UnlockTexture
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_LockTexture(SDL_Texture *texture,
///                                            const SDL_Rect *rect,
///                                            void **pixels, int *pitch);
/// ```
pub extern "C" fn sdl_LockTexture(texture: SDL_Texture, rect: SDL_Rect, pixels: FixedArray[VoidPtr], pitch: FixedArray[Int]) -> Bool = "SDL_LockTexture"

///| Lock a portion of the texture for **write-only** pixel access, and expose
///| it as a SDL surface.
///
/// Besides providing an SDL_Surface instead of raw pixel data, this function
/// operates like SDL_LockTexture.
///
/// As an optimization, the pixels made available for editing don't necessarily
/// contain the old texture data. This is a write-only operation, and if you
/// need to keep a copy of the texture data you should do that at the
/// application level.
///
/// You must use SDL_UnlockTexture() to unlock the pixels and apply any
/// changes.
///
/// The returned surface is freed internally after calling SDL_UnlockTexture()
/// or SDL_DestroyTexture(). The caller should not free it.
///
/// @param texture the texture to lock for access, which must be created with
///                `SDL_TEXTUREACCESS_STREAMING`.
/// @param rect a pointer to the rectangle to lock for access. If the rect is
///             NULL, the entire texture will be locked.
/// @param surface a pointer to an SDL surface of size **rect**. Don't assume
///                any specific pixel content.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_LockTexture
/// @see SDL_UnlockTexture
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_LockTextureToSurface(SDL_Texture *texture, const SDL_Rect *rect, SDL_Surface **surface);
/// ```
pub extern "C" fn sdl_LockTextureToSurface(texture: SDL_Texture, rect: SDL_Rect, surface: FixedArray[SDL_Surface]) -> Bool = "SDL_LockTextureToSurface"

///| Unlock a texture, uploading the changes to video memory, if needed.
///
/// **Warning**: Please note that SDL_LockTexture() is intended to be
/// write-only; it will not guarantee the previous contents of the texture will
/// be provided. You must fully initialize any area of a texture that you lock
/// before unlocking it, as the pixels might otherwise be uninitialized memory.
///
/// Which is to say: locking and immediately unlocking a texture can result in
/// corrupted textures, depending on the renderer in use.
///
/// @param texture a texture locked by SDL_LockTexture().
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_LockTexture
///
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_UnlockTexture(SDL_Texture *texture);
/// ```
pub extern "C" fn sdl_UnlockTexture(texture: SDL_Texture) -> Unit = "SDL_UnlockTexture"

///| Set a texture as the current rendering target.
///
/// The default render target is the window for which the renderer was created.
/// To stop rendering to a texture and render to the window again, call this
/// function with a NULL `texture`.
///
/// Viewport, cliprect, scale, and logical presentation are unique to each
/// render target. Get and set functions for these states apply to the current
/// render target set by this function, and those states persist on each target
/// when the current render target changes.
///
/// @param renderer the rendering context.
/// @param texture the targeted texture, which must be created with the
///                `SDL_TEXTUREACCESS_TARGET` flag, or NULL to render to the
///                window instead of a texture.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetRenderTarget
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetRenderTarget(SDL_Renderer *renderer, SDL_Texture *texture);
/// ```
pub extern "C" fn sdl_SetRenderTarget(renderer: SDL_Renderer, texture: SDL_Texture) -> Bool = "SDL_SetRenderTarget"

///| Get the current render target.
///
/// The default render target is the window for which the renderer was created,
/// and is reported a NULL here.
///
/// @param renderer the rendering context.
/// @return the current render target or NULL for the default render target.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_SetRenderTarget
///
/// ```c
/// extern SDL_DECLSPEC SDL_Texture * SDLCALL SDL_GetRenderTarget(SDL_Renderer *renderer);
/// ```
pub extern "C" fn sdl_GetRenderTarget(renderer: SDL_Renderer) -> SDL_Texture = "SDL_GetRenderTarget"

///| Set a device-independent resolution and presentation mode for rendering.
///
/// This function sets the width and height of the logical rendering output.
/// The renderer will act as if the current render target is always the
/// requested dimensions, scaling to the actual resolution as necessary.
///
/// This can be useful for games that expect a fixed size, but would like to
/// scale the output to whatever is available, regardless of how a user resizes
/// a window, or if the display is high DPI.
///
/// Logical presentation can be used with both render target textures and the
/// renderer's window; the state is unique to each render target, and this
/// function sets the state for the current render target. It might be useful
/// to draw to a texture that matches the window dimensions with logical
/// presentation enabled, and then draw that texture across the entire window
/// with logical presentation disabled. Be careful not to render both with
/// logical presentation enabled, however, as this could produce
/// double-letterboxing, etc.
///
/// You can disable logical coordinates by setting the mode to
/// SDL_LOGICAL_PRESENTATION_DISABLED, and in that case you get the full pixel
/// resolution of the render target; it is safe to toggle logical presentation
/// during the rendering of a frame: perhaps most of the rendering is done to
/// specific dimensions but to make fonts look sharp, the app turns off logical
/// presentation while drawing text, for example.
///
/// For the renderer's window, letterboxing is drawn into the framebuffer if
/// logical presentation is enabled during SDL_RenderPresent; be sure to
/// reenable it before presenting if you were toggling it, otherwise the
/// letterbox areas might have artifacts from previous frames (or artifacts
/// from external overlays, etc). Letterboxing is never drawn into texture
/// render targets; be sure to call SDL_RenderClear() before drawing into the
/// texture so the letterboxing areas are cleared, if appropriate.
///
/// You can convert coordinates in an event into rendering coordinates using
/// SDL_ConvertEventToRenderCoordinates().
///
/// @param renderer the rendering context.
/// @param w the width of the logical resolution.
/// @param h the height of the logical resolution.
/// @param mode the presentation mode used.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_ConvertEventToRenderCoordinates
/// @see SDL_GetRenderLogicalPresentation
/// @see SDL_GetRenderLogicalPresentationRect
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetRenderLogicalPresentation(SDL_Renderer *renderer, int w, int h, SDL_RendererLogicalPresentation mode);
/// ```
pub extern "C" fn sdl_SetRenderLogicalPresentation(renderer: SDL_Renderer, w: Int, h: Int, mode: SDL_RendererLogicalPresentation) -> Bool = "SDL_SetRenderLogicalPresentation"

///| Get device independent resolution and presentation mode for rendering.
///
/// This function gets the width and height of the logical rendering output, or
/// the output size in pixels if a logical resolution is not enabled.
///
/// Each render target has its own logical presentation state. This function
/// gets the state for the current render target.
///
/// @param renderer the rendering context.
/// @param w an int to be filled with the width.
/// @param h an int to be filled with the height.
/// @param mode the presentation mode used.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_SetRenderLogicalPresentation
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRenderLogicalPresentation(SDL_Renderer *renderer, int *w, int *h, SDL_RendererLogicalPresentation *mode);
/// ```
pub extern "C" fn sdl_GetRenderLogicalPresentation(renderer: SDL_Renderer, w: FixedArray[Int], h: FixedArray[Int], mode: FixedArray[SDL_RendererLogicalPresentation]) -> Bool = "SDL_GetRenderLogicalPresentation"

///| Get the final presentation rectangle for rendering.
///
/// This function returns the calculated rectangle used for logical
/// presentation, based on the presentation mode and output size. If logical
/// presentation is disabled, it will fill the rectangle with the output size,
/// in pixels.
///
/// Each render target has its own logical presentation state. This function
/// gets the rectangle for the current render target.
///
/// @param renderer the rendering context.
/// @param rect a pointer filled in with the final presentation rectangle, may
///             be NULL.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_SetRenderLogicalPresentation
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRenderLogicalPresentationRect(SDL_Renderer *renderer, SDL_FRect *rect);
/// ```
pub extern "C" fn sdl_GetRenderLogicalPresentationRect(renderer: SDL_Renderer, rect: SDL_FRect) -> Bool = "SDL_GetRenderLogicalPresentationRect"

///| Get a point in render coordinates when given a point in window coordinates.
///
/// This takes into account several states:
///
/// - The window dimensions.
/// - The logical presentation settings (SDL_SetRenderLogicalPresentation)
/// - The scale (SDL_SetRenderScale)
/// - The viewport (SDL_SetRenderViewport)
///
/// @param renderer the rendering context.
/// @param window_x the x coordinate in window coordinates.
/// @param window_y the y coordinate in window coordinates.
/// @param x a pointer filled with the x coordinate in render coordinates.
/// @param y a pointer filled with the y coordinate in render coordinates.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_SetRenderLogicalPresentation
/// @see SDL_SetRenderScale
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderCoordinatesFromWindow(SDL_Renderer *renderer, float window_x, float window_y, float *x, float *y);
/// ```
pub extern "C" fn sdl_RenderCoordinatesFromWindow(renderer: SDL_Renderer, window_x: Float, window_y: Float, x: FixedArray[Float], y: FixedArray[Float]) -> Bool = "SDL_RenderCoordinatesFromWindow"

///| Get a point in window coordinates when given a point in render coordinates.
///
/// This takes into account several states:
///
/// - The window dimensions.
/// - The logical presentation settings (SDL_SetRenderLogicalPresentation)
/// - The scale (SDL_SetRenderScale)
/// - The viewport (SDL_SetRenderViewport)
///
/// @param renderer the rendering context.
/// @param x the x coordinate in render coordinates.
/// @param y the y coordinate in render coordinates.
/// @param window_x a pointer filled with the x coordinate in window
///                 coordinates.
/// @param window_y a pointer filled with the y coordinate in window
///                 coordinates.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_SetRenderLogicalPresentation
/// @see SDL_SetRenderScale
/// @see SDL_SetRenderViewport
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderCoordinatesToWindow(SDL_Renderer *renderer, float x, float y, float *window_x, float *window_y);
/// ```
pub extern "C" fn sdl_RenderCoordinatesToWindow(renderer: SDL_Renderer, x: Float, y: Float, window_x: FixedArray[Float], window_y: FixedArray[Float]) -> Bool = "SDL_RenderCoordinatesToWindow"

///| Convert the coordinates in an event to render coordinates.
///
/// This takes into account several states:
///
/// - The window dimensions.
/// - The logical presentation settings (SDL_SetRenderLogicalPresentation)
/// - The scale (SDL_SetRenderScale)
/// - The viewport (SDL_SetRenderViewport)
///
/// Various event types are converted with this function: mouse, touch, pen,
/// etc.
///
/// Touch coordinates are converted from normalized coordinates in the window
/// to non-normalized rendering coordinates.
///
/// Relative mouse coordinates (xrel and yrel event fields) are _also_
/// converted. Applications that do not want these fields converted should use
/// SDL_RenderCoordinatesFromWindow() on the specific event fields instead of
/// converting the entire event structure.
///
/// Once converted, coordinates may be outside the rendering area.
///
/// @param renderer the rendering context.
/// @param event the event to modify.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_RenderCoordinatesFromWindow
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_ConvertEventToRenderCoordinates(SDL_Renderer *renderer, SDL_Event *event);
/// ```
pub extern "C" fn sdl_ConvertEventToRenderCoordinates(renderer: SDL_Renderer, event: SDL_Event) -> Bool = "SDL_ConvertEventToRenderCoordinates"

///| Set the drawing area for rendering on the current target.
///
/// Drawing will clip to this area (separately from any clipping done with
/// SDL_SetRenderClipRect), and the top left of the area will become coordinate
/// (0, 0) for future drawing commands.
///
/// The area's width and height must be >= 0.
///
/// Each render target has its own viewport. This function sets the viewport
/// for the current render target.
///
/// @param renderer the rendering context.
/// @param rect the SDL_Rect structure representing the drawing area, or NULL
///             to set the viewport to the entire target.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetRenderViewport
/// @see SDL_RenderViewportSet
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetRenderViewport(SDL_Renderer *renderer, const SDL_Rect *rect);
/// ```
pub extern "C" fn sdl_SetRenderViewport(renderer: SDL_Renderer, rect: SDL_Rect) -> Bool = "SDL_SetRenderViewport"

///| Get the drawing area for the current target.
///
/// Each render target has its own viewport. This function gets the viewport
/// for the current render target.
///
/// @param renderer the rendering context.
/// @param rect an SDL_Rect structure filled in with the current drawing area.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_RenderViewportSet
/// @see SDL_SetRenderViewport
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRenderViewport(SDL_Renderer *renderer, SDL_Rect *rect);
/// ```
pub extern "C" fn sdl_GetRenderViewport(renderer: SDL_Renderer, rect: SDL_Rect) -> Bool = "SDL_GetRenderViewport"

///| Return whether an explicit rectangle was set as the viewport.
///
/// This is useful if you're saving and restoring the viewport and want to know
/// whether you should restore a specific rectangle or NULL.
///
/// Each render target has its own viewport. This function checks the viewport
/// for the current render target.
///
/// @param renderer the rendering context.
/// @return true if the viewport was set to a specific rectangle, or false if
///          it was set to NULL (the entire target).
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetRenderViewport
/// @see SDL_SetRenderViewport
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderViewportSet(SDL_Renderer *renderer);
/// ```
pub extern "C" fn sdl_RenderViewportSet(renderer: SDL_Renderer) -> Bool = "SDL_RenderViewportSet"

///| Get the safe area for rendering within the current viewport.
///
/// Some devices have portions of the screen which are partially obscured or
/// not interactive, possibly due to on-screen controls, curved edges, camera
/// notches, TV overscan, etc. This function provides the area of the current
/// viewport which is safe to have interactible content. You should continue
/// rendering into the rest of the render target, but it should not contain
/// visually important or interactible content.
///
/// @param renderer the rendering context.
/// @param rect a pointer filled in with the area that is safe for interactive
///             content.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRenderSafeArea(SDL_Renderer *renderer, SDL_Rect *rect);
/// ```
pub extern "C" fn sdl_GetRenderSafeArea(renderer: SDL_Renderer, rect: SDL_Rect) -> Bool = "SDL_GetRenderSafeArea"

///| Set the clip rectangle for rendering on the specified target.
///
/// Each render target has its own clip rectangle. This function sets the
/// cliprect for the current render target.
///
/// @param renderer the rendering context.
/// @param rect an SDL_Rect structure representing the clip area, relative to
///             the viewport, or NULL to disable clipping.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetRenderClipRect
/// @see SDL_RenderClipEnabled
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetRenderClipRect(SDL_Renderer *renderer, const SDL_Rect *rect);
/// ```
pub extern "C" fn sdl_SetRenderClipRect(renderer: SDL_Renderer, rect: SDL_Rect) -> Bool = "SDL_SetRenderClipRect"

///| Get the clip rectangle for the current target.
///
/// Each render target has its own clip rectangle. This function gets the
/// cliprect for the current render target.
///
/// @param renderer the rendering context.
/// @param rect an SDL_Rect structure filled in with the current clipping area
///             or an empty rectangle if clipping is disabled.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_RenderClipEnabled
/// @see SDL_SetRenderClipRect
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRenderClipRect(SDL_Renderer *renderer, SDL_Rect *rect);
/// ```
pub extern "C" fn sdl_GetRenderClipRect(renderer: SDL_Renderer, rect: SDL_Rect) -> Bool = "SDL_GetRenderClipRect"

///| Get whether clipping is enabled on the given render target.
///
/// Each render target has its own clip rectangle. This function checks the
/// cliprect for the current render target.
///
/// @param renderer the rendering context.
/// @return true if clipping is enabled or false if not; call SDL_GetError()
///          for more information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetRenderClipRect
/// @see SDL_SetRenderClipRect
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderClipEnabled(SDL_Renderer *renderer);
/// ```
pub extern "C" fn sdl_RenderClipEnabled(renderer: SDL_Renderer) -> Bool = "SDL_RenderClipEnabled"

///| Set the drawing scale for rendering on the current target.
///
/// The drawing coordinates are scaled by the x/y scaling factors before they
/// are used by the renderer. This allows resolution independent drawing with a
/// single coordinate system.
///
/// If this results in scaling or subpixel drawing by the rendering backend, it
/// will be handled using the appropriate quality hints. For best results use
/// integer scaling factors.
///
/// Each render target has its own scale. This function sets the scale for the
/// current render target.
///
/// @param renderer the rendering context.
/// @param scaleX the horizontal scaling factor.
/// @param scaleY the vertical scaling factor.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetRenderScale
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetRenderScale(SDL_Renderer *renderer, float scaleX, float scaleY);
/// ```
pub extern "C" fn sdl_SetRenderScale(renderer: SDL_Renderer, scaleX: Float, scaleY: Float) -> Bool = "SDL_SetRenderScale"

///| Get the drawing scale for the current target.
///
/// Each render target has its own scale. This function gets the scale for the
/// current render target.
///
/// @param renderer the rendering context.
/// @param scaleX a pointer filled in with the horizontal scaling factor.
/// @param scaleY a pointer filled in with the vertical scaling factor.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_SetRenderScale
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRenderScale(SDL_Renderer *renderer, float *scaleX, float *scaleY);
/// ```
pub extern "C" fn sdl_GetRenderScale(renderer: SDL_Renderer, scaleX: FixedArray[Float], scaleY: FixedArray[Float]) -> Bool = "SDL_GetRenderScale"

///| Set the color used for drawing operations.
///
/// Set the color for drawing or filling rectangles, lines, and points, and for
/// SDL_RenderClear().
///
/// @param renderer the rendering context.
/// @param r the red value used to draw on the rendering target.
/// @param g the green value used to draw on the rendering target.
/// @param b the blue value used to draw on the rendering target.
/// @param a the alpha value used to draw on the rendering target; usually
///          `SDL_ALPHA_OPAQUE` (255). Use SDL_SetRenderDrawBlendMode to
///          specify how the alpha channel is used.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetRenderDrawColor
/// @see SDL_SetRenderDrawColorFloat
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetRenderDrawColor(SDL_Renderer *renderer, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
/// ```
pub extern "C" fn sdl_SetRenderDrawColor(renderer: SDL_Renderer, r: Byte, g: Byte, b: Byte, a: Byte) -> Bool = "SDL_SetRenderDrawColor"

///| Set the color used for drawing operations (Rect, Line and Clear).
///
/// Set the color for drawing or filling rectangles, lines, and points, and for
/// SDL_RenderClear().
///
/// @param renderer the rendering context.
/// @param r the red value used to draw on the rendering target.
/// @param g the green value used to draw on the rendering target.
/// @param b the blue value used to draw on the rendering target.
/// @param a the alpha value used to draw on the rendering target. Use
///          SDL_SetRenderDrawBlendMode to specify how the alpha channel is
///          used.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetRenderDrawColorFloat
/// @see SDL_SetRenderDrawColor
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetRenderDrawColorFloat(SDL_Renderer *renderer, float r, float g, float b, float a);
/// ```
pub extern "C" fn sdl_SetRenderDrawColorFloat(renderer: SDL_Renderer, r: Float, g: Float, b: Float, a: Float) -> Bool = "SDL_SetRenderDrawColorFloat"

///| Get the color used for drawing operations (Rect, Line and Clear).
///
/// @param renderer the rendering context.
/// @param r a pointer filled in with the red value used to draw on the
///          rendering target.
/// @param g a pointer filled in with the green value used to draw on the
///          rendering target.
/// @param b a pointer filled in with the blue value used to draw on the
///          rendering target.
/// @param a a pointer filled in with the alpha value used to draw on the
///          rendering target; usually `SDL_ALPHA_OPAQUE` (255).
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetRenderDrawColorFloat
/// @see SDL_SetRenderDrawColor
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRenderDrawColor(SDL_Renderer *renderer, Uint8 *r, Uint8 *g, Uint8 *b, Uint8 *a);
/// ```
pub extern "C" fn sdl_GetRenderDrawColor(renderer: SDL_Renderer, r: Bytes, g: Bytes, b: Bytes, a: Bytes) -> Bool = "SDL_GetRenderDrawColor"

///| Get the color used for drawing operations (Rect, Line and Clear).
///
/// @param renderer the rendering context.
/// @param r a pointer filled in with the red value used to draw on the
///          rendering target.
/// @param g a pointer filled in with the green value used to draw on the
///          rendering target.
/// @param b a pointer filled in with the blue value used to draw on the
///          rendering target.
/// @param a a pointer filled in with the alpha value used to draw on the
///          rendering target.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_SetRenderDrawColorFloat
/// @see SDL_GetRenderDrawColor
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRenderDrawColorFloat(SDL_Renderer *renderer, float *r, float *g, float *b, float *a);
/// ```
pub extern "C" fn sdl_GetRenderDrawColorFloat(renderer: SDL_Renderer, r: FixedArray[Float], g: FixedArray[Float], b: FixedArray[Float], a: FixedArray[Float]) -> Bool = "SDL_GetRenderDrawColorFloat"

///| Set the color scale used for render operations.
///
/// The color scale is an additional scale multiplied into the pixel color
/// value while rendering. This can be used to adjust the brightness of colors
/// during HDR rendering, or changing HDR video brightness when playing on an
/// SDR display.
///
/// The color scale does not affect the alpha channel, only the color
/// brightness.
///
/// @param renderer the rendering context.
/// @param scale the color scale value.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetRenderColorScale
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetRenderColorScale(SDL_Renderer *renderer, float scale);
/// ```
pub extern "C" fn sdl_SetRenderColorScale(renderer: SDL_Renderer, scale: Float) -> Bool = "SDL_SetRenderColorScale"

///| Get the color scale used for render operations.
///
/// @param renderer the rendering context.
/// @param scale a pointer filled in with the current color scale value.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_SetRenderColorScale
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRenderColorScale(SDL_Renderer *renderer, float *scale);
/// ```
pub extern "C" fn sdl_GetRenderColorScale(renderer: SDL_Renderer, scale: FixedArray[Float]) -> Bool = "SDL_GetRenderColorScale"

///| Set the blend mode used for drawing operations (Fill and Line).
///
/// If the blend mode is not supported, the closest supported mode is chosen.
///
/// @param renderer the rendering context.
/// @param blendMode the SDL_BlendMode to use for blending.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetRenderDrawBlendMode
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetRenderDrawBlendMode(SDL_Renderer *renderer, SDL_BlendMode blendMode);
/// ```
pub extern "C" fn sdl_SetRenderDrawBlendMode(renderer: SDL_Renderer, blendMode: SDL_BlendMode) -> Bool = "SDL_SetRenderDrawBlendMode"

///| Get the blend mode used for drawing operations.
///
/// @param renderer the rendering context.
/// @param blendMode a pointer filled in with the current SDL_BlendMode.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_SetRenderDrawBlendMode
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRenderDrawBlendMode(SDL_Renderer *renderer, SDL_BlendMode *blendMode);
/// ```
pub extern "C" fn sdl_GetRenderDrawBlendMode(renderer: SDL_Renderer, blendMode: FixedArray[SDL_BlendMode]) -> Bool = "SDL_GetRenderDrawBlendMode"

///| Clear the current rendering target with the drawing color.
///
/// This function clears the entire rendering target, ignoring the viewport and
/// the clip rectangle. Note, that clearing will also set/fill all pixels of
/// the rendering target to current renderer draw color, so make sure to invoke
/// SDL_SetRenderDrawColor() when needed.
///
/// @param renderer the rendering context.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_SetRenderDrawColor
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderClear(SDL_Renderer *renderer);
/// ```
pub extern "C" fn sdl_RenderClear(renderer: SDL_Renderer) -> Bool = "SDL_RenderClear"

///| Draw a point on the current rendering target.
///
/// @param renderer the rendering context.
/// @param x the x coordinate of the point.
/// @param y the y coordinate of the point.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_RenderPoints
/// @see SDL_SetRenderDrawColor
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderPoint(SDL_Renderer *renderer, float x, float y);
/// ```
pub extern "C" fn sdl_RenderPoint(renderer: SDL_Renderer, x: Float, y: Float) -> Bool = "SDL_RenderPoint"

///| Draw multiple points on the current rendering target.
///
/// @param renderer the rendering context.
/// @param points the points to draw.
/// @param count the number of points to draw.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_RenderPoint
/// @see SDL_SetRenderDrawColor
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderPoints(SDL_Renderer *renderer, const SDL_FPoint *points, int count);
/// ```
/// Note: the type of points `FixedArray[Float]` is correct, because SDL_FPoint is { Float, Float }
pub extern "C" fn sdl_RenderPoints(renderer: SDL_Renderer, points: FixedArray[Float], count: Int) -> Bool = "SDL_RenderPoints"

///| Draw a line on the current rendering target.
///
/// @param renderer the rendering context.
/// @param x1 the x coordinate of the start point.
/// @param y1 the y coordinate of the start point.
/// @param x2 the x coordinate of the end point.
/// @param y2 the y coordinate of the end point.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_RenderLines
/// @see SDL_SetRenderDrawColor
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderLine(SDL_Renderer *renderer, float x1, float y1, float x2, float y2);
/// ```
pub extern "C" fn sdl_RenderLine(renderer: SDL_Renderer, x1: Float, y1: Float, x2: Float, y2: Float) -> Bool = "SDL_RenderLine"

///| Draw a series of connected lines on the current rendering target.
///
/// @param renderer the rendering context.
/// @param points the points along the lines.
/// @param count the number of points, drawing count-1 lines.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_RenderLine
/// @see SDL_SetRenderDrawColor
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderLines(SDL_Renderer *renderer, const SDL_FPoint *points, int count);
/// ```
/// Note: the type of points `FixedArray[Float]` is correct, because SDL_FPoint is { Float, Float }
pub extern "C" fn sdl_RenderLines(renderer: SDL_Renderer, points: FixedArray[Float], count: Int) -> Bool = "SDL_RenderLines"

///| Draw a rectangle on the current rendering target.
///
/// @param renderer the rendering context.
/// @param rect a pointer to the destination rectangle, or NULL to outline the
///             entire rendering target.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_RenderRects
/// @see SDL_SetRenderDrawColor
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderRect(SDL_Renderer *renderer, const SDL_FRect *rect);
/// ```
pub extern "C" fn sdl_RenderRect(renderer: SDL_Renderer, rect: SDL_FRect) -> Bool = "SDL_RenderRect"

///| Draw some number of rectangles on the current rendering target.
///
/// @param renderer the rendering context.
/// @param rects a pointer to an array of destination rectangles.
/// @param count the number of rectangles.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_RenderRect
/// @see SDL_SetRenderDrawColor
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderRects(SDL_Renderer *renderer, const SDL_FRect *rects, int count);
/// ```
/// Note: the type of rects `FixedArray[Float]` is correct, because SDL_FRect is { Float, Float, Float, Float }
pub extern "C" fn sdl_RenderRects(renderer: SDL_Renderer, rects: FixedArray[Float], count: Int) -> Bool = "SDL_RenderRects"

///| Fill a rectangle on the current rendering target with the drawing color.
///
/// @param renderer the rendering context.
/// @param rect a pointer to the destination rectangle, or NULL for the entire
///             rendering target.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_RenderFillRects
/// @see SDL_SetRenderDrawColor
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderFillRect(SDL_Renderer *renderer, const SDL_FRect *rect);
/// ```
pub extern "C" fn sdl_RenderFillRect(renderer: SDL_Renderer, rect: SDL_FRect) -> Bool = "SDL_RenderFillRect"

///| Fill some number of rectangles on the current rendering target with the
///| drawing color.
///
/// @param renderer the rendering context.
/// @param rects a pointer to an array of destination rectangles.
/// @param count the number of rectangles.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_RenderFillRect
/// @see SDL_SetRenderDrawColor
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderFillRects(SDL_Renderer *renderer, const SDL_FRect *rects, int count);
/// ```
/// Note: the type of rects `FixedArray[Float]` is correct, because SDL_FRect is { Float, Float, Float, Float }
pub extern "C" fn sdl_RenderFillRects(renderer: SDL_Renderer, rects: FixedArray[Float], count: Int) -> Bool = "SDL_RenderFillRects"

///| Copy a portion of the texture to the current rendering target.
///
/// @param renderer the rendering context.
/// @param texture the source texture.
/// @param srcrect a pointer to the source rectangle, or NULL for the entire
///                texture.
/// @param dstrect a pointer to the destination rectangle, or NULL for the
///                entire rendering target.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_RenderTextureRotated
/// @see SDL_SetTextureAlphaMod
/// @see SDL_SetTextureBlendMode
/// @see SDL_SetTextureColorMod
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderTexture(SDL_Renderer *renderer, SDL_Texture *texture, const SDL_FRect *srcrect, const SDL_FRect *dstrect);
/// ```
pub extern "C" fn sdl_RenderTexture(renderer: SDL_Renderer, texture: SDL_Texture, srcrect: SDL_FRect, dstrect: SDL_FRect) -> Bool = "SDL_RenderTexture"

///| Copy a portion of the texture to the current rendering target, optionally
///| rotating it by angle around the given center and also flipping it top-bottom
///| and/or left-right.
///
/// @param renderer the rendering context.
/// @param texture the source texture.
/// @param srcrect a pointer to the source rectangle, or NULL for the entire
///                texture.
/// @param dstrect a pointer to the destination rectangle, or NULL for the
///                entire rendering target.
/// @param angle an angle in degrees that indicates the rotation that will be
///              applied to dstrect, rotating it in a clockwise direction.
/// @param center a pointer to a point indicating the point around which
///               dstrect will be rotated (if NULL, rotation will be done
///               around `dstrect.w / 2`, `dstrect.h / 2`).
/// @param flip a SDL_FlipMode value stating which flipping operations should
///             be performed on the texture.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_RenderTexture
/// @see SDL_SetTextureAlphaMod
/// @see SDL_SetTextureBlendMode
/// @see SDL_SetTextureColorMod
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderTextureRotated(SDL_Renderer *renderer, SDL_Texture *texture, const SDL_FRect *srcrect, const SDL_FRect *dstrect, const double angle, const SDL_FPoint *center, const SDL_FlipMode flip);
/// ```
pub extern "C" fn sdl_RenderTextureRotated(renderer: SDL_Renderer, texture: SDL_Texture, srcrect: SDL_FRect, dstrect: SDL_FRect, angle: Double, center: SDL_FPoint, flip: SDL_FlipMode) -> Bool = "SDL_RenderTextureRotated"

///| Render a list of triangles, optionally using a texture and indices into the vertex array.
///
/// @param renderer the rendering context.
/// @param texture a pointer to the texture to apply to the geometry, or NULL
///                if no texture is required.
/// @param vertices a pointer to an array of vertices.
/// @param num_vertices the number of vertices in the `vertices` array.
/// @param indices a pointer to an array of indices into the `vertices` array,
///                or NULL if the vertices are to be rendered in order.
/// @param num_indices the number of indices in the `indices` array, or 0 if
///                    `indices` is NULL.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderGeometry(SDL_Renderer *renderer,
///                                                     SDL_Texture *texture,
///                                                     const SDL_Vertex *vertices, int num_vertices,
///                                                     const int *indices, int num_indices);
/// ```
pub extern "C" fn sdl_RenderGeometry(renderer: SDL_Renderer, texture: SDL_Texture, vertices: SDL_Vertex, num_vertices: Int, indices: FixedArray[Int], num_indices: Int) -> Bool = "SDL_RenderGeometry"

///| Render a list of triangles.
///
/// Render a list of triangles, optionally using a texture and indices into the
/// vertex array. This is the same as SDL_RenderGeometry(), but with floating
/// point precision.
///
/// @param renderer the rendering context.
/// @param texture a pointer to the texture to apply to the geometry, or NULL
///                if no texture is required.
/// @param vertices a pointer to an array of vertices.
/// @param num_vertices the number of vertices in the `vertices` array.
/// @param indices a pointer to an array of indices into the `vertices` array,
///                or NULL if the vertices are to be rendered in order.
/// @param num_indices the number of indices in the `indices` array, or 0 if
///                    `indices` is NULL.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderGeometryRaw(SDL_Renderer *renderer,
///                                                   SDL_Texture *texture,
///                                                   const float *xy, int xy_stride,
///                                                   const SDL_FColor *color, int color_stride,
///                                                   const float *uv, int uv_stride,
///                                                   int num_vertices,
///                                                   const void *indices, int num_indices, int size_indices);
/// ```
pub extern "C" fn sdl_RenderGeometryRaw(renderer: SDL_Renderer, texture: SDL_Texture, xy: FixedArray[Float], xy_stride: Int, color: SDL_FColor, color_stride: Int, uv: FixedArray[Float], uv_stride: Int, num_vertices: Int, indices: VoidPtr, num_indices: Int, size_indices: Int) -> Bool = "SDL_RenderGeometryRaw"

///| Update the screen with rendering performed.
///
/// SDL's rendering functions operate on a backbuffer; that is, calling a
/// rendering function such as SDL_RenderLine() does not directly put a line
/// on the screen, but rather updates the backbuffer. As such, you compose
/// your entire scene and then present the backbuffer to the screen as a
/// single operation.
///
/// A renderer may be automatically presented in the event loop, but may also
/// need to be manually presented with this function. You should check the
/// `SDL_PROP_WINDOW_CREATE_RENDERER_PRESENT_NUMBER` hint for details.
///
/// @param renderer the rendering context
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_CreateRenderer
/// @see SDL_DestroyRenderer
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderPresent(SDL_Renderer *renderer);
/// ```
pub extern "C" fn sdl_RenderPresent(renderer: SDL_Renderer) -> Bool = "SDL_RenderPresent"

///| Destroy the specified texture.
///
/// @param texture the texture to destroy.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_CreateTexture
/// @see SDL_CreateTextureFromSurface
/// @see SDL_CreateTextureWithProperties
///
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_DestroyTexture(SDL_Texture *texture);
/// ```
pub extern "C" fn sdl_DestroyTexture(texture: SDL_Texture) -> Unit = "SDL_DestroyTexture"

///| Destroy the rendering context for a window and free associated textures.
///
/// @param renderer the rendering context
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_CreateRenderer
///
/// ```c
/// extern SDL_DECLSPEC void SDLCALL SDL_DestroyRenderer(SDL_Renderer *renderer);
/// ```
pub extern "C" fn sdl_DestroyRenderer(renderer: SDL_Renderer) -> Unit = "SDL_DestroyRenderer"

///| Force the rendering context to flush any pending commands to the device.
///
/// You don't normally need to call this function unless you are planning to
/// escape the SDL render API and render either pure OpenGl / Direct3D or
/// another library on top of an SDL window.
///
/// This function is not thread safe and should only be called from the main
/// thread.
///
/// @param renderer the rendering context
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_RenderFlush(SDL_Renderer *renderer);
/// ```
pub extern "C" fn sdl_RenderFlush(renderer: SDL_Renderer) -> Bool = "SDL_RenderFlush"

///| Set the VSync setting for a renderer.
///
/// @param renderer the renderer to modify.
/// @param vsync `1` to enable VSync, `0` to disable it, and `-1` for adaptive
///              VSync.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_GetRenderVSync
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_SetRenderVSync(SDL_Renderer *renderer, int vsync);
/// ```
pub extern "C" fn sdl_SetRenderVSync(renderer: SDL_Renderer, vsync: Int) -> Bool = "SDL_SetRenderVSync"

///| Get the VSync setting for a renderer.
///
/// @param renderer the renderer to query.
/// @param vsync a pointer filled with the VSync setting; `1` if VSync is
///              enabled, `0` if it's disabled, and `-1` if adaptive VSync is
///              enabled.
/// @return true on success or false on failure; call SDL_GetError() for more
///          information.
///
/// @threadsafety This function should only be called on the main thread.
///
/// @since This function is available since SDL 3.2.0.
///
/// @see SDL_SetRenderVSync
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRenderVSync(SDL_Renderer *renderer, int *vsync);
/// ```
pub extern "C" fn sdl_GetRenderVSync(renderer: SDL_Renderer, vsync: Ref[Int]) -> Bool = "SDL_GetRenderVSync"
