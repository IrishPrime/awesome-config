-- Generated by: https://github.com/ArnaudValensi/xdg-menu-to-awesome-wm.git
-- Icons added manually
local beautiful = require("beautiful") -- Theme handling library

submenu0 = {
  { "Archive Manager", "file-roller", "/usr/share/icons/Clarity/scalable/apps/file-roller.svg" },
  { "Calculator", "gnome-calculator", "/usr/share/icons/Clarity/scalable/apps/calc.svg" },
  { "Character Map", "gucharmap", "/usr/share/icons/Clarity/scalable/apps/gucharmap.svg" },
  { "Clocks", "gnome-clocks", "/usr/share/icons/Clarity/scalable/apps/gnome-calendar.svg" },
  { "Contacts", "gnome-contacts", "/usr/share/icons/Clarity/scalable/apps/contacts.svg" },
  { "Disks", "gnome-disks", "/usr/share/icons/Clarity/scalable/apps/baobab.svg" },
  { "Documents", "gnome-documents", "/usr/share/icons/Clarity/scalable/apps/file-manager.svg" },
  { "Files", "nautilus --new-window", "/usr/share/icons/Clarity/scalable/apps/nautilus.svg" },
  { "Font Viewer", "gnome-font-viewer", "/usr/share/icons/Clarity/scalable/apps/fonts.svg" },
  { "gedit", "gedit", "/usr/share/icons/Clarity/scalable/apps/gedit.svg" },
  { "gtk-chtheme", "gtk-chtheme", "/usr/share/icons/Clarity/scalable/apps/gtk-edit.svg" },
  { "Help", "yelp", "/usr/share/icons/Clarity/scalable/apps/yelp-icon-big.svg" },
  { "Orca", "orca --replace", "/usr/share/icons/Clarity/scalable/apps/accessibility-directory.svg" },
  { "Passwords and Keys", "/usr/bin/seahorse", "/usr/share/icons/Clarity/scalable/apps/seahorse.svg" },
  { "Screenshot", "gnome-screenshot --interactive", "/usr/share/icons/Clarity/scalable/apps/gnome-screenshot.svg" },
  { "Tweak Tool", "gnome-tweak-tool", "/usr/share/icons/Clarity/scalable/apps/control-center2.svg" },
  { "Vi IMproved", "gvim -f", "/home/moneill/.icons/Numix-Circle/48x48/apps/vim.svg" }
}
submenu1 = {
  { "Document Viewer", "evince", "/usr/share/icons/Clarity/scalable/apps/evince.svg" },
  { "GNU Image Manipulation Program", "gimp-2.8", "/usr/share/icons/Clarity/scalable/apps/gimp.svg" },
  { "LibreOffice Draw", "libreoffice --draw", "/usr/share/icons/Clarity/scalable/apps/libreoffice-draw.svg" },
  { "Shotwell", "shotwell", "/usr/share/icons/Clarity/scalable/apps/shotwell.svg" },
  { "Simple Scan", "simple-scan", "/usr/share/icons/Clarity/scalable/apps/xsane.svg" }
}
submenu2 = {
  { "Dropbox", "dropbox start -i", "/usr/share/icons/Clarity/scalable/apps/dropbox.svg" },
  { "Empathy", "empathy", "/usr/share/icons/Clarity/scalable/apps/empathy.svg" },
  { "Firefox", "firefox", "/usr/share/icons/Clarity/scalable/apps/firefox-default.svg" },
  { "Google Chrome", "/opt/google/chrome/google-chrome", "/usr/share/icons/Clarity/scalable/apps/google-chrome.svg" },
  { "Pidgin Internet Messenger", "pidgin", "/usr/share/icons/Clarity/scalable/apps/pidgin.svg" },
  { "Remote Desktop Viewer", "vinagre", "/usr/share/icons/Clarity/scalable/apps/vinagre.svg" },
  { "Thunderbird", "thunderbird", "/usr/share/icons/Clarity/scalable/apps/thunderbird.svg" },
  { "Transmission", "transmission-gtk", "/usr/share/icons/Clarity/scalable/apps/transmission.svg" },
  { "XChat", "xchat", "/usr/share/icons/Clarity/scalable/apps/xchat.svg" }
}
submenu3 = {
  { "Dictionary", "gnome-dictionary", "/usr/share/icons/Clarity/scalable/apps/gnome-word.svg" },
  { "Document Viewer", "evince", "/usr/share/icons/Clarity/scalable/apps/evince.svg" },
  { "Evolution", "evolution", "/usr/share/icons/Clarity/scalable/apps/evolution.svg" },
  { "LibreOffice Calc", "libreoffice --calc", "/usr/share/icons/Clarity/scalable/apps/libreoffice-calc.svg" },
  { "LibreOffice Draw", "libreoffice --draw", "/usr/share/icons/Clarity/scalable/apps/libreoffice-draw.svg" },
  { "LibreOffice Impress", "libreoffice --impress", "/usr/share/icons/Clarity/scalable/apps/libreoffice-impress.svg" },
  { "LibreOffice Writer", "libreoffice --writer", "/usr/share/icons/Clarity/scalable/apps/libreoffice-writer.svg" }
}
submenu4 = {
  { "Weather", "gnome-weather", "/usr/share/icons/Clarity/scalable/status/weather-clear.svg" }
}
submenu5 = {
  { "gitg", "gitg", "/usr/share/icons/Clarity/scalable/categories/package_development.svg" },
  { "Git GUI", "git gui", "/usr/share/icons/Clarity/scalable/categories/package_development.svg" },
  { "Qt4 QDbusViewer", "qdbusviewer", "/usr/share/icons/Clarity/scalable/apps/dconf-editor.svg" }
}
submenu6 = {
  { "Cheese", "cheese", "/usr/share/icons/Clarity/scalable/apps/cheese.svg" },
  { "EasyTAG", "easytag", "/usr/share/icons/Clarity/scalable/apps/easytag.svg" },
  { "GNOME MPlayer", "gnome-mplayer", "/usr/share/icons/Clarity/scalable/apps/gnome-mplayer.svg" },
  { "Rhythmbox", "rhythmbox", "/usr/share/icons/Clarity/scalable/apps/rhythmbox.svg" },
  { "Videos", "totem", "/usr/share/icons/Clarity/scalable/apps/totem.svg" }
}
myappmenu = {
  { "Accessories",   submenu0, beautiful.icon_path .. "categories/applications-accessories.svg" },
  { "Graphics",      submenu1, beautiful.icon_path .. "categories/applications-graphics.svg" },
  { "Internet",      submenu2, beautiful.icon_path .. "categories/applications-internet.svg" },
  { "Office",        submenu3, beautiful.icon_path .. "categories/applications-office.svg" },
  { "Other",         submenu4, beautiful.icon_path .. "categories/applications-other.svg" },
  { "Programming",   submenu5, beautiful.icon_path .. "categories/applications-development.svg" },
  { "Sound & Video", submenu6, beautiful.icon_path .. "categories/applications-multimedia.svg" },
  { "System Tools",  submenu7, beautiful.icon_path .. "categories/applications-system.svg" }
}
