#!/usr/bin/zsh

if [[ -z "$ZSH_NAME" ]]; then
  zsh ${0}
  exit
fi

set -e # -e: exit on error

STARSHIP_FILE=/workspaces/.codespaces/.persistedshare/dotfiles/starship.sh
if [ ! -f $STARSHIP_FILE ] ; then
  curl https://starship.rs/install.sh > $STARSHIP_FILE
  sh $STARSHIP_FILE -y
fi

if [ ! "$(command -v chezmoi)" ]; then
  bin_dir="$HOME/.local/bin"
  mkdir "$HOME/.local/share/chezmoi"
  chezmoi="$bin_dir/chezmoi"
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$bin_dir"
  elif [ "$(command -v wget)" ]; then
    sh -c "$(wget -qO- https://git.io/chezmoi)" -- -b "$bin_dir"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
else
  chezmoi=chezmoi
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
"$chezmoi" init --apply "--source=$script_dir"

# Install required packages
sudo apt-get install -y lua5.3 > /dev/null

# Install zplug
export ZPLUG_HOME="/workspaces/.zplug"
if [ ! -d $ZPLUG_HOME ] ; then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME

  source $ZPLUG_HOME/init.zsh
  # Install plugins if there are plugins that have not been installed
  if ! zplug check --verbose; then
    zplug install
  fi
fi

# Fix compinit errors
compaudit | xargs chmod g-w
compaudit | xargs chmod a-w
