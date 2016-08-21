#/usr/bin/zsh

# =============================================================================
# Includes

# Prezto
PREZTO_INIT="${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
[[ -s $PREZTO_INIT ]] && source $PREZTO_INIT

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-tomorrow.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# dotfiles_private
ZSHRC_PRIVATE="$HOME/dotfiles_private/zshrc_private"
[[ -s $ZSHRC_PRIVATE ]] && source $ZSHRC_PRIVATE

# =============================================================================
# Tools

export EDITOR="nvim"
export DIFF="meld"
export BROWSER="firefox"

# =============================================================================
# Settings

#export NVIM_TUI_ENABLE_TRUE_COLOR=1

# =============================================================================
# Shadows

alias vim='nvim'
alias :e='nvim' # I mean, it happens... :)

# =============================================================================
# Aliases

alias xclipc='xclip -selection c'

findheader () {
	find -type f -regextype posix-egrep -regex ".+\.(h|hh|hpp|hxx)" "$@"
}
grepheader () { findheader -exec grep "$@" {} \+ }

findsrc () {
	find -type f -regextype posix-egrep -regex ".+\.(c|cc|cpp|cxx)" "$@"
}
grepsrc () { findsrc -exec grep "$@" {} \+ }

findxx () {
	find -type f -regextype posix-egrep -regex ".+\.(c|cc|cpp|cxx|h|hh|hpp|hxx|ipp|ixx)" "$@"
}
grepxx () { findxx -exec grep "$@" {} \+ }

findrs () {
	find -type f -regextype posix-egrep -regex ".+\.(rs|rc|toml)" "$@"
}
greprs () { findrs -exec grep "$@" {} \+ }

# =============================================================================
# Settings

# vi mode
bindkey -v

# cd-less cd
# setopt AUTO_CD

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# Scripts and bin
export PATH="$HOME/bin:$HOME/scripts:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

# =============================================================================
# Vulkan SDK...

export VULKAN_SDK="$HOME/sdk/VulkanSDK/1.0.21.1/x86_64"

export PATH="$PATH:$VULKAN_SDK/bin"
export LD_LIBRARY_PATH="$VULKAN_SDK/lib"
export VK_LAYER_PATH="$VULKAN_SDK/etc/explicit_layer.d"

