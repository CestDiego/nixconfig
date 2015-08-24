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

        ## helm-recoll
        recoll

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

        ## LaTeX
        (pkgs.texLiveAggregationFun { paths = [ pkgs.texLive pkgs.texLiveExtra pkgs.texLiveBeamer ]; })

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

        ## Torrent
        deluge

        ## Printing
        gutenprint

        ## Network
        gnome3.networkmanagerapplet

        ## Font
        gnome3.gucharmap

        ## Multitouch Gestures
        touchegg

        ## Applications
        dmenu2     # for app launcher

        firefoxWrapper

        skype
        chromium
        htop
        tmux

        popcorntime

        ## Disk Management
        python27Packages.udiskie

        ## Music
        mplayer
        spotify
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
        unrar

        ## Social Security Toolkit
        # set
        # pefile

        ## Linux
        unetbootin
        parted

        ## Pentests
        aircrackng

        ## Media Center
        kodi

        ## Desktop Recording
        byzanz
        byzanz-record-window
        xlibs.xwininfo

        ## Streamming
        obs-studio

        ## Tmate
        # tmate
   ];

    virtualisation.virtualbox.host.enable = true;
    # services.virtualboxGuest.enable = true;

    nixpkgs.config = {
        allowUnfree = true;
        firefox = {
            enableGoogleTalkPlugin = true;
            enableAdobeFlash = true;
        };

        chromium = {
            enablePepperFlash = true;
            enablePepperPDF = true;
            enableWideVine = true;
        };

    };

    nixpkgs.config.packageOverrides = pkgs: {

        byzanz-record-window = pkgs.callPackage "/etc/nixos/common/le-pkgs/byzanz-record-window" {};

        slop = pkgs.callPackage "/etc/nixos/common/le-pkgs/slop" {};

        bar-xft = pkgs.callPackage "/etc/nixos/common/le-pkgs/bar-xft" {};

        set = pkgs.callPackage "/etc/nixos/common/le-pkgs/set" {};

        pefile = pkgs.callPackage "/etc/nixos/common/le-pkgs/pefile" {};

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

    ## Printing
    services.printing= {
        enable = true;
        webInterface = true;
        drivers = [ pkgs.gutenprint ];
    };

    ## Hardware
    hardware.bumblebee.enable = true;
    hardware.opengl.driSupport32Bit = true;

    # hardware.bumblebee.connectDisplay = true;

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
        # displayManager.lightdm.enable = true;
        # displayManager.lightdm.background = /home/jarvis/Pictures/uJHiPpX.jpg;
        displayManager.slim.enable = true;
        displayManager.slim.defaultUser = "jarvis";
        displayManager.slim.theme = pkgs.fetchgit{
            url = "https://github.com/CestDiego/slime-cestdiego-theme";
            rev = "f829c222240da5d3ba8a244f7243de4e63e21af9";
            sha256 = "10ae5efb1df404c1e5a05dd3356b6055df0515d2c9d67590d9e2ab38bb91f090";
        };
    };
}
