#! /usr/bin/env bash
set -ueo pipefail
set -o physical

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
ASRC_DIR="${REPO_DIR}/src/assets"

# import environment variables with care
from_env() {
  eval "
  if ! [ -v $1 ]; then
    $1='$2'
  fi
  export $1"
}

# check command avalibility
has_command() {
  command -v "${1}" > /dev/null 2>&1
}

missing=
for cmd in inkscape optipng; do
  if ! has_command $cmd; then
    missing="${missing} $cmd"
  fi
done
if [ "${missing}" ]; then
  echo "Missing required dependencies: ${missing}"
  if has_command zypper; then
    sudo zypper in inkscape optipng
  elif has_command apt; then
    sudo apt install inkscape optipng
  elif has_command dnf; then
    sudo dnf install -y inkscape optipng
  elif has_command dnf; then
    sudo dnf install inkscape optipng
  elif has_command pacman; then
    sudo pacman -S --noconfirm inkscape optipng
  elif had_command brew; then
    brew install --cask inkscape
    brew install optipng
  else
    exit 1
  fi
fi

render_thumbnail() {
  local dest="$1"
  local color="$2"
  local in="$ASRC_DIR/${dest}/thumbnail.svg"
  local out="$ASRC_DIR/${dest}/thumbnail${color}.png"

  if [ $(jobs -p | wc -l) -ge ${BUILD_THREADS} ]; then wait; fi
  echo "Rendering $out"
  rm -rf "$out"

    "$INKSCAPE" --export-id="thumbnail${color@L}" \
                --export-id-only \
                --export-filename="$out" "$in" >/dev/null 2>&1 &&
  "$OPTIPNG" -o7 --quiet "$out" &
}

from_env BUILD_THREADS 1
from_env SCALE_FACTORS "2" # Space separated list
from_env XFWM4_SCALE_FACTOR 1

BUILD_THREADS=$(( BUILD_THREADS >= 1 ? BUILD_THREADS : 1 ))
XFWM4_SCALE_FACTOR=$(( XFWM4_SCALE_FACTOR >= 1 ? XFWM4_SCALE_FACTOR : 1 ))

# Sort scales list, discard essential scale 1 and duplicates, but require at least one (default to 2)
export SCALE_FACTORS=$( awk '
  function cmp( i1, v1, i2, v2) { return i1-i2 }
  { a[""]=""; delete a[""]
    for (i=1; i <= NF; i++)
    {
      n = int( $(i) )
      if (n > 1 && !( n in a))
        a[ n]=""
    }
    if (length( a) == 0)
    {
      print 2
      exit
    }
    asorti( a, a, "cmp")
    printf a[1]
    for (i=2; i <= length(a); i++)
      printf " "a[i]
  }' <<< "$SCALE_FACTORS" )

echo "Render configuration:"
echo
echo "BUILD_THREADS = ${BUILD_THREADS}"
echo "SCALE_FACTORS = ${SCALE_FACTORS}"
echo "XFWM4_SCALE_FACTOR = ${XFWM4_SCALE_FACTOR}"

echo
for color in '-Light' '-Dark' ; do
  render_thumbnail "${dest:-metacity-1}" "${color}"
done

echo
echo "Rendering cinnamon thumbnails"
cd "$ASRC_DIR/cinnamon/thumbnails" && ./render-thumbnails.sh

echo
echo "Rendering gtk thumbnails"
cd "$ASRC_DIR/gtk/thumbnails"      && ./render-thumbnails.sh

echo
echo Rendering gtk-2.0 assets
cd "$ASRC_DIR/gtk-2.0" && ./render-assets.sh

echo
echo Rendering gtk-3.0 / gtk-4.0 assets
cd "$ASRC_DIR/gtk/common-assets" && ./render-assets.sh
cd "$ASRC_DIR/gtk/windows-assets" && ./render-assets.sh && ./render-alt-assets.sh

echo
echo Rendering metacity-1 assets
cd "$ASRC_DIR/metacity-1" && ./render-assets.sh

echo
echo Rendering xfwm4 assets
cd "$ASRC_DIR/xfwm4" && ./render-assets.sh
cd "${REPO_DIR}/src/main/xfwm4" && {
  for suf in 'Light' 'Dark'; do
    [ -f themerc-${suf}.orig ] || cp themerc-${suf}{,.orig}
    awk -F= -vscale=${XFWM4_SCALE_FACTOR} '
    /^(button_(offset|spacing)|title_horizontal_offset|shadow_(delta_(height|width|x|y)|opacity))/ {
      print $1 "=" $2 * scale
      next }
    { print }
    ' themerc-${suf}.orig > themerc-${suf}
  done
}

wait
exit 0
