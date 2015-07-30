# Common additional configuration for desktop and laptop machines.
{ config, pkgs, ... }:

{
    imports = [ ./i3-gaps.nix
                ./spacemacs.nix
              ];
    # hardware.pulseaudio.enable = true;

    # Allow temporary web server
    # networking.firewall.allowedTCPPorts = [ 8888 ];

    environment.systemPackages = with pkgs; [
        ## system level stuff
        pciutils
        usbutils

        ## Remote Desktop
        rdesktop
        telnet

        ## Mount Android Phones
        mtpfs

        ## Utils
        xclip
        xlibs.xbacklight
        xcalib

        # Notification
        libnotify

        ## Either chose dunst or notify-osd
        # dunst
        notify-osd

        ## Graphics utilities
        imagemagick

        dropbox

        ## basic devlopment apps
        # vimHugeX

        ## Transparency
        compton
        ## Monitor
        conky

        # gmrun
        # gtkmenu
        # pa_applet
        rxvt_unicode-with-plugins
        xdotool
        xlibs.xmodmap
        xsel

        ## Battery Notifications
        sutils

        # Screenshot
        maim

        ## Rectangle Selection
        slop

        ## Network
        gnome3.networkmanagerapplet

        ## Multitouch Gestures
        touchegg

        ## Applications
        dmenu2     # for app launcher

        firefoxWrapper

        skype
        chromium
        htop
        tmux

        # Lemonbar
        bar-xft

        ## Disk Management
        python27Packages.udiskie

        ## Music
        mplayer
        ## Video
        mpv

        ## Games
        steam
        minecraft
        mineshafter
        # openjdk
        oraclejdk8

        ## SSH Clients
        mosh
        ## Zip Package
        unzip

    ];

    # services.virtualboxHost.enable = true;
    # services.virtualboxGuest.enable = true;

    nixpkgs.config = {
        firefox = {
            enableGoogleTalkPlugin = true;
            enableAdobeFlash = true;
        };
        # chromium = {
        #     enablePepperFlash = true;
        #     enablePepperPDF = true;
        #     enableWideVine = true;
        #     openjdk = true;
        # };
    };

    nixpkgs.config.packageOverrides = pkgs: {

        slop = pkgs.callPackage "/etc/nixos/common/le-pkgs/slop" {};

        bar-xft = pkgs.callPackage "/etc/nixos/common/le-pkgs/bar-xft" {};

        font-icons-ttf = pkgs.callPackage "/etc/nixos/common/le-pkgs/font-icons-ttf" {};

        font-input = pkgs.callPackage "/etc/nixos/common/le-pkgs/font-input" {};

        minecraft = pkgs.callPackage "/etc/nixos/common/le-pkgs/minecraft" {};

        mineshafter = pkgs.callPackage "/etc/nixos/common/le-pkgs/mineshafter" {};

        flashplayer = with pkgs; flashplayer.overrideDerivation (attrs: rec {
                version = "11.2.202.491";
                src = fetchurl {
                    url = "http://fpdownload.adobe.com/get/flashplayer/pdc/${version}/install_flash_player_11_linux.x86_64.tar.gz";
                    sha256 = "150zlnkq8jhhphfmyzdrpgi1y2sniqgx0a5ij994in3gvari9gpl";
                };
            });
    };

    fonts = {
        enableFontDir = true;
        enableGhostscriptFonts = true;
        fonts = with pkgs; [
            corefonts
            dejavu_fonts
            source-code-pro
            font-awesome-ttf
            ubuntu_font_family
            font-input
            font-icons-ttf
            powerline-fonts
        ];
    };

    # Torrent
    services.deluge.enable = true;

    ## Hardware
    hardware.bumblebee.enable = true;
    # hardware.bumblebee.connectDisplay = true;
    hardware.opengl.driSupport32Bit = true;

    # Enable the X11 windowing system.
    services.xserver = {
        enable = true;
        layout = "us";
        autorun = true;

        # Enable TouchPad
        synaptics.enable = true;
        synaptics.twoFingerScroll = true;
        synaptics.horizontalScroll = true;
        synaptics.buttonsMap = [ 1 3 2 ];

        # Hardware Acceleration
        vaapiDrivers = [ pkgs.vaapiIntel ];
        # vaapiDrivers = [ pkgs.vaapiVdpau ];
        # videoDrivers = [ "nvidiaLegacy340" ];

        desktopManager.xterm.enable = false;
        displayManager.lightdm.enable = true;
    };
}
