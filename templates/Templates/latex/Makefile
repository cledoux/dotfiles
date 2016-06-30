# Bootstrap new paper into existing directory.
# Usage:
# 	make -f ~/Templates/latex/Makefile

# This makefile
mkfile := $(abspath $(lastword $(MAKEFILE_LIST)))
# Directory this makefile is in
mkdir := $(patsubst %/,%,$(dir $(mkfile)))

# Brand new latex paper.
new: $(CURDIR)/Makefile header.tex main.tex abstract.tex
	@echo "New LaTeX Project Ready."
	@echo "Edit Makefile to configure."
	@echo "`make zotero` to download citation.bib after configuring."

$(CURDIR)/Makefile: 
	cp $(mkdir)/Makefile.latex $(CURDIR)/Makefile

%.tex: $(mkdir)/%.tex
	cp $< $@

