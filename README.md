<img src="https://raw.githubusercontent.com/geerlingguy/mac-dev-playbook/master/files/Mac-Dev-Playbook-Logo.png" width="250" height="156" alt="Mac Dev Playbook Logo" />

# MacBook Ansible Playbook

Ansible playbook to configure and manage my dev Macs. A much overdue attempt to bring consistency between macbooks used for work, home, etc and to self document changes I want to keep -- and can never remember why/what I changed when I find something new.

> This is heavily based on and inspired by the fantastic work by [Jeff Geerling](https://github.com/geerlingguy) and his [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook).

## Installation

#### Prep: Installing Python (the right way)

A quick summary of how to install python the ["right way"](https://opensource.com/article/19/5/python-3-default-mac) on OSX:

1. Install `pyenv` using homebrew: `brew install pyenv`;
1. Find the latest (stable) version of python to install: `pyenv install --list` (3.8.2 at time of writing);
1. Install this version of python: `pyenv install 3.8.2`;
1. Set this to be the default version used: `pyenv global 3.8.2`;
1. Make sure your terminal defaults to pyenv for the python binary (instead of, say, OSX's default location): `echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.zshrc` (update terminal file depending on your terminal of choice)
1. Confirm everything is good:

```sh
$ exec $0
$ which python
/Users/<your_username>/.pyenv/shims/python
```

Good to continue with the installation.

#### Install + Run

1. Ensure Apple's command line tools are installed (`xcode-select --install` to launch the installer).
1. Install python (see prep notes);
1. Install Ansible using pip - `pip install ansible`;
1. Clone the repo and from the repo root;
1. Run `ansible-galaxy install -r requirements.yml`;
1. Run `ansible-playbook -K main.yml` inside this directory. Enter your account password when prompted.

> Note: If some Homebrew commands fail, you might need to agree to Xcode's license or fix some other Homebrew issue. Run `brew doctor` to see if this is the case.

> 🤔Note: There is some cyclic dependencies here: We need Homebrew to install / configure python to install Ansible, which installs Homebrew, pyenv, etc... Need to refine; FIXME

### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying the set of tags using `ansible-playbook`'s `--tags` flag. The tags available:

- _core_
- _apps_

```sh
$ ansible-playbook main.yml -i inventory -K --tags "core"
```

## Customising

To see what variables exist for cusotmising the install, check the `defaults/*.yml` files ore the docs for the installed ansible roles (see `requirements.yml` for a list of installed roles used in this playbook).

Running this playbook without any changes will bring in my dev setup on your mac; this is almost certainly _not_ what you are after. Instead, override the defaults by supplying any file named `config*.yml`. For example, you can customize the installed packages and apps with something like:

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

My [dotfiles](https://github.com/tgallacher/dotfiles) are also installed, in addition to an `.osx` script for configuring many aspects of macOS for better performance and ease of use (_although this needs some work_ and is currently disabled).

Finally, there are a few other preferences and settings added on for various apps and services.

## Testing the Playbook

Like in the original set up, [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook) by Jeff Geerling, changes are tested using his [Mac OS X VirtualBox VM](https://github.com/geerlingguy/mac-osx-virtualbox-vm) before being deployed on any of my macs.
