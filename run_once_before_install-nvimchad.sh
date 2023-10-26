#!/bin/sh
if [ ! -d ~/.config/nvim ]; then
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
fi

