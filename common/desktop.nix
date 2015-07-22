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

        ## Utils
        xclip
        xlibs.xbacklight
        # Notification
        libnotify
        ## Either chose dunst or notify-osd
        # dunst
        notify-osd

        ## Graphics utilities
        imagemagick

        ## basic devlopment apps
        # vimHugeX

        ## Emacs helpers
        ghostscript
        poppler_utils

        ## Basic X
        compton
        # gmrun
        # gnome3.adwaita-icon-theme
        # gnome3.gnome_themes_standard
        # gtkmenu
        # pa_applet
        rxvt_unicode-with-plugins
        xdotool
        xlibs.xmodmap
        xsel

        ## Rectangle Selection
        maim
        slop

        ## Multitouch Gestures
        touchegg

        ## Applications
        dmenu2     # for app launcher
        firefoxWrapper
        chromium
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
        ];
    };

    # Torrent
    services.deluge.enable = true;

    # Enable the X11 windowing system.
    services.xserver = {
        enable = true;
        layout = "us";
        autorun = true;

        # Enable TouchPad
        synaptics.enable = true;
        synaptics.twoFingerScroll = true;
        synaptics.horizontalScroll = true;
        # synaptics.buttonsMap = [ 1 3 1 ];

        # Hardware Acceleration
        vaapiDrivers = [ pkgs.vaapiIntel ];

        desktopManager.xterm.enable = false;
        displayManager.lightdm.enable = true;
    };
}
