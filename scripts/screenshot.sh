#!/usr/bin/env bash

# save directory
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"

# screenshot type
case "$1" in
"full")
  # full-screen screenshot using grim
  FILENAME="Screenshot ($(($(find "$SCREENSHOT_DIR" -maxdepth 1 -name 'Screenshot*.png' 2>/dev/null | wc -l) + 1))).png"
  grim - | wl-copy && wl-paste >"$SCREENSHOT_DIR/$FILENAME"
  ;;
"partial")
  # partial screenshot with region selection using slurp
  FILENAME="Screenshot ($(($(find "$SCREENSHOT_DIR" -maxdepth 1 -name 'Screenshot*.png' 2>/dev/null | wc -l) + 1))).png"
  grim -g "$(slurp)" - | wl-copy && wl-paste >"$SCREENSHOT_DIR/$FILENAME"
  ;;
*)
  echo "Invalid argument"
  exit 1
  ;;
esac

# check if the file is non-empty (valid screenshot)
if [ -s "$SCREENSHOT_DIR/$FILENAME" ]; then
  # notification
  notify-send "$FILENAME saved in $SCREENSHOT_DIR"
else
  # if the file is empty, remove it
  rm "$SCREENSHOT_DIR/$FILENAME"
fi
