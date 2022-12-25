#! /usr/bin/env bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

SRC_FILE="assets.svg"
ASSETS_DIR="assets"
INDEX="assets.txt"

# check command avalibility
has_command() {
  "$1" -v $1 > /dev/null 2>&1
}

rm -rf "$ASSETS_DIR"
mkdir -p $ASSETS_DIR

for i in `cat $INDEX`
do
    file="$ASSETS_DIR/$i.png"

    if [ $(jobs -p | wc -l) -ge ${BUILD_THREADS} ]; then wait; fi
    echo Rendering "$file"
    
    $INKSCAPE --export-id=$i  \
              --export-id-only \
              --export-filename="$file" $SRC_FILE >/dev/null 2>&1 &&
    $OPTIPNG -o7 --quiet "$file" &
done

# links
cd $ASSETS_DIR
ln -s close.png close_focused_normal.png
ln -s close_focused_prelight.png close_unfocused_prelight.png
ln -s close_focused_pressed.png close_unfocused_pressed.png
ln -s maximize.png maximize_focused_normal.png
ln -s maximize_focused_prelight.png maximize_unfocused_prelight.png
ln -s maximize_focused_pressed.png maximize_unfocused_pressed.png
ln -s minimize.png minimize_focused_normal.png
ln -s minimize_focused_prelight.png minimize_unfocused_prelight.png
ln -s minimize_focused_pressed.png minimize_unfocused_pressed.png
ln -s unmaximize.png unmaximize_focused_normal.png
ln -s unmaximize_focused_prelight.png unmaximize_unfocused_prelight.png
ln -s unmaximize_focused_pressed.png unmaximize_unfocused_pressed.png

wait
exit 0
