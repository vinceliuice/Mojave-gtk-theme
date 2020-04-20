#! /bin/bash

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

mkdir -p $ASSETS_DIR && mkdir -p $DARK_ASSETS_DIR

for i in `cat $INDEX`
do
if [ -f $ASSETS_DIR/$i.png ]; then
    echo $ASSETS_DIR/$i.png exists.
else
    echo
    echo Rendering $ASSETS_DIR/$i.png

    if has_command dnf; then
      $INKSCAPE --export-id=$i \
                --export-id-only \
                --export-type="png" $SRC_FILE >/dev/null
    else
      $INKSCAPE --export-id=$i \
                --export-id-only \
                --export-png=$ASSETS_DIR/$i.png $SRC_FILE >/dev/null
    fi

    $OPTIPNG -o7 --quiet $ASSETS_DIR/$i.png
fi
if [ -f $DARK_ASSETS_DIR/$i.png ]; then
    echo $DARK_ASSETS_DIR/$i.png exists.
else
    echo
    echo Rendering $DARK_ASSETS_DIR/$i.png

    if has_command dnf; then
      $INKSCAPE --export-id=$i \
                --export-id-only \
                --export-type="png" $DARK_SRC_FILE >/dev/null
    else
      $INKSCAPE --export-id=$i \
                --export-id-only \
                --export-png=$DARK_ASSETS_DIR/$i.png $DARK_SRC_FILE >/dev/null
    fi

    $OPTIPNG -o7 --quiet $DARK_ASSETS_DIR/$i.png
fi
done
exit 0
