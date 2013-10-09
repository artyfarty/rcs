. ~/.profile

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

autoload -Uz compinit && compinit
autoload -U colors && colors
autoload -Uz promptinit && promptinit && prompt adam2

alias ls='ls -wFG'

case $TERM in
    xterm*)
		# set the terminal title
		settitle() {
		    print -Pn "\e]0;%~\a"
		}
		settitle

		# nice ssh with titles
		ssh() {
		    /usr/bin/ssh $*
		    settitle
		}
		
		PS1="%n:%{$fg[blue]%}%~ %{$reset_color%}%% "
		
        precmd () { settitle }
        ;;
esac

zstyle ':completion:*' auto-description 'specify: %d'
#zstyle ':completion:*' completer _expand _complete _correct _approximate
#zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -a -u $USER -o pid,%cpu,args'

__git_files () { 
    _wanted files expl 'local files' _files     
}
