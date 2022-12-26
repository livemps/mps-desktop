# --- Makefile setup ----------------------------------------------------------
default: all
all: desktop-full
.PHONY: all default help prepare wallpaper i3-config i3-desktop \
	gui-tools desktop-min desktop-full
# --- Makefile config (APT) ---------------------------------------------------
APT_GUI_ESSENTIALS  := galculator gedit gedit-plugins numlockx arandr
APT_GUI_TERMINAL    := gnome-terminal kitty
APT_GUI_ICONS       := lxde-icon-theme gnome-extra-icons
APT_GUI_WEB_CLIENTS := firefox-esr thunderbird
APT_GUI_TXT_CLIENTS := evince gedit gedit-plugins
APT_GUI_MM_CLIENTS  := vlc
APT_DSK_X           := xorg xserver-xorg-video-nouveau xserver-xorg-video-vesa
APT_DSK_OPENGL      := mesa-utils libglu1-mesa-dev freeglut3-dev \
						mesa-common-dev libglew-dev libglfw3-dev \
						libglm-dev libao-dev libmpg123-dev
APT_DSK_BUMBLEBEE   := psutils gnome-system-monitor xcwd \
						iw pulseaudio aptitude \
						python3-tk progress python3-dbus
APT_DSK_THUNAR      := thunar thunar-data thunar-archive-plugin \
						thunar-media-tags-plugin thunar-volman \
						xfce4-goodies xfce4-places-plugin \
						thunar-gtkhash thunar-vcs-plugin file-roller
APT_DSK_I3          := lightdm i3 compton rofi feh arc-theme \
						lxappearance pnmixer pavucontrol
APT_DSK_FONTS		:= fonts-font-awesome fonts-fork-awesome
APT_DSK_X           := xbacklight
APT_DSK_GNOME_TOOLS := gnome-system-monitor gitsome gitsome \
						network-manager-gnome 
APT_PYTHON          := python3-netifaces python3-pygit2 python3-psutil pip    
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
	
i3-config: wallpaper
	cp -r dotfiles/.config/i3/ ~/.config/
	cp -r dotfiles/.config/rofi/ ~/.config/
	cp -r dotfiles/.config/kitty/ ~/.config/
	cp -r dotfiles/.config/compton.conf ~/.config/
# --- APT Installers ----------------------------------------------------------
i3-desktop: i3-config
	sudo apt install $(APT_DSK_I3) $(APT_DSK_X) $(APT_DSK_GNOME_TOOLS) \
		$(APT_GUI_TERMINAL) $(APT_PYTHON) $(APT_DSK_FONTS) $(APT_DSK_BUMBLEBEE)
	pip install bumblebee-status
	sudo update-alternatives --set x-terminal-emulator /usr/bin/kitty
gui-tools:
	sudo apt install $(APT_GUI_ESSENTIALS) $(APT_GUI_ICONS) \
		$(APT_GUI_WEB_CLIENTS) $(APT_GUI_TXT_CLIENTS) \
		$(APT_GUI_MM_CLIENTS) $(APT_DSK_THUNAR) -y
	sudo update-alternatives --set x-www-browser /usr/bin/firefox-esr
	cp dotfiles/.gtkrc-2.0 ~/.gtkrc-2.0
	cp -r dotfiles/.config/Thunar ~/.config/
	cp -r dotfiles/.config/xfce4 ~/.config/
	cp -r dotfiles/.config/gtk-3.0 ~/.config/
# --- Meta-Targets ------------------------------------------------------------
desktop-min: i3-desktop
desktop-full: desktop-min gui-tools

