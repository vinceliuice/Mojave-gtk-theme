#!/bin/bash
set -ueo pipefail
#set -x

REPO_DIR=$(cd $(dirname $0) && pwd)
SRC_DIR=${REPO_DIR}/src

ROOT_UID=0
DEST_DIR=

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  DEST_DIR="/usr/share/themes"
else
  DEST_DIR="$HOME/.themes"
fi

THEME_NAME=Mojave
COLOR_VARIANTS=('-light' '-dark')
OPACITY_VARIANTS=('' '-solid')
ALT_VARIANTS=('' '-alt')
SMALL_VARIANTS=('' '-small')
ICON_VARIANTS=('' '-normal' '-gnome' '-ubuntu' '-arch' '-manjaro' '-fedora' '-debian', '-void')

usage() {
  printf "%s\n" "Usage: $0 [OPTIONS...]"
  printf "\n%s\n" "OPTIONS:"
  printf "  %-25s%s\n" "-d, --dest DIR" "Specify theme destination directory (Default: ${DEST_DIR})"
  printf "  %-25s%s\n" "-n, --name NAME" "Specify theme name (Default: ${THEME_NAME})"
  printf "  %-25s%s\n" "-o, --opacity VARIANTS" "Specify theme opacity variant(s) [standard|solid] (Default: All variants)"
  printf "  %-25s%s\n" "-c, --color VARIANTS" "Specify theme color variant(s) [light|dark] (Default: All variants)"
  printf "  %-25s%s\n" "-a, --alt VARIANTS" "Specify theme titilebutton variant(s) [standard|alt] (Default: All variants)"
  printf "  %-25s%s\n" "-s, --small VARIANTS" "Specify titilebutton size variant(s) [standard|small] (Default: standard variant)"
  printf "  %-25s%s\n" "-i, --icon VARIANTS" "Specify activities icon variant(s) for gnome-shell [standard|normal|gnome|ubuntu|arch|manjaro|fedora|debian|void] (Default: standard variant)"
  printf "  %-25s%s\n" "-g, --gdm" "Install GDM theme, this option need root user authority! please run this with sudo"
  printf "  %-25s%s\n" "-r, --revert" "revert GDM theme, this option need root user authority! please run this with sudo"
  printf "  %-25s%s\n" "-h, --help" "Show this help"
}

