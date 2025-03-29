#!/bin/bash

# Directory name
DIR_NAME="my_directory"

# Check if the directory already exists
if [ -d "$DIR_NAME" ]; then
  echo "Directory '$DIR_NAME' already exists."
else
  # Create the directory
  mkdir "$DIR_NAME"
  echo "Directory '$DIR_NAME' has been created."
fi
