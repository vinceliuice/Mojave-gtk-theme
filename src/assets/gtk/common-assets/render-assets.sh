#! /usr/bin/env bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

INDEX="assets.txt"
INDEX_T="theme_assets.txt"

for theme in '' '-blue' '-purple' '-pink' '-red' '-orange' '-yellow' '-green' '-grey'; do
  ASSETS_DIR="assets${theme}"
  SRC_FILE="assets${theme}.svg"

  [[ -d $ASSETS_DIR ]] && rm -rf $ASSETS_DIR
  mkdir -p $ASSETS_DIR

  if [[ ${theme} == '' ]]; then
    INDEX_FILE="$INDEX"
  else
    INDEX_FILE="$INDEX_T"
  fi

  for i in `cat $INDEX_FILE`; do
    for scale in 1 2; do
      file="$ASSETS_DIR/$i$( [ $scale -gt 1 ] && echo "@${scale}" ).png"
      echo
      echo Rendering "$file"
      $INKSCAPE --export-id=$i \
                --export-dpi=$((96 * scale)) \
                --export-id-only \
                --export-filename="$file" $SRC_FILE >/dev/null
      $OPTIPNG -o7 --quiet "$file"
    done
  done
done

exit 0
