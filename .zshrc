# Created by newuser for 4.3.9

# base settings # 
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


# completion settings #

autoload -U compinit
compinit

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


# history settings #

HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

setopt hist_expand extended_history inc_append_history share_history 
setopt hist_ignore_all_dups
setopt hist_ignore_space hist_reduce_blanks
setopt hist_verify hist_allow_clobber
setopt hist_no_store


bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward


# alias #

alias rr="rm -rf"
alias rm="rm -i"
alias dh="df -h"

alias pd="popd"
alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"'

alias tarcz="tar cvzf"
alias tarxz="tar xvzf"
alias tarcj="tar cvjf"
alias tarxj="tar xvjf"

case "${OSTYPE}" in
  freebsd*|darwin*)
  alias ls="ls -G -w"
  ;;
  linux*)
  alias ls="ls --color"
  ;;
esac

alias la="ls -lhAF"
alias ps="ps -fU`whoami` --forest"

alias sub="perl -pi -e"
alias psh="perl -de 1"

alias findall="sudo find / -name"
alias findhere="find ./ -name"

alias cl="tmux default-path $PWD; tmux new-window"

alias key="sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys"

alias shut="sudo shutdown -h now"

alias cupmen3="sleep 180 && notify-send 'カップめんできたよ！'"
alias cupmen5="sleep 300 && notify-send 'カップめんできたよ！'"

alias awetest="Xephyr -ac -br -noreset -screen 800x600 :1 & sleep 1 && DISPLAY=:1.0 awesome -c ~/.config/awesome/rc.lua"

md(){ mkdir -p $1; cd $1 }


alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

alias -g W='| wc -l'

alias -g D="DISPLAY=:0.0"

alias -g ED="export DISPLAY=:0.0"

alias -g EG='|& egrep'
alias -g EH='|& head'
alias -g EL='|& less -R'
alias -g ELS='|& less -S -R'
alias -g ETL='|& tail -20'
alias -g ET='|& tail'
alias -g F=' | fmt -'
alias -g G='| egrep'

alias -g H='| head'
alias -g HL='|& head -20'

alias -g NZ="*~(*.bz2|*.gz|*.tgz|*.zip|*.z)"

alias -g L="| less -R"
alias -g LL="2>&1 | less -R"
alias -g LS='| less -S -R'

alias -g M='| more'
alias -g MM='| most'

alias -g N=/dev/null
alias -g NE="2> /dev/null"
alias -g NULL="> /dev/null 2>&1"

alias -g S='| sort'
alias -g NS='| sort -n'
alias -g US='| sort -u'
alias -g NRS='| sort -nr'

alias -g T='| tail'
alias -g TL='| tail -20'

alias -g VM=/var/log/messages

alias -g X='| xargs'
alias -g X0='| xargs -0'
alias -g XG='| xargs egrep'
alias -g X0G='| xargs -0 egrep'

alias -g FA='find -P . -regex "\./[^.].*"'

if which pbcopy >/dev/null 2>&1 ; then
  # Mac
  alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
  # Linux
  alias -g C='| xsel --input --clipboard'
fi


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

# %{...%} は囲まれた文字列がエスケープシーケンスであることを明示する
# これをしないと右プロンプトの位置がずれる
echo "[%{$color%}$name%{$reset_color%}]"
}

setopt prompt_subst

PROMPT='`print "%{\e[0;36m%}%m:%~%{\e[0m%}"` `rprompt-git-current-branch`
`print "%{\e[1;33m%}%# %{\e[0m%}"`'


# home directory with \
expand-to-home-or-insert () {
  if [ "$LBUFFER" = "" -o "$LBUFFER[-1]" = " " ]; then
    LBUFFER+="~/"
  else
    LBUFFER+="\\"
  fi
}
zle -N expand-to-home-or-insert
bindkey "\\" expand-to-home-or-insert


# setting for tmux

if [ $SHLVL = 1 ]; then
  tmux
fi
