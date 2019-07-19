<img src="https://github.com/vinceliuice/Sierra-gtk-theme/blob/imgs/logo.png" alt="Logo" align="right" /> Mojave Gtk Theme
======

Mojave is a Mac OSX like theme for GTK 3, GTK 2 and Gnome-Shell which supports GTK 3 and GTK 2 based desktop environments like Gnome, Pantheon, XFCE, Mate, etc.

This theme is based on Arc gtk theme of horst3180. Thanks horst3180 sincerely for his great job!
horst3180 - Arc gtk theme: https://github.com/horst3180/Arc-theme

## Info

### GTK+ 3.20 or later

### GTK2 engines requirment
- GTK2 engine Murrine 0.98.1.1 or later.
- GTK2 pixbuf engine or the gtk(2)-engines package.

Fedora/RedHat distros:

    yum install gtk-murrine-engine gtk2-engines

Ubuntu/Mint/Debian distros:

    sudo apt-get install gtk2-engines-murrine gtk2-engines-pixbuf

ArchLinux:

    pacman -S gtk-engine-murrine gtk-engines

Other:
Search for the engines in your distributions repository or install the engines from source.

## Fix entries issues of dark version on Firefox

Use "light theme" for webs on Firefox.

1. Go to `about:config`,

2. create a pref called `widget.content.gtk-theme-override` of type String,

3. and give it a value of `Mojave-light`. This will fix it.

## Installation

### From source

Run

    ./install.sh

#### Install tips

Usage:  `./Install`  **[OPTIONS...]**

|  OPTIONS:           | |
|:--------------------|:-------------|
|-d, --dest           | Specify theme destination directory (Default: $HOME/.themes)|
|-n, --name           | Specify theme name (Default: Mojave)|
|-c, --color          | Specify theme color variant(s) **[light/dark]** (Default: All variants)|
|-o, --opacity        | Specify theme opacity variant(s) **[standard/solid]** (Default: All variants)|
|-a, --alt            | Alt titlebutton theme opacity variant(s) **[standard/alt]** (Default: All variants)|
|-s, --small          | small titlebutton theme opacity variant(s) **[standard/small]** (Default: standard variant)|
|-i, --icon           | activities icon variant(s) **[standard/normal/gnome/ubuntu/arch/manjaro/fedora/debian/void]** (Default: standard variant)|
|-g, --gdm            | Install GDM theme, you should run this with sudo!|
|-r, --revert         | revert GDM theme, you should run this with sudo!|
|-h, --help           | Show this help|

### Icon theme
[McMojave-circle](https://github.com/vinceliuice/McMojave-circle)

### Wallpaper
[Mojave default wallpapers](https://github.com/vinceliuice/Mojave-gtk-theme/blob/images/macOS_Mojave_Wallpapers.tar.xz)

### Firefox theme
[Intall Firefox theme](src/firefox)

#### Preview
![01](https://github.com/vinceliuice/Mojave-gtk-theme/blob/images/firefox01.png?raw=true)
![02](https://github.com/vinceliuice/Mojave-gtk-theme/blob/images/firefox02.png?raw=true)

## Screenshots

#### Mojave
![01](https://github.com/vinceliuice/Mojave-gtk-theme/blob/images/screenshot01.jpeg?raw=true)
![02](https://github.com/vinceliuice/Mojave-gtk-theme/blob/images/screenshot02.jpeg?raw=true)
![03](https://github.com/vinceliuice/Mojave-gtk-theme/blob/images/screenshot03.jpeg?raw=true)
![04](https://github.com/vinceliuice/Mojave-gtk-theme/blob/images/screenshot04.jpeg?raw=true)
![05](https://github.com/vinceliuice/Mojave-gtk-theme/blob/images/screenshot05.jpeg?raw=true)
![GDM_theme](https://github.com/vinceliuice/Mojave-gtk-theme/blob/images/login_screen.png?raw=true)
