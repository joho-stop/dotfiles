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
# Shadows

alias vim='nvim'

# =============================================================================
# Aliases

alias xclipc='xclip -selection c'

findheader () {
	find -regextype posix-egrep -regex ".+\.(h|hh|hpp|hxx)" "$@"
}
grepheader () { grep "$@" `findheader` }

findsrc () {
	find -regextype posix-egrep -regex ".+\.(c|cc|cpp|cxx)" "$@"
}
grepsrc () { grep "$@" `findsrc` }

findxx () {
	find -regextype posix-egrep -regex ".+\.(c|cc|cpp|cxx|h|hh|hpp|hxx|ipp|ixx)" "$@"
}
grepxx () { grep "$@" `findxx` }

# =============================================================================
# Settings

# vi mode
bindkey -v

# cd-less cd
setopt AUTO_CD

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# Scripts and bin
export PATH="~/bin:~/scripts:$PATH"

