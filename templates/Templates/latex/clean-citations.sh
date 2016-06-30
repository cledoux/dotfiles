#!/bin/bash

usage() {
cat<<EOF
Usage: $0 [options] [citation-file]

Clean up an unedited zotero exported .bib file.

If citation file is not provided, defaults to ./citations.bib

Entries Removed:
   abstract
   file
   url
Cleaned Up:
   Improper {( nesting

OPTIONS:
 -h:    Show this message
EOF
}

while getopts "hi:" OPTION; do
    case $OPTION in
        h)
            usage
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

# Set default value if needed
CITE_FILE=${1-citations.bib}

echo "Fixing file $CITE_FILE"

# Make sure our input is actually a file
if [[ ! -f $CITE_FILE ]]; then
    echo "$CITE_FILE is not a file"
    exit 1
fi

echo "Removing abstracts"
sed -i '/^\s*abstract = /d' $CITE_FILE
echo "Removing file entries"
sed -i '/^\s*file = /d' $CITE_FILE
echo "Removing url entries"
sed -i '/^\s*url =/d' $CITE_FILE
echo "Cleaning (} mess"
sed -i 's/(}/}(/g' $CITE_FILE
echo "Removing colons"
sed -i 's/:_/_/' $CITE_FILE
echo "Removing non-existant years in cite keys"
sed -i 's/_????,$/,/' $CITE_FILE
