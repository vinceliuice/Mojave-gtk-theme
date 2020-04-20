#! /bin/bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

SRC_FILE="assets.svg"
ASSETS_DIR="assets"
INDEX="assets.txt"

# check command avalibility
has_command() {
  "$1" -v $1 > /dev/null 2>&1
}

mkdir -p $ASSETS_DIR

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

if [ -f $ASSETS_DIR/$i@2.png ]; then
    echo $ASSETS_DIR/$i@2.png exists.
else
    echo
    echo Rendering $ASSETS_DIR/$i@2.png

    if has_command dnf; then
      $INKSCAPE --export-id=$i \
                --export-dpi=180 \
                --export-id-only \
                --export-type="png" $SRC_FILE >/dev/null
    else
      $INKSCAPE --export-id=$i \
                --export-dpi=180 \
                --export-id-only \
                --export-png=$ASSETS_DIR/$i@2.png $SRC_FILE >/dev/null
    fi

    $OPTIPNG -o7 --quiet $ASSETS_DIR/$i@2.png
fi
done
exit 0
