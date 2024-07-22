#!/bin/bash

# Function to ask yes/no questions
ask_yes_no() {
    read -p "$1 (Y/N): " choice
    case "$choice" in 
        y|Y ) return 0;;
        n|N ) return 1;;
        * ) echo "Invalid input. Assuming no."; return 1;;
    esac
}


# Function to safely stow a directory
safe_stow() {
    local dir=$1
    local target=$2
    echo "Stowing $dir..."
    
    # Check for conflicts
    conflicts=$(stow -n -v -t "$target" "$dir" 2>&1 | grep -c "BUG IN STOW") || true
    
    if [ "$conflicts" -gt 0 ]; then
        echo "Conflicts found in $dir. Backing up and replacing..."
        for file in $(stow -n -v -t "$target" "$dir" 2>&1 | grep "BUG IN STOW" | awk '{print $NF}'); do
            mv "$target/$file" "$target/$file.backup"
        done
    fi
    
    stow -v -R -t "$target" "$dir"
}