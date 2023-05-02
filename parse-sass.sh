#! /usr/bin/env bash

. config.sh

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
SRC_DIR="${REPO_DIR}/src"

# Check command availability
function has_command() {
  command -v $1 > /dev/null
}

if [ ! "$(which sassc 2> /dev/null)" ]; then
  echo sassc needs to be installed to generate the css.
  if has_command zypper; then
    sudo zypper in sassc
  elif has_command apt; then
    sudo apt install sassc
  elif has_command dnf; then
    sudo dnf install -y sassc
  elif has_command yum; then
    sudo yum install sassc
  elif has_command pacman; then
    sudo pacman -S --noconfirm sassc
  fi
fi

# Pass configuration to scss
echo '$MAX_SCALE_FACTOR: '"$MAX_SCALE_FACTOR;" > './src/sass/_config.scss'

SASSC_OPT="-M -t expanded"

_COLOR_VARIANTS=('-Light' '-Dark')
if [ ! -z "${COLOR_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _COLOR_VARIANTS <<< "${COLOR_VARIANTS:-}"
fi

_TRANS_VARIANTS=('' '-solid')
if [ ! -z "${TRANS_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _TRANS_VARIANTS <<< "${TRANS_VARIANTS:-}"
fi

_THEME_VARIANTS=('' '-blue' '-purple' '-pink' '-red' '-orange' '-yellow' '-green' '-grey')
if [ ! -z "${THEME_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _THEME_VARIANTS <<< "${THEME_VARIANTS:-}"
fi

rm -rf "${SRC_DIR}/sass/_theme-variant-temp.scss"
cp -rf "${SRC_DIR}/sass/_theme-variant.scss" "${SRC_DIR}/sass/_theme-variant-temp.scss"

for color in "${_COLOR_VARIANTS[@]}"; do
  for trans in "${_TRANS_VARIANTS[@]}"; do
    for theme in "${_THEME_VARIANTS[0]}"; do
      sassc $SASSC_OPT src/main/gtk-3.0/gtk${color}${trans}${theme}.{scss,css}
      echo "==> Generating the 3.0 gtk${color}${trans}${theme}.css..."
      sassc $SASSC_OPT src/main/gtk-4.0/gtk${color}${trans}${theme}.{scss,css}
      echo "==> Generating the 4.0 gtk${color}${trans}${theme}.css..."
      sassc $SASSC_OPT src/main/gnome-shell/shell-3-28/gnome-shell${color}${trans}${theme}.{scss,css}
      echo "==> Generating the 3.28 gnome-shell${color}${trans}${theme}.css..."
      sassc $SASSC_OPT src/main/gnome-shell/shell-40-0/gnome-shell${color}${trans}${theme}.{scss,css}
      echo "==> Generating the 40.0 gnome-shell${color}${trans}${theme}.css..."
      sassc $SASSC_OPT src/main/gnome-shell/shell-42-0/gnome-shell${color}${trans}${theme}.{scss,css}
      echo "==> Generating the 42.0 gnome-shell${color}${trans}${theme}.css..."
      sassc $SASSC_OPT src/main/gnome-shell/shell-44-0/gnome-shell${color}${trans}${theme}.{scss,css}
      echo "==> Generating the 44.0 gnome-shell${color}${trans}${theme}.css..."
      sassc $SASSC_OPT src/main/cinnamon/cinnamon${color}${trans}${theme}.{scss,css}
      echo "==> Generating the cinnamon${color}${trans}${theme}.css..."
    done
  done
done

sassc $SASSC_OPT src/other/dash-to-dock/stylesheet.{scss,css}
echo "==> Generating dash-to-dock stylesheet.css..."
sassc $SASSC_OPT src/other/dash-to-dock/stylesheet-Dark.{scss,css}
echo "==> Generating dash-to-dock stylesheet-Dark.css..."
