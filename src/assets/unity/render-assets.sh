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
ln -s close.svg close_focused_normal.svg
ln -s close_focused_prelight.svg close_unfocused_prelight.svg
ln -s close_focused_pressed.svg close_unfocused_pressed.svg
ln -s maximize.svg maximize_focused_normal.svg
ln -s maximize_focused_prelight.svg maximize_unfocused_prelight.svg
ln -s maximize_focused_pressed.svg maximize_unfocused_pressed.svg
ln -s minimize.svg minimize_focused_normal.svg
ln -s minimize_focused_prelight.svg minimize_unfocused_prelight.svg
ln -s minimize_focused_pressed.svg minimize_unfocused_pressed.svg
ln -s unmaximize.svg unmaximize_focused_normal.svg
ln -s unmaximize_focused_prelight.svg unmaximize_unfocused_prelight.svg
ln -s unmaximize_focused_pressed.svg unmaximize_unfocused_pressed.svg
#ln -s shade.svg shade_focused.svg
#ln -s shade.svg shade_focused_normal.svg
#ln -s shade_focused_prelight.svg shade_unfocused_prelight.svg
#ln -s shade_focused_pressed.svg shade_unfocused_pressed.svg
#ln -s unshade.svg unshade_focused.svg
#ln -s unshade.svg unshade_focused_normal.svg
#ln -s unshade_focused_prelight.svg unshade_unfocused_prelight.svg
#ln -s unshade_focused_pressed.svg unshade_unfocused_pressed.svg
#ln -s menu.svg menu_focused.svg
#ln -s menu.svg menu_focused_normal.svg
#ln -s menu_focused_prelight.svg menu_unfocused_prelight.svg
#ln -s menu_focused_pressed.svg menu_unfocused_pressed.svg

wait
exit 0
