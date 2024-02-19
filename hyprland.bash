source BIN/color

if [[ "$1" == "uninstall" ]]
then
	echo -e "${BRed}+ Uninstall in progress ...${Reset}"
	{
	cd SOURCE
	cd hyprland-source
	sudo make uninstall
	cd ../
	sudo rm -rf hyprland-source

	cd libdisplay-info-0.1.1
	cd build
	sudo ninja uninstall
	cd ../..
	sudo rm -rf libdisplay-info-0.1.1

	cd wayland-protocols-1.31
	cd build
	sudo ninja uninstall
	cd ../..
	sudo rm -rf wayland-protocols-1.31

	cd wayland-1.22.0
	cd build
	sudo ninja uninstall
	cd ../..
	sudo rm -rf wayland-1.22.0
	} > /dev/null
	echo -e "${BRed}+ Uninstall finished.${Reset}"
	exit
fi

echo -e "${BRed}+ Install dependancies${Reset}"
sudo apt install meson wget build-essential ninja-build cmake-extras cmake gettext gettext-base fontconfig libfontconfig-dev libffi-dev libxml2-dev libdrm-dev libxkbcommon-x11-dev libxkbregistry-dev libxkbcommon-dev libpixman-1-dev libudev-dev libseat-dev seatd libxcb-dri3-dev libvulkan-dev libvulkan-volk-dev vulkan-validationlayers-dev libvkfft-dev libgulkan-dev libegl-dev libgles2 libegl1-mesa-dev glslang-tools libinput-bin libinput-dev libxcb-composite0-dev libavutil-dev libavcodec-dev libavformat-dev libxcb-ewmh2 libxcb-ewmh-dev libxcb-present-dev libxcb-icccm4-dev libxcb-render-util0-dev libxcb-res0-dev libxcb-xinput-dev xdg-desktop-portal-wlr hwdata libgbm-dev libpango1.0-dev xwayland edid-decode

echo -e "${BRed}+ Extracting ...${Reset}"
{
cd SOURCE
sudo rm -rf hyprland-source/ libdisplay-info-0.1.1/ wayland-1.22.0/ wayland-protocols-1.31/
tar -xJf libdisplay-info-0.1.1.tar.xz
tar -xzf source-v0.24.1.tar.gz
tar -xJf wayland-1.22.0.tar.xz
tar -xJf wayland-protocols-1.31.tar.xz
} > /dev/null

echo -e "${BPurple}BUILD and INSTALL proccess${Reset}"
echo -e "${BRed}only errors will be printed to make debug easier if error appears when launching Hyprland${Reset}"
sleep 3

echo -e "${BYellow}+ Build & install wayland${Reset}"
{
cd wayland-1.22.0
mkdir build
cd build
meson setup .. --prefix=/usr --buildtype=release -Ddocumentation=false
ninja
sudo ninja install
cd ../..
} > /dev/null

echo -e "${BYellow}+ Build & install wayland-protocols${Reset}"
{
cd wayland-protocols-1.31
mkdir build
cd build
meson setup --prefix=/usr --buildtype=release
ninja
sudo ninja install
cd ../..
} > /dev/null

echo -e "${BYellow}+ Build & install libdisplay-info${Reset}"
{
cd libdisplay-info-0.1.1/
mkdir build
cd build
meson setup --prefix=/usr --buildtype=release
ninja
sudo ninja install
cd ../..
} > /dev/null

echo -e "${BYellow}+ Build & install Hyprland${Reset}"
{
chmod a+rw hyprland-source
cd hyprland-source/
sed -i 's/\/usr\/local/\/usr/g' config.mk
sudo make install
cd ../..
} > /dev/null

mkdir -p $HOME/.config/hypr
cp CONFIG/hyprland.conf $HOME/.config/hypr


echo -ne "${BPurple}Want install some software that fit on ${BYellow}Hyprland ${BPurple}and ${BYellow}Wayland? ${BWhite}[RECOMMANDED](yn)${Reset}"
read ANS
case ANS in ""|"Y"|"y")
	bash utility.bash;;
esac
