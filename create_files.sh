#!/bin/bash

# Define the base directories
BASE_DIR_ROFRS="NaFRA2/RoFRS"
BASE_DIR_ROFSW="NaFRA2/RoFSW/RoFSW"

NEW_DIR_ROFRS="RoFRS"
NEW_DIR_RoFSW="RoFSW"

# Function to unzip files in a directory
unzip_files_in_directory() {
  local base_dir=$1
  for tile_dir in "$base_dir"/*; do
    if [ -d "$tile_dir" ]; then
      for zip_file in "$tile_dir"/*.zip; do
        if [ -f "$zip_file" ]; then
          # If it is RoFRS and the filename does not include 'Climate_Change' unzip to NEW_DIR_ROFRS
          if [[ "$base_dir" == *"RoFRS"* && "$zip_file" != *"Climate_Change"* ]]; then
            echo "Moving contents to $NEW_DIR_ROFRS"
            unzip -o "$zip_file" -d "$NEW_DIR_ROFRS"
          fi
          # If it is RoFSW unzip to NEW_DIR_RoFSW
          if [[ "$base_dir" == *"RoFSW"* ]]; then
            echo "Moving contents to $NEW_DIR_RoFSW"
            unzip -o "$zip_file" -d "$NEW_DIR_RoFSW"
          fi
        fi
      done
    fi
  done
}

# Unzip files in both directories
unzip_files_in_directory "$BASE_DIR_ROFRS"
unzip_files_in_directory "$BASE_DIR_ROFSW"