#!/bin/bash

# Script to sync opencode/ files to ~/.config/opencode/
# This replaces files in ~/.config/opencode/ subfolders with files from opencode/ subfolders

set -e  # Exit on error

SOURCE_DIR="opencode"
TARGET_DIR="$HOME/.config/opencode"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== OpenCode Sync Script ===${NC}"
echo -e "${BLUE}Source: ${SOURCE_DIR}${NC}"
echo -e "${BLUE}Target: ${TARGET_DIR}${NC}"
echo ""

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}Error: Source directory '$SOURCE_DIR' does not exist${NC}"
    echo -e "${YELLOW}Please run this script from the marat_ai project root${NC}"
    exit 1
fi

# Create target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${YELLOW}Target directory does not exist. Creating: ${TARGET_DIR}${NC}"
    mkdir -p "$TARGET_DIR"
fi

# Function to copy files recursively
sync_files() {
    local src="$1"
    local dst="$2"

    # Find all files in source directory
    find "$src" -type f | while read -r src_file; do
        # Get relative path from source directory
        rel_path="${src_file#$src/}"

        # Skip .DS_Store files
        if [[ "$rel_path" == *".DS_Store"* ]]; then
            continue
        fi

        # Construct destination path
        dst_file="$dst/$rel_path"
        dst_dir="$(dirname "$dst_file")"

        # Create destination directory if it doesn't exist
        if [ ! -d "$dst_dir" ]; then
            echo -e "${YELLOW}Creating directory: ${dst_dir}${NC}"
            mkdir -p "$dst_dir"
        fi

        # Copy file
        if [ -f "$dst_file" ]; then
            echo -e "${GREEN}Replacing: ${rel_path}${NC}"
        else
            echo -e "${GREEN}Creating: ${rel_path}${NC}"
        fi
        cp "$src_file" "$dst_file"
    done
}

# Sync files
sync_files "$SOURCE_DIR" "$TARGET_DIR"

echo ""
echo -e "${BLUE}=== Sync Complete ===${NC}"
echo -e "${GREEN}All files from ${SOURCE_DIR}/ have been synced to ${TARGET_DIR}/${NC}"
