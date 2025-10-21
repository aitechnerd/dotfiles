#!/usr/bin/env bash

INT="eDP-1"
WS_RANGE=(1 2 3 4 5 6 7 8 9 10)


# move + layout function
move_and_layout() {
  local LAYOUT=$1   # e.g. "monocle" or "custom:1,1,1"
  for WS in "${WS_RANGE[@]}"; do
    # switch workspace, apply layout
    hyprctl dispatch workspace "$WS"
    #hyprctl dispatch layout "$LAYOUT"
    hyprctl keyword general:layout $LAYOUT
    # move any clients on that WS onto the focused monitor
    for C in $(hyprctl clients -j \
                | jq -r ".[] | select(.workspace==$WS) | .address"); do
      hyprctl dispatch movetoworkspace "$WS,$C"
    done
  done
}


# Main
case "$1" in
  external)
    hyprctl keyword monitor "$INT,disable"
    move_and_layout "master"
    ;;
  laptop)
    hyprctl keyword monitor "$INT,1920x1200@60.00300,auto,1"
    move_and_layout "dwindle"
    ;;
  *)
    echo "Usage: $0 {external|laptop}"
    exit 1
    ;;
esac