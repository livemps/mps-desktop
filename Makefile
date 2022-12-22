# --- Makefile setup ----------------------------------------------------------
default: all
all: desktop-full
.PHONY: all default help prepare wallpaper i3-config i3-desktop \
	gui-tools desktop-min desktop-full
# --- Makefile config (APT) ---------------------------------------------------
APT_GUI_ESSENTIALS  := galculator gedit gedit-plugins numlockx arandr
APT_GUI_TERMINAL    := gnome-terminal
APT_GUI_ICONS       := lxde-icon-theme gnome-extra-icons
APT_GUI_WEB_CLIENTS := firefox-esr thunderbird
APT_GUI_TXT_CLIENTS := evince gedit gedit-plugins
APT_GUI_MM_CLIENTS  := vlc
APT_DSK_X           := xorg xserver-xorg-video-nouveau xserver-xorg-video-vesa
APT_DSK_THUNAR      := thunar thunar-data thunar-archive-plugin \
						thunar-media-tags-plugin thunar-volman \
						xfce4-goodies xfce4-places-plugin \
						thunar-gtkhash thunar-vcs-plugin file-roller
APT_DSK_I3          := lightdm i3 compton rofi arc-theme
APT_DSK_X           := xbacklight
APT_DSK_GNOME_TOOLS := gnome-system-monitor python3-netifaces gitsome 
APT_PYTHON          := python3-pygit2 python3-netifaces 
# --- Help --------------------------------------------------------------------
help:
	@echo "Usage: make TARGET"
	@echo ""
	@echo "  Targets:"
	@echo "     desktop-min   : i3 desktop"
	@echo "     desktop-tools : desktop-min  + gui tools"
	@echo ""
# --- Update ------------------------------------------------------------------
prepare:
	sudo apt update -y && sudo apt upgrade -y
	-mkdir -p ~/.config
# --- HOME folder -------------------------------------------------------------
wallpaper: prepare
	cp dotfiles/.config/mimeapps.list ~/.config/
	cp -r dotfiles/.config/images/ ~/.config/
	cp -r dotfiles/.config/kitty ~/.config/
	
i3-config: wallpaper
	cp -r dotfiles/.config/i3/ ~/.config/
	cp -r dotfiles/.config/rofi/ ~/.config/
	cp -r dotfiles/.config/kitty/ ~/.config/
	cp -r dotfiles/.config/compton.conf ~/.config/
# --- APT Installers ----------------------------------------------------------
i3-desktop: i3-config
	sudo apt install $(APT_DSK_I3) $(APT_DSK_X) $(APT_DSK_GNOME_TOOLS) $(APT_PYTHON)
gui-tools:
	sudo apt install $(APT_GUI_ESSENTIALS) $(APT_GUI_TERMINAL) $(APT_GUI_ICONS) \
		$(APT_GUI_WEB_CLIENTS) $(APT_GUI_TXT_CLIENTS) $(APT_GUI_MM_CLIENTS) $(APT_DSK_THUNAR) -y
# --- Meta-Targets ------------------------------------------------------------
desktop-min: i3-desktop
desktop-full: desktop-min gui-tools

