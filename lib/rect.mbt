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

/// # CategoryRect
///
/// Some helper functions for managing rectangles and 2D points, in both
/// integer and floating point versions.

///| The structure that defines a point (using integers).
///
/// ```c
/// typedef struct SDL_Point
/// {
///     int x;
///     int y;
/// } SDL_Point;
/// ```
pub(all) struct SDL_Point {
  x: Int
  y: Int
}

///| The structure that defines a point (using floating point values).
///
/// ```c
/// typedef struct SDL_FPoint
/// {
///     float x;
///     float y;
/// } SDL_FPoint;
/// ```
pub(all) struct SDL_FPoint {
  x: Float
  y: Float
}

///| A rectangle, with the origin at the upper left (using integers).
///
/// ```c
/// typedef struct SDL_Rect
/// {
///     int x, y;
///     int w, h;
/// } SDL_Rect;
/// ```
pub(all) struct SDL_Rect {
  x: Int
  y: Int
  w: Int
  h: Int
}

///| A rectangle, with the origin at the upper left (using floating point
///| values).
///
/// ```c
/// typedef struct SDL_FRect
/// {
///     float x;
///     float y;
///     float w;
///     float h;
/// } SDL_FRect;
/// ```
pub(all) struct SDL_FRect {
  x: Float
  y: Float
  w: Float
  h: Float
}

///| Convert an SDL_Rect to SDL_FRect
///
/// ```c
/// SDL_FORCE_INLINE void SDL_RectToFRect(const SDL_Rect *rect, SDL_FRect *frect)
/// {
///     frect->x = (float)rect->x;
///     frect->y = (float)rect->y;
///     frect->w = (float)rect->w;
///     frect->h = (float)rect->h;
/// }
/// ```
pub fn sdl_RectToFRect(rect: SDL_Rect) -> SDL_FRect {
  {
    x: rect.x.to_float(),
    y: rect.y.to_float(),
    w: rect.w.to_float(),
    h: rect.h.to_float(),
  }
}

///| Determine whether a point resides inside a rectangle.
///
/// ```c
/// SDL_FORCE_INLINE bool SDL_PointInRect(const SDL_Point *p, const SDL_Rect *r)
/// {
///     return ( p && r && (p->x >= r->x) && (p->x < (r->x + r->w)) &&
///              (p->y >= r->y) && (p->y < (r->y + r->h)) ) ? true : false;
/// }
/// ```
pub fn sdl_PointInRect(p: SDL_Point, r: SDL_Rect) -> Bool {
  p.x >= r.x && p.x < (r.x + r.w) && p.y >= r.y && p.y < (r.y + r.h)
}

///| Determine whether a rectangle has no area.
///
/// ```c
/// SDL_FORCE_INLINE bool SDL_RectEmpty(const SDL_Rect *r)
/// {
///     return ((!r) || (r->w <= 0) || (r->h <= 0)) ? true : false;
/// }
/// ```
pub fn sdl_RectEmpty(r: SDL_Rect) -> Bool {
  r.w <= 0 || r.h <= 0
}

///| Determine whether two rectangles are equal.
///
/// ```c
/// SDL_FORCE_INLINE bool SDL_RectsEqual(const SDL_Rect *a, const SDL_Rect *b)
/// {
///     return (a && b && (a->x == b->x) && (a->y == b->y) &&
///             (a->w == b->w) && (a->h == b->h)) ? true : false;
/// }
/// ```
pub fn sdl_RectsEqual(a: SDL_Rect, b: SDL_Rect) -> Bool {
  a.x == b.x && a.y == b.y && a.w == b.w && a.h == b.h
}

///| Determine whether two rectangles intersect.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasRectIntersection(const SDL_Rect *A, const SDL_Rect *B);
/// ```
pub extern "C" fn sdl_HasRectIntersection(a: SDL_Rect, b: SDL_Rect) -> Bool = "SDL_HasRectIntersection"

///| Calculate the intersection of two rectangles.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRectIntersection(const SDL_Rect *A, const SDL_Rect *B, SDL_Rect *result);
/// ```
extern "C" fn __sdl_GetRectIntersection(a: SDL_Rect, b: SDL_Rect, result: FixedArray[SDL_Rect]) -> Bool = "SDL_GetRectIntersection"

pub fn sdl_GetRectIntersection(a: SDL_Rect, b: SDL_Rect) -> (Bool, SDL_Rect) {
  let result : FixedArray[SDL_Rect] = FixedArray::make(1, {x: 0, y: 0, w: 0, h: 0})
  let success = __sdl_GetRectIntersection(a, b, result)
  (success, result[0])
}

