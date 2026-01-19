#!/bin/bash

# Find and delete all .gdb folders in the NaFRA2 directory
find /Users/drowe/Documents/git/nafra2-database -type d -name "*.gdb" -exec rm -rf {} +