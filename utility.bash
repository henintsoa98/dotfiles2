source BIN/color

CONFIG=$HOME/.config
BIN=/usr/local/bin

PARAM ()
{
	case "$1" in
		"kitty")
			mkdir -p $CONFIG/kitty
			cp CONFIG/kitty.conf $CONFIG/kitty;;
		"wofi")
			mkdir -p $CONFIG/wofi
			cp CONFIG/wofi.css $CONFIG/wofi/style.css;;
		"waybar")
			mkdir -p $CONFIG/waybar
			cp CONFIG/waybar.conf $CONFIG/waybar/config
			cp CONFIG/waybar.css $CONFIG/waybar/style.css
			sudo cp BIN/hyprland-workspace $BIN
			sudo cp BIN/hyprland-diskio $BIN
			sudo chmod a+x $BIN/hyprland-workspace
			sudo chmod a+x $BIN/hyprland-diskio;;
		"light")
			sudo usermod -aG video $USER
			sudo chgrp video /sys/class/backlight/*/brightness
			sudo chmod 664 /sys/class/backlight/*/brightness
			sudo light -N 1
			light -N 1;;
		"pcmanfm")
			INSTALL lxappearance LXDE GTK+ ${BYellow}theme switcher${Reset};;
		"zsh")
			INSTALL REC git \(zsh dependencies\) fast, scalable, distributed revision control system
			INSTALL REC curl \(zsh dependencies\) command line tool "for" transferring data with URL syntax
			rm -rf $HOME/.oh-my-zsh
			echo -e "${BYellow}Accept${Reset} zsh to be ${BYellow}default shell${Reset}"
			echo -e "${BYellow}After entering${Reset} into zsh shell ${BYellow}(with oh-my-zsh)${Reset} : ${BRed}'exit'${BYellow} zsh to finish installation${Reset}"
			sleep 3
			sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
			git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
			git clone --depth 1 https://github.com/zsh-users/zsh-completions $HOME/.oh-my-zsh/custom/plugins/zsh-completions
			git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
			cp CONFIG/bureau_mod.zsh-theme $HOME/.oh-my-zsh/custom/themes/
			cp CONFIG/CUSTOMRC $HOME/.CUSTOMRC
			echo "source \$HOME/.CUSTOMRC" >> $HOME/.zshrc
			sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bureau_mod"/' $HOME/.zshrc
			sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-completions zsh-syntax-highlighting web-search command-not-found dirhistory)/' $HOME/.zshrc;;
		"emacs")
			cp CONFIG/emacs $HOME/.emacs
			mkdir -p $HOME/.emacs.snippets
			cp -r CONFIG/emacs.snippets/* $HOME/.emacs.snippets
			echo -e "${BPurple}after running emacs for first time, it will install some package, and wait until it finished."
			echo -e "exit it and copy CONFIG/doom-henintsoa-theme.el to .emacs.d/elpa/doom-themes-<some date>/"
			echo -e "<alt-x> customize-themes, and select this theme, and save to next session${Reset}";;
		"MINIMAL")
			INSTALL REC alsa-utils \(MINIMAL dependencies\) Utilities "for" configuring and using ${BYellow}ALSA${Reset}
			INSTALL REC asciinema \(MINIMAL dependencies\) ${BYellow}Record and share your terminal sessions${Reset}, the right way
			INSTALL REC command-not-found \(MINIMAL dependencies\) ${BYellow}Suggest installation of packages${Reset} in interactive bash sessions
			INSTALL REC mdp \(MINIMAL dependencies\) command-line based ${BYellow}Markdown presentation tool${Reset}
			INSTALL REC network-manager \(MINIMAL dependencies\) ${BYellow}network management${Reset} framework \(daemon and userspace tools\)
			INSTALL REC ssh \(MINIMAL dependencies\) ${BYellow}secure shell${Reset} client and server \(metapackage\)
			INSTALL REC sshfs \(MINIMAL dependencies\) filesystem client based on ${BYellow}SSH File Transfer${Reset} Protocol
			INSTALL REC vim \(MINIMAL dependencies\) Vi IMproved - ${BYellow}enhanced vi editor${Reset};;
	esac
}

INSTALL ()
{
	if [[ "$1" == "REC" ]]
	then
		APP="$2"
		DES=$(echo "$@" |sed "s/^REC $APP//")
		REC="${BCyan}[RECOMMANDED] ${BYellow}>${Reset}"
	else
		APP="$1"
		DES=$(echo "$@" |sed "s/$APP//")
		REC="${BYellow}>${Reset}"
	fi
		
	echo -ne "${BRed}$APP ${REC}$DES (yn) : ${BRed}"

	read ANS
	echo -e ${Reset}
	case $ANS in ""|"Y"|"y")
		if [[ "$APP" == "MINIMAL" ]]
		then
			echo "Go !!!"
		else
			sudo apt install $APP
		fi
		PARAM $APP;;
	esac

}

echo -e "${BPurple}Select some package to make Hyprland more useful 😉${Reset}"

cd SOURCE
mkdir -p $HOME/.fonts
tar -xJf SauceCodeProNerdFontMono.tar.xz
mv *.ttf $HOME/.fonts
cd ..

INSTALL REC kitty fast, featureful, GPU based ${BYellow}terminal emulator${Reset}

INSTALL REC wofi ${BYellow}application launcher${Reset} for wlroots based wayland compositors

INSTALL REC waybar Highly customizable ${BYellow}Wayland bar${Reset} for Sway and Wlroots based compositors

INSTALL REC light control display backlight controllers and LEDs

INSTALL REC fonts-noto-color-emoji ${BYellow}color emoji${Reset} font from Google

INSTALL REC firefox-esr Mozilla Firefox ${BYellow}web browser${Reset} - Extended Support Release \(ESR\)

INSTALL REC vlc ${BYellow}multimedia player${Reset} and streamer

INSTALL REC pcmanfm extremely fast and lightweight ${BYellow}file manager${Reset}

INSTALL REC swayimg ${Byellow}image viewer${Reset} for Sway/Wayland

INSTALL gdu Pretty fast ${BYellow}disk usage analyzer${Reset}

INSTALL REC gparted GNOME ${BYellow}partition editor${Reset}

INSTALL REC zsh ${BYellow}shell${Reset} with lots of features

INSTALL emacs GNU Emacs ${BYellow}editor${Reset} \(metapackage\)

INSTALL REC MINIMAL ${BPurple}IMPORTANT PACKAGE \(alsa-utils asciinema command-not-found mdp modemmanager network-manager ssh sshfs vim\)${Reset}

echo -e "${BRed}now, launch Hyprland you install this, or run this command again if you forget to install some package"
echo -e "${BCyan}You can test zsh now\n"
echo -e "${BYellow}Have FUN 😉${Reset}"
