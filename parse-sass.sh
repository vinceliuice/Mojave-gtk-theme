#! /bin/bash

if [ ! "$(which sassc 2> /dev/null)" ]; then
   echo sassc needs to be installed to generate the css.
   exit 1
fi

SASSC_OPT="-M -t expanded"

_COLOR_VARIANTS=('-light' '-dark')
if [ ! -z "${COLOR_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _COLOR_VARIANTS <<< "${COLOR_VARIANTS:-}"
fi

_TRANS_VARIANTS=('' '-solid')
if [ ! -z "${TRANS_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _TRANS_VARIANTS <<< "${TRANS_VARIANTS:-}"
fi

_ALT_VARIANTS=('' '-alt')
if [ ! -z "${ALT_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _THIN_VARIANTS <<< "${ALT_VARIANTS:-}"
fi

_SMALL_VARIANTS=('' '-small')
if [ ! -z "${SMALL_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _THIN_VARIANTS <<< "${SMALL_VARIANTS:-}"
fi

for color in "${_COLOR_VARIANTS[@]}"; do
  for trans in "${_TRANS_VARIANTS[@]}"; do
    for alt in "${_ALT_VARIANTS[@]}"; do
      for small in "${_SMALL_VARIANTS[@]}"; do
      sassc $SASSC_OPT src/gtk-3.0/gtk${compact}${color}${trans}${alt}${small}.{scss,css}
      echo "==> Generating the gtk${compact}${color}${trans}${alt}${small}.css..."
      done
    done
  done
done

for color in "${_COLOR_VARIANTS[@]}"; do
  for trans in "${_TRANS_VARIANTS[@]}"; do
    sassc $SASSC_OPT src/gnome-shell/gnome-shell${color}${trans}.{scss,css}
    echo "==> Generating the gnome-shell${color}${trans}.css..."
    sassc $SASSC_OPT src/cinnamon/cinnamon${color}${trans}.{scss,css}
    echo "==> Generating the cinnamon${color}${trans}.css..."
  done
done
