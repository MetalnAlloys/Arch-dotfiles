fpath+=$HOME/.zsh/pure

## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:git:branch color white
zstyle :prompt:pure:path color '#88a2a4'

HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=500
#export EDITOR=/usr/bin/nano
#export VISUAL=/usr/bin/nano
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word


## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                    #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

## Alias section 
alias cp="cp -i"                                                # Confirm before overwriting something
#alias cat="bat"
alias df='df -h'                                                # Human-readable sizes
alias vim='nvim'
alias vifm='vifmrun'
alias lsd='ls -d */'
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'
alias xrdbx='xrdb $HOME/.Xresources'
alias i3c='vim $HOME/.config/i3/config'
alias i3s='vim $HOME/.config/i3/status.toml'
alias xres='vim $HOME/.Xresources'
alias ls='ls --color=auto'
alias pcount='ps hax -o user | sort | uniq -c'
alias week='date +%V'
alias path="tr : '\n' <<<$PATH"
alias perm=" stat -c '%A %a %n' * "
alias grep='grep --color=always'
alias hdmi="xrandr --output eDP1 --off --output HDMI1 --mode 1920x1080i --pos 0x0 --rotate normal --output VIRTUAL1 --off"
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'

## Pacman Commands 

# Theming section  
#autoload -Uz compinit 
#compinit -d
#colors

#function zle-line-init zle-keymap-select {
#  PROMPT=`/home/alii/.zsh/purs/target/release/purs prompt -k "$KEYMAP" -r "$?" --venv "${${VIRTUAL_ENV:t}%-*}"`
#  zle reset-prompt
#}
#zle -N zle-line-init
#zle -N zle-keymap-select
#
#autoload -Uz add-zsh-hook
#
#function _prompt_purs_precmd() {
#  /home/alii/.zsh/purs/target/release/purs precmd
#}
#add-zsh-hook precmd _prompt_purs_precmd
#

autoload -U promptinit && promptinit
prompt pure

#enable substitution for prompt
#setopt prompt_subst 



# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r


## Plugins section: Enable fish style features
# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys to history substring search
#source /home/alii/ohmyzsh/plugins/vi-mode/vi-mode.plugin.zsh
zmodload zsh/terminfo

#plugins=(
#    git
#    z
#    )

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down

# Apply different settigns for different terminals
case $(basename "$(cat "/proc/$PPID/comm")") in
  login)
    	RPROMPT="%{$fg[red]%} %(?..[%?])" 
    	alias x='startx ~/.xinitrc'      # Type name of desired desktop after x, xinitrc is configured for it
    ;;
  *)
       # RPROMPT='$(git_prompt_string)'
		 #Use autosuggestion
		source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
		ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
  		ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
    ;;

esac

function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
function pkglist() {  pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S }

#export PATH="$HOME/Utilities/julia-1.0.5/bin":$PATH
export PATH="$HOME/.local/bin:$PATH"


# Import colorscheme from 'wal' asynchronously
# # &   # Run the process in the background.
# # ( ) # Hide shell job control messages.
(cat ~/.config/wpg/sequences &)
#(cat ~/.cache/wal/sequences &)
#
# # Alternative (blocks terminal for 0-3ms)
# cat ~/.cache/wal/sequences
#
# # To add support for TTYs this line can be optionally added.
#cat ~/.cache/wal/sequences
 source ~/.cache/wal/colors-tty.sh
 wal-tile() {
     wal -n -i "$@"
     feh --bg-tile "$(< "${HOME}/.cache/wal/wal")"
 }

source /home/alii/.zsh/fzf/completion.zsh
source /home/alii/.zsh/fzf/key-bindings.zsh






# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/alii/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/alii/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/alii/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/alii/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

