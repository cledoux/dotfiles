#!/bin/bash
# Apply a stow command to all packages in current directory.
# Passes all options to each individual stow command

# 'Strict' mode
set -euf -o pipefail
IFS=$'\n\t'

# Script directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Stow comm# List packages to stow.
# Grabs all directories out of the current directory.
# Ignores the '.' indicator, all .git* directories, the archived
# configs, and ./bin.
packages=$(find . -maxdepth 1 -type d ! -name '.git*' ! -name '.' !  -name 'bin' ! name 'archive' -printf "%f\n")

for p in $packages; do
    stow -vv --target=$HOME $@ $p
done

echo "Done."
