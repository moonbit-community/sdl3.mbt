export CC=gcc
export CC_FLAGS="$(pkg-config --cflags sdl3) -w"
export CC_LINK_FLAGS="$(pkg-config --libs sdl3)"
export C_INCLUDE_PATH="$C_INCLUDE_PATH:/opt/homebrew/include"