install() {
  local dest=${1}
  local name=${2}
  local color=${3}
  local opacity=${4}
  local alt=${5}
  local small=${6}
  local icon=${7}

  [[ ${color} == '-light' ]] && local ELSE_LIGHT=${color}
  [[ ${color} == '-dark' ]] && local ELSE_DARK=${color}

  local THEME_DIR=${dest}/${name}${color}${opacity}${alt}

  [[ -d ${THEME_DIR} ]] && rm -rf ${THEME_DIR}

  echo "Installing '${THEME_DIR}'..."

  mkdir -p                                                                              ${THEME_DIR}
  cp -ur ${REPO_DIR}/COPYING                                                            ${THEME_DIR}

  echo "[Desktop Entry]" >>                                                             ${THEME_DIR}/index.theme
  echo "Type=X-GNOME-Metatheme" >>                                                      ${THEME_DIR}/index.theme
  echo "Name=${name}${color}${opacity}${alt}" >>                                        ${THEME_DIR}/index.theme
  echo "Comment=An Stylish Gtk+ theme based on Elegant Design" >>                       ${THEME_DIR}/index.theme
  echo "Encoding=UTF-8" >>                                                              ${THEME_DIR}/index.theme
  echo "" >>                                                                            ${THEME_DIR}/index.theme
  echo "[X-GNOME-Metatheme]" >>                                                         ${THEME_DIR}/index.theme
  echo "GtkTheme=${name}${color}${opacity}${alt}" >>                                    ${THEME_DIR}/index.theme
  echo "MetacityTheme=${name}${color}${opacity}${alt}" >>                               ${THEME_DIR}/index.theme
  echo "IconTheme=Adwaita" >>                                                           ${THEME_DIR}/index.theme
  echo "CursorTheme=Adwaita" >>                                                         ${THEME_DIR}/index.theme
  echo "ButtonLayout=close,minimize,maximize:menu" >>                                   ${THEME_DIR}/index.theme

  mkdir -p                                                                              ${THEME_DIR}/gnome-shell
  cp -ur ${SRC_DIR}/gnome-shell/{extensions,message-indicator-symbolic.svg,pad-osd.css} ${THEME_DIR}/gnome-shell
  cp -ur ${SRC_DIR}/gnome-shell/gnome-shell${color}${opacity}.css                       ${THEME_DIR}/gnome-shell/gnome-shell.css
  cp -ur ${SRC_DIR}/gnome-shell/common-assets                                           ${THEME_DIR}/gnome-shell/assets
  cp -ur ${SRC_DIR}/gnome-shell/assets${color}/*.svg                                    ${THEME_DIR}/gnome-shell/assets
  cp -ur ${SRC_DIR}/gnome-shell/assets${color}/*.png                                    ${THEME_DIR}/gnome-shell/assets
  cp -ur ${SRC_DIR}/gnome-shell/assets${color}/activities/activities${icon}.svg         ${THEME_DIR}/gnome-shell/assets/activities.svg
  cd ${THEME_DIR}/gnome-shell
  ln -s assets/no-events.svg no-events.svg
  ln -s assets/process-working.svg process-working.svg
  ln -s assets/no-notifications.svg no-notifications.svg

  mkdir -p                                                                              ${THEME_DIR}/gtk-2.0
  cp -ur ${SRC_DIR}/gtk-2.0/gtkrc${color}                                               ${THEME_DIR}/gtk-2.0/gtkrc
  cp -ur ${SRC_DIR}/gtk-2.0/assets${color}                                              ${THEME_DIR}/gtk-2.0/assets
  cp -ur ${SRC_DIR}/gtk-2.0/common/*.rc                                                 ${THEME_DIR}/gtk-2.0
  cp -ur ${SRC_DIR}/gtk-2.0/menubar-toolbar${color}.rc                                  ${THEME_DIR}/gtk-2.0/menubar-toolbar.rc

  mkdir -p                                                                              ${THEME_DIR}/gtk-3.0
  cp -ur ${SRC_DIR}/gtk-3.0/assets                                                      ${THEME_DIR}/gtk-3.0
  cp -ur ${SRC_DIR}/gtk-3.0/windows-assets/titlebutton${alt}${small}                    ${THEME_DIR}/gtk-3.0/windows-assets
  cp -ur ${SRC_DIR}/gtk-3.0/thumbnail${color}.png                                       ${THEME_DIR}/gtk-3.0/thumbnail.png
  cp -ur ${SRC_DIR}/gtk-3.0/gtk${color}${opacity}${alt}${small}.css                     ${THEME_DIR}/gtk-3.0/gtk.css
  [[ ${color} != '-dark' ]] && \
  cp -ur ${SRC_DIR}/gtk-3.0/gtk-dark${opacity}${alt}${small}.css                        ${THEME_DIR}/gtk-3.0/gtk-dark.css

  mkdir -p                                                                              ${THEME_DIR}/metacity-1
  cp -ur ${SRC_DIR}/metacity-1/metacity-theme${color}.xml                               ${THEME_DIR}/metacity-1/metacity-theme-1.xml
  cp -ur ${SRC_DIR}/metacity-1/metacity-theme-3.xml                                     ${THEME_DIR}/metacity-1
  cp -ur ${SRC_DIR}/metacity-1/assets/*.png                                             ${THEME_DIR}/metacity-1
  cp -ur ${SRC_DIR}/metacity-1/thumbnail${color}.png                                    ${THEME_DIR}/metacity-1/thumbnail.png
  cd ${THEME_DIR}/metacity-1 && ln -s metacity-theme-1.xml metacity-theme-2.xml

  mkdir -p                                                                              ${THEME_DIR}/xfwm4
  cp -ur ${SRC_DIR}/xfwm4/assets${color}/*.png                                          ${THEME_DIR}/xfwm4
  cp -ur ${SRC_DIR}/xfwm4/themerc${color}                                               ${THEME_DIR}/xfwm4/themerc

  mkdir -p                                                                              ${THEME_DIR}/cinnamon
  cp -ur ${SRC_DIR}/cinnamon/cinnamon${color}${opacity}.css                             ${THEME_DIR}/cinnamon/cinnamon.css
  cp -ur ${SRC_DIR}/cinnamon/common-assets                                              ${THEME_DIR}/cinnamon/assets
  cp -ur ${SRC_DIR}/cinnamon/assets${color}/*.svg                                       ${THEME_DIR}/cinnamon/assets
  cp -ur ${SRC_DIR}/cinnamon/thumbnail${color}.png                                      ${THEME_DIR}/cinnamon/thumbnail.png

  mkdir -p                                                                              ${THEME_DIR}/plank
  cp -ur ${SRC_DIR}/plank/${name}${color}/*.theme                                       ${THEME_DIR}/plank
}

# Backup and install files related to GDM theme

GS_THEME_FILE="/usr/share/gnome-shell/gnome-shell-theme.gresource"
SHELL_THEME_FOLDER="/usr/share/gnome-shell/theme"
ETC_THEME_FOLDER="/etc/alternatives"
ETC_THEME_FILE="/etc/alternatives/gdm3.css"
UBUNTU_THEME_FILE="/usr/share/gnome-shell/theme/ubuntu.css"
UBUNTU_NEW_THEME_FILE="/usr/share/gnome-shell/theme/gnome-shell.css"

install_gdm() {
  local GDM_THEME_DIR="${1}/${2}${3}${4}"

  if [[ -f "$GS_THEME_FILE" ]] && command -v glib-compile-resources >/dev/null ; then
    echo "Installing '$GS_THEME_FILE'..."
    cp -an "$GS_THEME_FILE" "$GS_THEME_FILE.bak"
    glib-compile-resources \
      --sourcedir="$GDM_THEME_DIR/gnome-shell" \
      --target="$GS_THEME_FILE" \
      "${SRC_DIR}/gnome-shell/gnome-shell-theme.gresource.xml"
  fi

  if [[ -f "$UBUNTU_THEME_FILE" && -f "$GS_THEME_FILE.bak" ]]; then
    echo "Installing '$UBUNTU_THEME_FILE'..."
    cp -an "$UBUNTU_THEME_FILE" "$UBUNTU_THEME_FILE.bak"
    rm -rf "$GS_THEME_FILE"
    mv "$GS_THEME_FILE.bak" "$GS_THEME_FILE"
    cp -af "$GDM_THEME_DIR/gnome-shell/gnome-shell.css" "$UBUNTU_THEME_FILE"
  fi

  if [[ -f "$ETC_THEME_FILE" && -f "$GS_THEME_FILE.bak" ]]; then
    echo "Installing Ubuntu gnome-shell theme..."
    cp -an "$ETC_THEME_FILE" "$ETC_THEME_FILE.bak"
    rm -rf "$ETC_THEME_FILE" "$GS_THEME_FILE"
    mv "$GS_THEME_FILE.bak" "$GS_THEME_FILE"
    [[ -d $SHELL_THEME_FOLDER/Mojave ]] && rm -rf $SHELL_THEME_FOLDER/Mojave
    cp -ur "$GDM_THEME_DIR/gnome-shell" "$SHELL_THEME_FOLDER/Mojave"
    cd "$ETC_THEME_FOLDER"
    ln -s "$SHELL_THEME_FOLDER/Mojave/gnome-shell.css" gdm3.css
  fi
}

revert_gdm() {
  if [[ -f "$GS_THEME_FILE.bak" ]]; then
    echo "reverting '$GS_THEME_FILE'..."
    rm -rf "$GS_THEME_FILE"
    mv "$GS_THEME_FILE.bak" "$GS_THEME_FILE"
  fi

  if [[ -f "$UBUNTU_THEME_FILE.bak" ]]; then
    echo "reverting '$UBUNTU_THEME_FILE'..."
    rm -rf "$UBUNTU_THEME_FILE"
    mv "$UBUNTU_THEME_FILE.bak" "$UBUNTU_THEME_FILE"
  fi

  if [[ -f "$ETC_THEME_FILE.bak" ]]; then
    echo "reverting Ubuntu gnome-shell theme..."
    rm -rf "$ETC_THEME_FILE"
    mv "$ETC_THEME_FILE.bak" "$ETC_THEME_FILE"
    [[ -d $SHELL_THEME_FOLDER/Mojave ]] && rm -rf $SHELL_THEME_FOLDER/Mojave
  fi
}

while [[ $# -gt 0 ]]; do
  case "${1}" in
    -d|--dest)
      dest="${2}"
      if [[ ! -d "${dest}" ]]; then
        echo "Destination directory does not exist. Let's make a new one..."
        mkdir -p ${dest}
      fi
      shift 2
      ;;
    -n|--name)
      name="${2}"
      shift 2
      ;;
    -g|--gdm)
      gdm='true'
      shift 1
      ;;
    -r|--revert)
      revert='true'
      shift 1
      ;;
    -o|--opacity)
      shift
      for opacity in "${@}"; do
        case "${opacity}" in
          standard)
            opacities+=("${OPACITY_VARIANTS[0]}")
            shift
            ;;
          solid)
            opacities+=("${OPACITY_VARIANTS[1]}")
            shift
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized opacity variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -c|--color)
      shift
      for color in "${@}"; do
        case "${color}" in
          light)
            colors+=("${COLOR_VARIANTS[0]}")
            shift
            ;;
          dark)
            colors+=("${COLOR_VARIANTS[1]}")
            shift
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized color variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -a|--alt)
      shift
      for alt in "${@}"; do
        case "${alt}" in
          standard)
            alts+=("${ALT_VARIANTS[0]}")
            shift
            ;;
          alt)
            alts+=("${ALT_VARIANTS[1]}")
            shift
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized alt titlebutton variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -s|--small)
      shift
      for small in "${@}"; do
        case "${small}" in
          standard)
            smalls+=("${SMALL_VARIANTS[0]}")
            shift
            ;;
          small)
            smalls+=("${SMALL_VARIANTS[1]}")
            shift
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized small titlebutton variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -i|--icon)
      shift
      for icon in "${@}"; do
        case "${icon}" in
          standard)
            icons+=("${ICON_VARIANTS[0]}")
            shift
            ;;
          normal)
            icons+=("${ICON_VARIANTS[1]}")
            shift
            ;;
          gnome)
            icons+=("${ICON_VARIANTS[2]}")
            shift
            ;;
          ubuntu)
            icons+=("${ICON_VARIANTS[3]}")
            shift
            ;;
          arch)
            icons+=("${ICON_VARIANTS[4]}")
            shift
            ;;
          manjaro)
            icons+=("${ICON_VARIANTS[5]}")
            shift
            ;;
          fedora)
            icons+=("${ICON_VARIANTS[6]}")
            shift
            ;;
          debian)
            icons+=("${ICON_VARIANTS[7]}")
            shift
            ;;
          void)
            icons+=("${ICON_VARIANTS[8]}")
            shift
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized icon variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: Unrecognized installation option '$1'."
      echo "Try '$0 --help' for more information."
      exit 1
      ;;
  esac
done

install_theme() {
for opacity in "${opacities[@]-${OPACITY_VARIANTS[@]}}"; do
  for color in "${colors[@]-${COLOR_VARIANTS[@]}}"; do
    for alt in "${alts[@]-${ALT_VARIANTS[@]}}"; do
      for small in "${smalls[@]-${SMALL_VARIANTS[0]}}"; do
        for icon in "${icons[@]-${ICON_VARIANTS[0]}}"; do
          install "${dest:-${DEST_DIR}}" "${name:-${THEME_NAME}}" "${color}" "${opacity}" "${alt}" "${small}" "${icon}"
        done
      done
    done
  done
done
}

if [[ "${gdm:-}" != 'true' && "${revert:-}" != 'true' ]]; then
  install_theme
fi

if [[ "${gdm:-}" == 'true' && "${revert:-}" != 'true' && "$UID" -eq "$ROOT_UID" ]]; then
  install_theme && install_gdm "${dest:-${DEST_DIR}}" "${name:-${THEME_NAME}}" "${color}" "${opacity}"
fi

if [[ "${gdm:-}" != 'true' && "${revert:-}" == 'true' && "$UID" -eq "$ROOT_UID" ]]; then
  revert_gdm
fi

echo
echo Done.
