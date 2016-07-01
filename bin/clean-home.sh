#!/bin/bash

# Clean all broken links from home directory.
find $HOME -xtype l -delete
