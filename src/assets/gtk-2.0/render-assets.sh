#! /usr/bin/env bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

INDEX="assets.txt"
INDEX_T="theme_assets.txt"

for color in '-Light' '-Dark'; do
  for theme in '' '-blue' '-purple' '-pink' '-red' '-orange' '-yellow' '-green' '-grey'; do
    ASSETS_DIR="assets${color}${theme}"
    SRC_FILE="assets${color}${theme}.svg"

    [[ -d $ASSETS_DIR ]] && rm -rf $ASSETS_DIR
    mkdir -p $ASSETS_DIR

    if [[ ${theme} == '' ]]; then
      INDEX_FILE="$INDEX"
    else
      INDEX_FILE="$INDEX_T"
    fi

    for i in `cat $INDEX_FILE`; do
      echo
      echo Rendering $ASSETS_DIR/$i.png

      $INKSCAPE --export-id=$i \
                --export-id-only \
                --export-filename=$ASSETS_DIR/$i.png $SRC_FILE >/dev/null
      $OPTIPNG -o7 --quiet $ASSETS_DIR/$i.png
    done
  done
done

exit 0
