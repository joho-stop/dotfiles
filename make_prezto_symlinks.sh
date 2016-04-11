#!/usr/bin/zsh

echo Creating prezto symlinks

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  echo Creating symlink for $rcfile
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
