#! /usr/bin/env bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

SRC_FILE="thumbnail.svg"

rm -rf thumbnail-{light,dark}*.png

for theme in '' '-blue' '-purple' '-pink' '-red' '-orange' '-yellow' '-green' '-grey'; do
  for light in 'light' 'dark'; do
    obj="thumbnail-${light}${theme}"

    echo Rendering "$obj.png"
    $INKSCAPE --export-id=$obj --export-id-only --export-filename=$obj.png $SRC_FILE >/dev/null
    $OPTIPNG -o7 --quiet $obj.png
  done
done

exit 0
