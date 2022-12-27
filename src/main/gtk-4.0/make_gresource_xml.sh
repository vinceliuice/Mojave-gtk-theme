#! /usr/bin/env bash

INDEX="../../assets/gtk/common-assets/assets.txt"
WINDEX="../../assets/gtk/windows-assets/assets.txt"

if [ -f gtk.gresource.xml ]; then
  rm -rf gtk.gresource.xml
fi

echo '<?xml version="1.0" encoding="UTF-8"?>' >> gtk.gresource.xml
echo "<gresources>" >> gtk.gresource.xml
echo '  <gresource prefix="/org/gnome/theme">' >> gtk.gresource.xml

for i in `cat $INDEX`
do
  echo "    <file>assets/$i.png</file>" >> gtk.gresource.xml
  for scale in $SCALE_FACTORS; do
    echo "    <file>assets/$i@${scale}.png</file>" >> gtk.gresource.xml
  done
done

for i in `cat $WINDEX`
do
  echo "    <file>windows-assets/$i.png</file>" >> gtk.gresource.xml
  echo "    <file>windows-assets/$i-dark.png</file>" >> gtk.gresource.xml
  for scale in $SCALE_FACTORS; do
    echo "    <file>windows-assets/$i@${scale}.png</file>" >> gtk.gresource.xml
    echo "    <file>windows-assets/$i-dark@${scale}.png</file>" >> gtk.gresource.xml
  done
done

echo "    <file>gtk.css</file>" >> gtk.gresource.xml
echo "    <file>gtk-dark.css</file>" >> gtk.gresource.xml

echo "  </gresource>" >> gtk.gresource.xml
echo "</gresources>" >> gtk.gresource.xml

exit 0
