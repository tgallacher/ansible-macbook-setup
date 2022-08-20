# MacBook Ansible Playbook

Ansible playbook to configure and manage my Mac(s). A much overdue attempt to bring consistency between macbooks used for work, home, etc and to self document changes I want to keep -- and can never remember why/what I changed when I find something new.

> This is heavily based on and inspired by the fantastic work by [Jeff Geerling](https://github.com/geerlingguy) and his [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook).

<!-- TOC -->

- [Installation](#installation)
  - [First time run](#first-time-run)
  - [Running after updates](#running-after-updates)
  - [Running a specific set of tagged tasks](#running-a-specific-set-of-tagged-tasks)
- [Customising](#customising)
- [Testing the Playbook](#testing-the-playbook)

<!-- /TOC -->

<a id="markdown-installation" name="installation"></a>

## Installation

<a id="markdown-first-time-run" name="first-time-run"></a>

### First time run

There is a cyclic dependency here: we use Ansible to automate most of the config and setup, but that requires Python v3+, which we want to install using [Homebrew](https://brew.sh). Therefore, we need a few manual tasks first before we kick on automation wheel. To semi-automate these steps, and maintain a more up to date list, see -- and use -- `bootstrap.sh`.

The `bootstrap.sh` file will also run ansible for you!

<a id="markdown-running-after-updates" name="running-after-updates"></a>

### Running after updates

1. Run `ansible-galaxy install -r requirements.yml`;
1. Run `ansible-playbook -K main.yml` inside this directory. Enter your account password when prompted.

> Note: If some Homebrew commands fail, you might need to agree to Xcode's license or fix some other Homebrew issue. Run `brew doctor` to see if this is the case.

<a id="markdown-running-a-specific-set-of-tagged-tasks" name="running-a-specific-set-of-tagged-tasks"></a>

### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying the set of tags using `ansible-playbook`'s `--tags` flag. The tags available:

- `tools` - Taks relating to installing tooling
- `config` - Taks relating to custom configuration of the OS
- `ui` - Tasks affecting the OS UI

Example:

```sh
$ ansible-playbook main.yml -i inventory -K --tags "config"
```

<a id="markdown-customising" name="customising"></a>

## Customising

To see what variables exist for cusotmising the install, check the `defaults/*.yml` files or the docs for the installed ansible roles.

Running this playbook without any changes will bring in my dev setup on your mac; this is almost certainly _not_ what you're after. Instead, override the defaults by supplying any file named `config*.yml`. For example, you can customize the installed packages and apps with something like:

```yaml
# Use `homebrew_installed_packages` to override all installed formulae with your own choice
# Use `homebrew_installed_addn_packages` to add additional formulae whilst retaining my default ones
#
# Same variables apply for Casks. See `defaults/homebrew.yml`
homebrew_installed_packages:
  - cowsay
  - git
  - go
```

My [dotfiles](https://github.com/tgallacher/dotfiles) are also installed, in addition to an `.osx` script for configuring OSX to my preference.

Finally, there are a few other preferences and settings added on for various apps and services.

<a id="markdown-testing-the-playbook" name="testing-the-playbook"></a>

## Testing the Playbook

Changes are tested in a fresh install of OSX in a VM (using VirtualBox) before being run on a new Mac. This is based [Jeff's approach](https://github.com/geerlingguy/mac-osx-virtualbox-vm), although I have curated my own instructions for this process [here](./docs/vm-testing.md).
