export LANG=ja_JP.UTF-8
export EDITOR=vim
export MOZ_DISABLE_PANGO=1
export PATH=$PATH:$HOME/bin:/opt/TweetDeck/bin
export GNOME_DESKTOP_SESSION_ID=1

# source local zshenv

if [ -e ~/.zshenv.local ]; then
  source ~/.zshenv.local
fi
