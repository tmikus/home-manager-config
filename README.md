## What is this

This repository contains configuration that is used to set-up a ready-to-use development environment according to my needs.

It can be used on a local desktop, laptop or on a cloud desktop.

The configuration is made portable with the use of the [Nix Home Manager](https://nix-community.github.io/home-manager/index.xhtm)

## Pre-requisites

In order to use this configuration you'll need to first install a Nix Home Manager on your device. To do that simply follow the steps from [Standalone Installation](https://nix-community.github.io/home-manager/index.xhtml#ch-installation) page, copied here for simplicity:

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install
```

## Installation

Once you have the Home Manager installed, simply clone this repository in `~/.config/home-manager` and run `home-manager switch`

```bash
cd ~/.config/home-manager/
nix-shell -p git # Open a new shell with git enabled

git clone https://github.com/tmikus/nix-config.git
exit # exit the git-enabled shell

home-manager switch
```
