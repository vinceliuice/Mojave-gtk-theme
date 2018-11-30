#! /bin/bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

SRC_FILE="windows-assets.svg"
ASSETS_DIR="titlebutton"
INDEX="assets.txt"

for i in `cat $INDEX` ; do
for d in '' '-dark' ; do

## Normal titlebutton
if [ -f $ASSETS_DIR/$i$d.png ]; then
    echo $ASSETS_DIR/$i$d.png exists.
else
    echo
    echo Rendering $ASSETS_DIR/$i$d.png
    $INKSCAPE --export-id=$i$d \
              --export-id-only \
              --export-png=$ASSETS_DIR/$i$d.png $SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $ASSETS_DIR/$i$d.png 
fi

if [ -f $ASSETS_DIR/$i$d@2.png ]; then
    echo $ASSETS_DIR/$i$d@2.png exists.
else
    echo
    echo Rendering $ASSETS_DIR/$i$d@2.png
    $INKSCAPE --export-id=$i$d \
              --export-dpi=180 \
              --export-id-only \
              --export-png=$ASSETS_DIR/$i$d@2.png $SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $ASSETS_DIR/$i$d@2.png 
fi

## alt titlebutton
if [ -f $ASSETS_DIR-alt/$i-alt$d.png ]; then
    echo $ASSETS_DIR-alt/$i-alt$d.png exists.
else
    echo
    echo Rendering $ASSETS_DIR-alt/$i-alt$d.png
    $INKSCAPE --export-id=$i-alt$d \
              --export-id-only \
              --export-png=$ASSETS_DIR-alt/$i-alt$d.png $SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $ASSETS_DIR-alt/$i-alt$d.png 
fi

if [ -f $ASSETS_DIR-alt/$i-alt$d@2.png ]; then
    echo $ASSETS_DIR-alt/$i-alt$d@2.png exists.
else
    echo
    echo Rendering $ASSETS_DIR-alt/$i-alt$d@2.png
    $INKSCAPE --export-id=$i-alt$d \
              --export-dpi=180 \
              --export-id-only \
              --export-png=$ASSETS_DIR-alt/$i-alt$d@2.png $SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $ASSETS_DIR-alt/$i-alt$d@2.png 
fi

## small titlebutton
if [ -f $ASSETS_DIR-small/$i-small$d.png ]; then
    echo $ASSETS_DIR-small/$i-small$d.png exists.
else
    echo
    echo Rendering $ASSETS_DIR-small/$i-small$d.png
    $INKSCAPE --export-id=$i-small$d \
              --export-id-only \
              --export-png=$ASSETS_DIR-small/$i-small$d.png $SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $ASSETS_DIR-small/$i-small$d.png 
fi

if [ -f $ASSETS_DIR-small/$i-small$d@2.png ]; then
    echo $ASSETS_DIR-small/$i-small$d@2.png exists.
else
    echo
    echo Rendering $ASSETS_DIR-small/$i-small$d@2.png
    $INKSCAPE --export-id=$i-small$d \
              --export-dpi=180 \
              --export-id-only \
              --export-png=$ASSETS_DIR-small/$i-small$d@2.png $SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $ASSETS_DIR-small/$i-small$d@2.png 
fi

## alt small titlebutton
if [ -f $ASSETS_DIR-alt-small/$i-alt-small$d.png ]; then
    echo $ASSETS_DIR-alt-small/$i-alt-small$d.png exists.
else
    echo
    echo Rendering $ASSETS_DIR-alt-small/$i-alt-small$d.png
    $INKSCAPE --export-id=$i-alt-small$d \
              --export-id-only \
              --export-png=$ASSETS_DIR-alt-small/$i-alt-small$d.png $SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $ASSETS_DIR-alt-small/$i-alt-small$d.png 
fi

if [ -f $ASSETS_DIR-alt-small/$i-alt-small$d@2.png ]; then
    echo $ASSETS_DIR-alt-small/$i-alt-small$d@2.png exists.
else
    echo
    echo Rendering $ASSETS_DIR-alt-small/$i-alt-small$d@2.png
    $INKSCAPE --export-id=$i-alt-small$d \
              --export-dpi=180 \
              --export-id-only \
              --export-png=$ASSETS_DIR-alt-small/$i-alt-small$d@2.png $SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $ASSETS_DIR-alt-small/$i-alt-small$d@2.png 
fi

done
done
exit 0
