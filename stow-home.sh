#!/bin/bash

# Stow something in the home directory.
# This exists because .stowrc doesn't support $HOME expansion.
stow -vv --target=$HOME $@
