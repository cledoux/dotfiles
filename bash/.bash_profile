if [ -f "${HOME}/.bashrc" ] ; then
    source "${HOME}/.bashrc"
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
