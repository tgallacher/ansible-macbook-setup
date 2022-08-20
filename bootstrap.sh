#! /usr/bin/env bash
#
# Bootstrap
#   Primary entrypoint for setting up a new Mac.
#   This scrip will run all steps required to get a baseline config for a new OSX device.
#   This includes running the Ansible steps.
#
# NB: The Ansible steps can be run separately.
#     This script _SHOULD_ only be run on a fresh OSX install.
#
# The pyhton install process is based on A ["right way to install python on OSX"](https://opensource.com/article/19/5/python-3-default-mac).
#

_BOOTSTRAP_SEMAPHORE_FILENAME='.macbook-bootstrap-semaphore'

# Make sure we only run this script once, on any given OSX device
if [[ ! -f "$HOME/$_BOOTSTRAP_SEMAPHORE_FILENAME" ]]; then
  echo
  echo "NOTE: First time running this script."
  echo

  # Add semaphore so we know that this script has been run
  echo "Machine initially bootstrapped on:\n$(date)" >$HOME/$_BOOTSTRAP_SEMAPHORE_FILENAME

  # Install Homebrew - will ask for `sudo` - so we can install python correctly
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # we need latest python for latest Ansible features; gnu grep for automatically installing latest python version
  brew install pyenv grep
  # install latest stable python version
  PYTHON_VERS_LATEST="$(pyenv install --list | ggrep -P '^\s*(\d+\.\d+\.\d+(?!\w))' | tail -1 | tr -d '[:space:]')"
  pyenv install $PYTHON_VERS_LATEST
  # set as default version, globally
  pyenv global $PYTHON_VERS_LATEST
  # TODO: assumes zsh shell
  echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >>~/.tmp.zshrc

  source ~/.tmp.zshrc

  if [[ "$(which python)" != *'pyenv/shims/python'* ]]; then
    echo "ERROR::"
    echo "Pyenv isn't the default python binary."
    echo

    exit 1
  fi

  pip install ansible
fi

# Run Ansible
ansible-galaxy install -r requirements.yml
ansible-playbook -K main.yml
