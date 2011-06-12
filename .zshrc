# base settings

bindkey -e

autoload -U colors
colors

autoload -U promptinit
promptinit

setopt extended_glob

setopt auto_cd auto_pushd
setopt pushd_ignore_dups

setopt auto_name_dirs multios
setopt always_last_prompt prompt_subst
setopt sh_word_split brace_ccl

setopt no_tify no_beep

limit coredumpsize 0

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " ,/:@+|"
zstyle ':zle:*' word-style unspecified


# completion settings

autoload -U compinit
compinit -u

setopt auto_list list_packed list_ambiguous
setopt auto_param_slash auto_remove_slash 
setopt auto_param_keys
setopt list_types rec_exact 

zstyle ':completion:*' use-cache true
zstyle ':completion:*' completer _complete _approximate _prefix _match
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:default*' ignore-parents pwd
zstyle ':completion:*:approximate:*' max-errors 1 NUMERIC
zstyle ':completion:*:processes' menu yes select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

LISTMAX=1000


# history settings

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_expand inc_append_history share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space hist_reduce_blanks
setopt hist_verify hist_allow_clobber
setopt hist_no_store


bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward


# prompt settings

function rprompt-git-current-branch {
local name st color

if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
  return
fi
name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
if [[ -z $name ]]; then
  return
fi
st=`git status 2> /dev/null`
if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
  color=${fg[green]}
elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
  color=${fg[yellow]}
elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
  color=${fg_bold[red]}
else
  color=${fg[red]}
fi

# %{...%} surrounds escape string
echo "[%{$color%}$name%{$reset_color%}]"
}

setopt prompt_subst

PROMPT='`print "%{\e[0;36m%}%m:%~%{\e[0m%}"` `rprompt-git-current-branch`
`print "%{\e[1;33m%}%# %{\e[0m%}"`'


# include other files

source ~/.zshalias
source ~/.zshenv


# source external file

source ~/.zsh/git-completion.bash

source ~/.zsh/zaw.zsh

# bind for zaw

zsh-history() {
  zaw zaw-src-history
}

zle -N zsh-history
bindkey "^H" zsh-history

zsh-gitfiles() {
  zaw zaw-src-git-files
}

zle -N zsh-gitfiles
bindkey "^F" zsh-gitfiles


# source local zshrc

if [ -e ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi


# for tmux

if [ $SHLVL = 1 ]; then
  tmux
fi
