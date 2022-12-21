#! /usr/bin/env/ bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

SRC_FILE="assets-light.svg"
DARK_SRC_FILE="assets-dark.svg"
ASSETS_DIR="assets-light"
DARK_ASSETS_DIR="assets-dark"

INDEX="assets.txt"

# check command avalibility
has_command() {
  "$1" -v $1 > /dev/null 2>&1
}

rm -rf "$ASSETS_DIR" "$DARK_ASSETS_DIR"
mkdir -p $ASSETS_DIR && mkdir -p $DARK_ASSETS_DIR

for i in `cat $INDEX`
do
    echo
    echo Rendering $ASSETS_DIR/$i.png

    $INKSCAPE --export-id=$i \
              --export-id-only \
              --export-filename=$ASSETS_DIR/$i.png $SRC_FILE >/dev/null
    $OPTIPNG -o7 --quiet $ASSETS_DIR/$i.png

    echo
    echo Rendering $DARK_ASSETS_DIR/$i.png

    $INKSCAPE --export-id=$i \
              --export-id-only \
              --export-filename=$DARK_ASSETS_DIR/$i.png $DARK_SRC_FILE >/dev/null

    $OPTIPNG -o7 --quiet $DARK_ASSETS_DIR/$i.png
done
exit 0
