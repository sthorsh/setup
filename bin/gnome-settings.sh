# URL
# https://stackoverflow.com/questions/39785698/keyboard-shortcuts-file-gnome

# Disable alt+pipe
# https://linux.m2osw.com/when-i-lose-gnome-settings
/usr/bin/gsettings set org.gnome.desktop.wm.keybindings switch-group "['disabled']"

# disable workspace shortcuts
/usr/bin/gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['disabled']"
/usr/bin/gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['disabled']"
/usr/bin/gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['disabled']"
/usr/bin/gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['disabled']"