///| Calculate the union of two rectangles.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRectUnion(const SDL_Rect *A, const SDL_Rect *B, SDL_Rect *result);
/// ```
extern "C" fn __sdl_GetRectUnion(a: SDL_Rect, b: SDL_Rect, result: FixedArray[SDL_Rect]) -> Bool = "SDL_GetRectUnion"

pub fn sdl_GetRectUnion(a: SDL_Rect, b: SDL_Rect) -> (Bool, SDL_Rect) {
  let result : FixedArray[SDL_Rect] = FixedArray::make(1, {x: 0, y: 0, w: 0, h: 0})
  let success = __sdl_GetRectUnion(a, b, result)
  (success, result[0])
}

///| Calculate a minimal rectangle enclosing a set of points.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRectEnclosingPoints(const SDL_Point *points, int count, const SDL_Rect *clip, SDL_Rect *result);
/// ```
extern "C" fn __sdl_GetRectEnclosingPoints(points: FixedArray[SDL_Point], count: Int, clip: SDL_Rect, result: FixedArray[SDL_Rect]) -> Bool = "SDL_GetRectEnclosingPoints"

pub fn sdl_GetRectEnclosingPoints(points: Array[SDL_Point], clip: SDL_Rect) -> (Bool, SDL_Rect) {
  let result : FixedArray[SDL_Rect] = FixedArray::make(1, {x: 0, y: 0, w: 0, h: 0})
  let success = __sdl_GetRectEnclosingPoints(FixedArray::from_array(points), points.length(), clip, result)
  (success, result[0])
}

///| Calculate the intersection of a rectangle and line segment.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRectAndLineIntersection(const SDL_Rect *rect, int *X1, int *Y1, int *X2, int *Y2);
/// ```
extern "C" fn __sdl_GetRectAndLineIntersection(rect: SDL_Rect, x1: FixedArray[Int], y1: FixedArray[Int], x2: FixedArray[Int], y2: FixedArray[Int]) -> Bool = "SDL_GetRectAndLineIntersection"

pub fn sdl_GetRectAndLineIntersection(rect: SDL_Rect, x1: Int, y1: Int, x2: Int, y2: Int) -> (Bool, Int, Int, Int, Int) {
  let x1_ptr = FixedArray::make(1, x1)
  let y1_ptr = FixedArray::make(1, y1)
  let x2_ptr = FixedArray::make(1, x2)
  let y2_ptr = FixedArray::make(1, y2)
  let success = __sdl_GetRectAndLineIntersection(rect, x1_ptr, y1_ptr, x2_ptr, y2_ptr)
  (success, x1_ptr[0], y1_ptr[0], x2_ptr[0], y2_ptr[0])
}

///| Determine whether a point resides inside a floating point rectangle.
///
/// ```c
/// SDL_FORCE_INLINE bool SDL_PointInRectFloat(const SDL_FPoint *p, const SDL_FRect *r)
/// {
///     return ( p && r && (p->x >= r->x) && (p->x <= (r->x + r->w)) &&
///              (p->y >= r->y) && (p->y <= (r->y + r->h)) ) ? true : false;
/// }
/// ```
pub fn sdl_PointInRectFloat(p: SDL_FPoint, r: SDL_FRect) -> Bool {
  p.x >= r.x && p.x <= (r.x + r.w) && p.y >= r.y && p.y <= (r.y + r.h)
}

///| Determine whether a floating point rectangle takes no space.
///
/// ```c
/// SDL_FORCE_INLINE bool SDL_RectEmptyFloat(const SDL_FRect *r)
/// {
///     return ((!r) || (r->w < 0.0f) || (r->h < 0.0f)) ? true : false;
/// }
/// ```
pub fn sdl_RectEmptyFloat(r: SDL_FRect) -> Bool {
  r.w < 0.0 || r.h < 0.0
}

///| Determine whether two floating point rectangles are equal, within some
///| given epsilon.
///
/// ```c
/// SDL_FORCE_INLINE bool SDL_RectsEqualEpsilon(const SDL_FRect *a, const SDL_FRect *b, float epsilon)
/// {
///     return (a && b && ((a == b) ||
///             ((SDL_fabsf(a->x - b->x) <= epsilon) &&
///             (SDL_fabsf(a->y - b->y) <= epsilon) &&
///             (SDL_fabsf(a->w - b->w) <= epsilon) &&
///             (SDL_fabsf(a->h - b->h) <= epsilon))))
///             ? true : false;
/// }
/// ```
pub fn sdl_RectsEqualEpsilon(a: SDL_FRect, b: SDL_FRect, epsilon: Float) -> Bool {
  (a.x - b.x).abs() <= epsilon &&
  (a.y - b.y).abs() <= epsilon &&
  (a.w - b.w).abs() <= epsilon &&
  (a.h - b.h).abs() <= epsilon
}

