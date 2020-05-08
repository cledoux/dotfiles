# Charles LeDoux Personal Dotfiles Repo.

Repository for my (Charles) personal configuration files.

This repo contains personal information such as email addresses and should
not be directly shared with anyone.

# Troubleshooting

## I don't see any files

`ls -a`

These are dotfiles. Normal `ls` doesn't show dotfiles.

There's an autoenv config here for overwriting the behavior of `ls` when in
this directory. It's probably not worth installing autoenv just for
this, though.

## Vim and/or tmux is too old
Install the following repo:

    sudo apt-get install software-properties-common python-software-properties
    sudo add-apt-repository ppa:pi-rho/dev
    sudo apt-get update
    sudo apt-get install tmux

