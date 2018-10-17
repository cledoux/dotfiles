#!/bin/bash
# Apply a stow command to all packages in current directory.
# Passes all options to each individual stow command

# 'Strict' mode
set -euf -o pipefail
IFS=$'\n\t'

# List packages to stow.
# Grabs all directories out of the current directory.
# Ignores the '.' indicator, all .git* directories, and ./bin.
packages=$(find . -maxdepth 1 -type d ! -name '.git*' ! -name '.' !  -name 'bin' -printf "%f\n")

for p in $packages; do
    stow $@ $p
done

echo "Done."
