 # Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

# Essential
source ~/.zplug/init.zsh
# Make sure to not use double quotes to prevent shell expansion
# Add a bunch more of your favorite packages!

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'denysdovhan/spaceship-prompt', use:spaceship.zsh, from:github, as:theme
zplug 'mafredri/zsh-async', from:github
#zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions", defer:2 # Normal mode space for execute it
zplug "hlissner/zsh-autopair", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "zsh-users/zsh-history-substring-search", defer:3

# Install packages that have not been installed yet
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  else
    echo
  fi
fi

zplug load
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY # Do not execute immediately upon history expansion

setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"
# http://stackoverflow.com/a/12575883
autoload -Uz compinit  #-D #don't build every time deadly slow
compinit
autopair-init
# End of lines added by compinstall
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt PATH_DIRS           # Perform path search even on command names with slashes.
setopt AUTO_MENU           # Show completion menu on a successive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
unsetopt MENU_COMPLETE     # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL      # Disable start/stop characters in shell editor.
unsetopt nomatch           # git show HEAD^ returns zsh: no matches found: HEAD^

# https://github.com/sorin-ionescu/prezto/blob/master/modules/directory/init.zsh
# Folder options
setopt AUTO_PUSHD        # Push the old folder onto the stack
setopt PUSHD_SILENT      # Do not print directory after pushd or popd.
setopt EXTENDED_GLOB     # Use extended globbing syntax.
setopt PUSHD_IGNORE_DUPS # Do not store duplicates in the stack.

# Show bottom up hierarchy of folders of the stack except the current folder
alias d='dirs -v | tail +2'
# Type a number and enter to go to that position in the folder stack
for index ({1..9}) alias "$index"="cd +${index}"; unset index

#https://github.com/sorin-ionescu/prezto/blob/master/modules/environment/init.zsh
# Jobs
setopt LONG_LIST_JOBS     # List jobs in the long format by default.
setopt AUTO_RESUME        # Attempt to resume existing job before creating a new process.
setopt NOTIFY             # Report status of background jobs immediately.
unsetopt BG_NICE          # Don't run all background jobs at a lower priority.
unsetopt HUP              # Don't kill jobs on shell exit.
#unsetopt CHECK_JOBS # Don't report on jobs when shell exit

# less with color
export LESS_TERMCAP_mb=$'\E[01;31m'    # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'    # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'        # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'        # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m' # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'        # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'    # Begins underline

export SPACESHIP_NODE_DEFAULT_VERSION="$(node -v)"
export SPACESHIP_JOBS_SYMBOL=''
export SPACESHIP_JOBS_SUFFIX=' \e[36mjobs\e[0m '
export SPACESHIP_JOBS_SHOW_AMOUNT='always'
export SPACESHIP_USER_SHOW='always'
export SPACESHIP_USER_SUFFIX=''
export SPACESHIP_HOST_SHOW='always'
export SPACESHIP_HOST_PREFIX='@'
export SPACESHIP_DIR_TRUNC=0
export SPACESHIP_DIR_TRUNC_REPO=false
export SPACESHIP_TIME_SHOW=true

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  dotnet        # .NET section
  ember         # Ember.js section
  kubecontext   # Kubectl context section
  exec_time     # Execution time
  time          # Time stampts section
  line_sep      # Line break
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z }'
# Autocomplete man pages search
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

# Ctrl-R provided by fzf

# Normal mode space for execute suggest
#https://wiki.archlinux.org/index.php/Zsh#Key_bindings
bindkey -M vicmd ' ' autosuggest-execute
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
#
#alias vim='nvim' # I don't like neovim by now

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --no-ignore --follow --exclude .git'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# To apply the command to ALT_C
export FZF_ALT_C_COMMAND='fd --type d --hidden --no-ignore --follow --exclude .git'

alias bc='bc -l'
# github wrapper to extend git
alias git=hub
alias g=git

alias ls='ls --color=auto -lah'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zprofile
# respect the color
export LESS='-F -g -i -M -R -S -w -X -z-4'
export PAGER='less'
# open command
alias open=xdg-open
# Never use vi
alias vi='vim'
alias v='vim'
alias n='nvim'
alias h='history'
alias du='du -h'
alias df='df -h'
# Vim as default editor
export EDITOR=vim
export VISUAL=vim
export TMPDIR='/tmp'
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

if [ -x "$(command -v "firefox-developer-edition")" ]; then
  alias firefox='firefox-developer-edition'
  export BROWSER='firefox-developer-edition'
else
  export BROWSER='firefox'
fi

alias stmux="tmuxinator"
alias j="jobs -l"

function mount {
  if [ -z "$1" ]; then
    /usr/bin/mount | column -t
  else
    /usr/bin/mount "$@"
  fi
}


# ctrl-Z for recovering vim in background
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
# Safe ops. Ask the user before doing anything destructive.
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias ln="ln -i"
unsetopt CLOBBER # Do not overwrite existing files with > and >>. # Use >! and >>! to bypass.

[[ ! -f ~/.local/share/fonts/'Inconsolata Nerd Font Complete.otf' ]] && mkdir -p ~/.local/share/fonts && pushd ~/.local/share/fonts && curl -fLo 'Inconsolata Nerd Font Complete.otf' 'https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Inconsolata/complete/Inconsolata%20Nerd%20Font%20Complete.otf?raw=true' && popd

alias rm='(>&2 echo "\e[1m\e[31mPlease: use \"trash\" or \"trash-put\" commands!\e[0m"); false'

alias youtube-dl-mp3='youtube-dl --extract-audio --audio-format mp3'

# FZF config
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# https://github.com/junegunn/fzf/wiki/Examples#changing-directory
b (){
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  #local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  # I prefer the original order
  # and remove the current folder
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | tail -n+2 | fzf-tmux)
  cd "$DIR"
}

eval $(thefuck --alias)
alias f='fuck -y'

# https://github.com/zimfw/zimfw/blob/master/modules/utility/init.zsh
if [ -x "$(command -v "aria2c")" ]; then
  alias get='aria2c --max-connection-per-server=5 --continue'
elif [ -x "$(command -v "axel")" ]; then
  alias get='axel --num-connections=5 --alternate'
elif [ -x "$(command -v "axel")" ]; then
  alias get='wget --continue --progress=bar --timestamping'
elif [ -x "$(command -v "curl")" ]; then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
fi

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Interactive shell also with aliases and functions of a not interactive shell
# source "${ZDOTDIR:-$HOME}/.zshenv"

# Remove weird message: sessions should be nested with care, unset $TMUX to force
if [ "$TMUX" == "" ]; then
    tmux new-session
fi

# enable vi mode
bindkey -v

# http://zshwiki.org/home/zle/bindkeys#reading_terminfo
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

# setup key accordingly
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
# vi bad behaviour (https://unix.stackexchange.com/a/290403)
bindkey -v '^?' backward-delete-char
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-history
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-history
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi
