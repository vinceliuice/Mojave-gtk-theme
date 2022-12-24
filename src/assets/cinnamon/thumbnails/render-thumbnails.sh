#! /usr/bin/env bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

SRC_FILE="thumbnail.svg"

rm -rf thumbnail-{Light,Dark}*.png

for theme in '' '-blue' '-purple' '-pink' '-red' '-orange' '-yellow' '-green' '-grey'; do
  for light in 'Light' 'Dark'; do
    obj="thumbnail-${light}${theme}"

    if [ $(jobs -p | wc -l) -ge ${BUILD_THREADS} ]; then wait; fi
    echo Rendering "$obj.png"
    $INKSCAPE --export-id=${obj@L} --export-id-only --export-filename=$obj.png $SRC_FILE >/dev/null 2>&1 &&
    $OPTIPNG -o7 --quiet $obj.png &
  done
done

wait
exit 0
