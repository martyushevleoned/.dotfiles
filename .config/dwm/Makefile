.PHONY: all

build:
	make -C dwm clean
	make -C dwm X11INC=/usr/include X11LIB=/usr/lib/x86_64-linux-gnu
	sudo make -C dwm install

setup:
	sudo apt install -y \
		build-essential \
		libx11-dev \
		libxft-dev \
		libxinerama-dev \
		stterm \
		suckless-tools \
		x11-xserver-utils

run:
	startx $(shell which dwm)
