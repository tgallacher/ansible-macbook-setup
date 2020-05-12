<img src="https://raw.githubusercontent.com/geerlingguy/mac-dev-playbook/master/files/Mac-Dev-Playbook-Logo.png" width="250" height="156" alt="Mac Dev Playbook Logo" />

# MacBook Ansible Playbook

Ansible playbook to configure and manage my dev Macs. A much overdue attempt to bring consistency between macbooks used for work, home, etc and to self document changes I want to keep -- can never remember why/what I changed when I find something new.

> This is heavily based on and inspired by the fantastic work by [Jeff Geerling](https://github.com/geerlingguy) and his [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook).

## Installation

1. Ensure Apple's command line tools are installed (`xcode-select --install` to launch the installer).
1. Install `pip` - `sudo easy_install pip`;
1. Ensure python dir is in PATH - `export PATH="~/Library/Python/<version>/bin:$PATH"`;
1. Install Ansible - `pip install ansible`;
1. Clone the repo and from the repo root;
1. Run `ansible-galaxy install -r requirements.yml`;
1. Run `ansible-playbook -K main.yml` inside this directory. Enter your account password when prompted.

> Note: If some Homebrew commands fail, you might need to agree to Xcode's license or fix some other Brew issue. Run `brew doctor` to see if this is the case.

### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying the set of tags using `ansible-playbook`'s `--tags` flag. The tags available:

- _core_
- _apps_

```sh
$ ansible-playbook main.yml -i inventory -K --tags "core"
```

## Overriding Defaults

Running this as-is will bring in my dev setup on your mac; this is almost certainly not what you want. Instead, the defaults can be overridden by supplying any file `config*.yml`. For example, you can customize the installed packages and apps with something like:

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
