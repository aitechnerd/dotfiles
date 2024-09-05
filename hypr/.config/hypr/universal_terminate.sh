#!/bin/bash

# Function to get the class of the active window
get_active_window_class() {
    hyprctl activewindow -j | jq -r .class
}

# Function to terminate an app
terminate_app() {
    app_class=$1
    
    # Close the active window
    hyprctl dispatch killactive

    # Wait a moment for the window to close
    sleep 0.5

    # Check if any processes for the app are still running
    if pgrep -f "$app_class" > /dev/null; then
        # If processes are found, forcefully terminate them
        pkill -9 -f "$app_class"
        echo "$app_class processes forcefully terminated."
    else
        echo "$app_class closed successfully."
    fi
}

# Get the class of the active window
active_window_class=$(get_active_window_class)

# Terminate the app
terminate_app "$active_window_class"