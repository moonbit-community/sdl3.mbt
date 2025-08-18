
#include <moonbit.h>
#include <stdlib.h>
#include <string.h>
#include <SDL3/SDL.h>

moonbit_string_t cstr_to_moonbit_string(void *ptr) {
  char *cptr = (char *)ptr;
  int32_t len = strlen(cptr);
  moonbit_string_t ms = moonbit_make_string(len, 0);
  for (int i = 0; i < len; i++) {
    ms[i] = (uint16_t)cptr[i];
  }
  return ms;
}

void free_cstr(char* p) {
  if (p) {
    free(p);
  }
}

void* get_null() {
  return (void*)0;
}

int voidptr_is_null(void* p) {
  return p == NULL;
}

SDL_Event* new_sdl_event() {
  SDL_Event *event = (SDL_Event *)malloc(sizeof(SDL_Event));
  return event;
}

SDL_EventType sdl_event_get_type(SDL_Event *event) {
  return event->type;
}
