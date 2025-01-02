#!/usr/bin/env bash

# save directory
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"

# screenshot type
case "$1" in
"full")
  # full-screen screenshot
  FILENAME="Screenshot ($(($(find "$SCREENSHOT_DIR" -maxdepth 1 -name 'Screenshot*.png' 2>/dev/null | wc -l) + 1))).png"
  grimblast copysave screen "$SCREENSHOT_DIR/$FILENAME"
  ;;
"partial")
  # partial screenshot with region selection
  FILENAME="Screenshot ($(($(find "$SCREENSHOT_DIR" -maxdepth 1 -name 'Screenshot*.png' 2>/dev/null | wc -l) + 1))).png"
  grimblast copysave area "$SCREENSHOT_DIR/$FILENAME"
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
