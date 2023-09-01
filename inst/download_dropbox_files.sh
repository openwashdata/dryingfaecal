#!/bin/bash

# Define the path to the file containing the links
file_path="./data-raw/links.txt"

# Read the links from the file line by line and download using wget
while IFS= read -r link
do
  # Remove leading/trailing whitespace from the link
  link=$(echo "$link" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

  # Extract the file name from the link
  filename=$(basename "$link")

  # Download the link using wget
  wget "$link" -O "./data-raw/experiment/$filename"
done < "$file_path"
