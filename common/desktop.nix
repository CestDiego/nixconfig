# Common additional configuration for desktop and laptop machines.
{ config, pkgs, ... }:

{
    imports = [./i3-gaps.nix];
    # hardware.pulseaudio.enable = true;

    # Allow temporary web server
    # networking.firewall.allowedTCPPorts = [ 8888 ];

    environment.systemPackages = with pkgs; [
        ## system level stuff
        pciutils
        usbutils

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

        ## Emacs helpers
        ghostscript
        poppler_utils

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

        ## Disk Management
        python27Packages.udiskie

        ## Music
        mplayer
        ## Video
        mpv

        ## Games
        minecraft
        mineshafter
        openjdk

        ## SSH Clients
        mosh
        ## Zip Package
        unzip
    ];

    nixpkgs.config = {
        firefox = {
            enableGoogleTalkPlugin = true;
            enableAdobeFlash = true;
        };
        # chromium = {
        #     enablePepperFlash = true;
        #     enablePepperPDF = true;
        #     openjdk = true;
        # };
    };

    nixpkgs.config.packageOverrides = pkgs: {

        slop = pkgs.callPackage "/etc/nixos/common/slop" {};

        font-input = pkgs.callPackage "/etc/nixos/common/font-input" {};

        minecraft = pkgs.callPackage "/etc/nixos/common/minecraft" {};

        mineshafter = pkgs.callPackage "/etc/nixos/common/mineshafter" {};

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
            powerline-fonts
        ];
    };

    # Torrent
    services.deluge.enable = true;

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

        desktopManager.xterm.enable = false;
        displayManager.lightdm.enable = true;
    };
}