///| Determine whether two floating point rectangles are equal, within a default
///| epsilon.
///
/// ```c
/// SDL_FORCE_INLINE bool SDL_RectsEqualFloat(const SDL_FRect *a, const SDL_FRect *b)
/// {
///     return SDL_RectsEqualEpsilon(a, b, SDL_FLT_EPSILON);
/// }
/// ```
pub fn sdl_RectsEqualFloat(a: SDL_FRect, b: SDL_FRect) -> Bool {
  sdl_RectsEqualEpsilon(a, b, 1.19209290e-07) // SDL_FLT_EPSILON
}

///| Determine whether two rectangles intersect with float precision.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_HasRectIntersectionFloat(const SDL_FRect *A, const SDL_FRect *B);
/// ```
pub extern "C" fn sdl_HasRectIntersectionFloat(a: SDL_FRect, b: SDL_FRect) -> Bool = "SDL_HasRectIntersectionFloat"

///| Calculate the intersection of two rectangles with float precision.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRectIntersectionFloat(const SDL_FRect *A, const SDL_FRect *B, SDL_FRect *result);
/// ```
extern "C" fn __sdl_GetRectIntersectionFloat(a: SDL_FRect, b: SDL_FRect, result: FixedArray[SDL_FRect]) -> Bool = "SDL_GetRectIntersectionFloat"

pub fn sdl_GetRectIntersectionFloat(a: SDL_FRect, b: SDL_FRect) -> (Bool, SDL_FRect) {
  let result : FixedArray[SDL_FRect] = FixedArray::make(1, {x: 0.0, y: 0.0, w: 0.0, h: 0.0})
  let success = __sdl_GetRectIntersectionFloat(a, b, result)
  (success, result[0])
}

///| Calculate the union of two rectangles with float precision.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRectUnionFloat(const SDL_FRect *A, const SDL_FRect *B, SDL_FRect *result);
/// ```
extern "C" fn __sdl_GetRectUnionFloat(a: SDL_FRect, b: SDL_FRect, result: FixedArray[SDL_FRect]) -> Bool = "SDL_GetRectUnionFloat"

pub fn sdl_GetRectUnionFloat(a: SDL_FRect, b: SDL_FRect) -> (Bool, SDL_FRect) {
  let result : FixedArray[SDL_FRect] = FixedArray::make(1, {x: 0.0, y: 0.0, w: 0.0, h: 0.0})
  let success = __sdl_GetRectUnionFloat(a, b, result)
  (success, result[0])
}

///| Calculate a minimal rectangle enclosing a set of points with float
///| precision.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRectEnclosingPointsFloat(const SDL_FPoint *points, int count, const SDL_FRect *clip, SDL_FRect *result);
/// ```
extern "C" fn __sdl_GetRectEnclosingPointsFloat(points: FixedArray[SDL_FPoint], count: Int, clip: SDL_FRect, result: FixedArray[SDL_FRect]) -> Bool = "SDL_GetRectEnclosingPointsFloat"

pub fn sdl_GetRectEnclosingPointsFloat(points: Array[SDL_FPoint], clip: SDL_FRect) -> (Bool, SDL_FRect) {
  let result: FixedArray[SDL_FRect] = FixedArray::make(1, {x: 0.0, y: 0.0, w: 0.0, h: 0.0})
  let success = __sdl_GetRectEnclosingPointsFloat(FixedArray::from_array(points), points.length(), clip, result)
  (success, result[0])
}

///| Calculate the intersection of a rectangle and line segment with float
///| precision.
///
/// ```c
/// extern SDL_DECLSPEC bool SDLCALL SDL_GetRectAndLineIntersectionFloat(const SDL_FRect *rect, float *X1, float *Y1, float *X2, float *Y2);
/// ```
extern "C" fn __sdl_GetRectAndLineIntersectionFloat(rect: SDL_FRect, x1: FixedArray[Float], y1: FixedArray[Float], x2: FixedArray[Float], y2: FixedArray[Float]) -> Bool = "SDL_GetRectAndLineIntersectionFloat"

pub fn sdl_GetRectAndLineIntersectionFloat(rect: SDL_FRect, x1: Float, y1: Float, x2: Float, y2: Float) -> (Bool, Float, Float, Float, Float) {
  let x1_ptr = FixedArray::make(1, x1)
  let y1_ptr = FixedArray::make(1, y1)
  let x2_ptr = FixedArray::make(1, x2)
  let y2_ptr = FixedArray::make(1, y2)
  let success = __sdl_GetRectAndLineIntersectionFloat(rect, x1_ptr, y1_ptr, x2_ptr, y2_ptr)
  (success, x1_ptr[0], y1_ptr[0], x2_ptr[0], y2_ptr[0])
}
