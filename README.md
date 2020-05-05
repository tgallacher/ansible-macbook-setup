<img src="https://raw.githubusercontent.com/geerlingguy/mac-dev-playbook/master/files/Mac-Dev-Playbook-Logo.png" width="250" height="156" alt="Mac Dev Playbook Logo" />

# MacBook Ansible Playbook

An Ansible playbook to configure and manage my Mac set up. Primary aim is consistency between macbooks used for work, home, etc and to self document changes I want to keep -- can never remember why/what I changed when I find something new.

> This is based on the stellar work by [Jeff Geerling](https://github.com/geerlingguy) and his [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook).

## Installation

1. Ensure Apple's command line tools are installed (`xcode-select --install` to launch the installer).
1. Basic install of [homebrew](https://brew.sh/)
1. Install Ansible - `brew install ansible`
1. Clone this repository to your local drive
1. `cd` into the repository root
1. Run `ansible-galaxy install -r requirements.yml`
1. Run `ansible-playbook -K main.yml` inside this directory. Enter your account password when prompted.

> Note: We only need the basic Homebrew install to get us Ansible, as I haven't found pip install of ansible to be reliable due to the python 2 vs 3 transition

> Note: This playbook will also complete the configuration of Ansible as well; so no need to do it beforehand.

> Note: If some Homebrew commands fail, you might need to agree to Xcode's license or fix some other Brew issue. Run `brew doctor` to see if this is the case.

### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying the set of tags using `ansible-playbook`'s `--tags` flag. The tags available:

- _dotfiles_
- _homebrew_
- _mas_
- _osx_
- _apps_

```sh
$ ansible-playbook main.yml -i inventory -K --tags "dotfiles,homebrew"
```

## Overriding Defaults

You can override any of the defaults configured in `default.config.yml` by creating a `config.yml` file and setting the overrides in that file. For example, you can customize the installed packages and apps with something like:

```yaml
homebrew_installed_packages:
  - cowsay
  - git
  - go

mas_installed_apps:
  - { id: 443987910, name: "1Password" }
  - { id: 498486288, name: "Quick Resizer" }
  - { id: 557168941, name: "Tweetbot" }
  - { id: 497799835, name: "Xcode" }
```

Any variable can be overridden in `config.yml`; see the supporting roles' documentation for a complete list of available variables.

My [dotfiles](https://github.com/tgallacher/dotfiles) are also installed, in addition to an `.osx` dotfile script for configuring many aspects of macOS for better performance and ease of use.

dotfiles management can be disabled by setting `configure_dotfiles: no` in your configuration.

Finally, there are a few other preferences and settings added on for various apps and services.

## Future additions

### Configuration to be added:

- I have vim configuration in the repo, but I still need to add the actual installation:
  ```
  mkdir -p ~/.vim/autoload
  mkdir -p ~/.vim/bundle
  cd ~/.vim/autoload
  curl https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim > pathogen.vim
  cd ~/.vim/bundle
  git clone git://github.com/scrooloose/nerdtree.git
  ```

## Testing the Playbook

Like in the original set up, [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook) by Jeff Geerling, changes are tested using his [Mac OS X VirtualBox VM](https://github.com/geerlingguy/mac-osx-virtualbox-vm).
