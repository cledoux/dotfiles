#!/bin/bash 
set -eu

usage="Usage:\n
generate-make [target]\n
\n
Target is the name of the main .tex file without the .tex extention.\n
This will default to main.\n
"

target=${1-main}

if [[ $target == "-h" || $target == "--help" ]]; then
    echo -e $usage
    exit 0
fi

wget https://raw.github.com/ransford/pdflatex-makefile/master/Makefile.include

echo -e "TARGET=$target\ninclude Makefile.include" > Makefile
