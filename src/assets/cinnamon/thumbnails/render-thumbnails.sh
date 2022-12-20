#! /usr/bin/env bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

SRC_FILE="thumbnail.svg"

rm -rf thumbnail-{Light,Dark}*.png

for theme in '' '-blue' '-purple' '-pink' '-red' '-orange' '-yellow' '-green' '-grey'; do
  echo Rendering thumbnail-light${theme}.png
  $INKSCAPE --export-id=thumbnail-light${theme} --export-id-only --export-filename=thumbnail-light${theme}.png $SRC_FILE >/dev/null
  $OPTIPNG -o7 --quiet thumbnail-light${theme}.png 

  echo Rendering thumbnail-dark${theme}.png
  $INKSCAPE --export-id=thumbnail-dark${theme} --export-id-only --export-filename=thumbnail-dark${theme}.png $SRC_FILE >/dev/null
  $OPTIPNG -o7 --quiet thumbnail-dark${theme}.png 
done

exit 0
