# Common additional configuration for desktop and laptop machines.
{ config, pkgs, ... }:

{
  imports = [ ./i3-gaps.nix
    ./spacemacs.nix];

    hardware.pulseaudio.enable = true;

    # Allow temporary web server
    # networking.firewall.allowedTCPPorts = [ 8888 ];

    environment.systemPackages = with pkgs; [
      ## system level stuff
      pciutils
      usbutils

      # Adjust screen brightness
      xflux

      # Imgur-Screenshot
      imgur-screenshot

      simplescreenrecorder

      ## Remote Desktop
      rdesktop
      telnet

      ##Webcam
      gnome3.cheese

      ## helm-recoll
      recoll

      ## Mount Android Phones
      mtpfs

      ## Image manipulation
      gimp

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

      ## Game Emulation
      libretro.vba-next
      libretro.snes9x-next
      snes9x-gtk
      zsnes
      mupen64plus
      retroarch
      emulationstation
      # mupen64

      # gmrun
      # gtkmenu
      # pa_applet
      rxvt_unicode-with-plugins
      termite
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

      ## Livestreammer
      python27Packages.livestreamer
      (import ./le-pkgs/livedumper.nix)

      (import ./le-pkgs/wakatime.nix)

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
      p7zip

      ## Social Security Toolkit
      # set
      # pefile

      ## Linux
      unetbootin
      parted

      # Better nixos package manager
      nox

      ## Media Center
      kodi

      ## Desktop Recording
      byzanz
      byzanz-record-window
      xlibs.xwininfo

      ## Streamming
      obs-studio


      ## Xorg utils
      xorg.xkill

      xlockmore
      ## Tmate
      # tmate

      ## zulip
      postgresql
      memcached
      rabbitmq_server
      python27Packages.ldap
    ];

    virtualisation.virtualbox.host.enable = true;
    # virtualisation.virtualbox.guest.enable = true;

    nixpkgs.config = {
      allowUnfree = true;
      firefox = {
        enableGoogleTalkPlugin = true;
        enableAdobeFlash = true;
      };

      # Download from this site http://download.virtualbox.org/virtualbox/5.0.0/Oracle_VM_VirtualBox_Extension_Pack-5.0.0-101573.vbox-extpack
      # then
      # nix-prefetch-url file://Oracle_VM_VirtualBox_Extension_Pack-5.0.0-101573.vbox-extpack

      virtualbox = {
        enableExtensionPack = true;
        pulseSupport = true;
      };

      chromium = {
        enablePepperFlash = true;
        enablePepperPDF = true;
        enableWideVine = true;
      };

    };

    nixpkgs.config.packageOverrides = pkgs: {

      byzanz-record-window = pkgs.callPackage "/etc/nixos/common/le-pkgs/byzanz-record-window" {};

      mupen64 = pkgs.callPackage "/etc/nixos/common/le-pkgs/mupen64" {};

      bar-xft = pkgs.callPackage "/etc/nixos/common/le-pkgs/bar-xft" {};

      tmate = pkgs.callPackage "/etc/nixos/common/le-pkgs/tmate" {};

      set = pkgs.callPackage "/etc/nixos/common/le-pkgs/set" {};

      pefile = pkgs.callPackage "/etc/nixos/common/le-pkgs/pefile" {};

      imgur-screenshot = pkgs.callPackage "/etc/nixos/common/le-pkgs/imgur-screenshot" {};

      minecraft = pkgs.callPackage "/etc/nixos/common/le-pkgs/minecraft" {};

      mineshafter = pkgs.callPackage "/etc/nixos/common/le-pkgs/mineshafter" {};

      obs-studio = with pkgs; obs-studio.overrideDerivation (attrs: rec {
        pulseaudioSupport = true;
      });
      # flashplayer = with pkgs; flashplayer.overrideDerivation (attrs: rec {
      #         version = "11.2.202.491";
      #         src = fetchurl {
      #             url = "http://fpdownload.adobe.com/get/flashplayer/pdc/${version}/install_flash_player_11_linux.x86_64.tar.gz";
      #             sha256 = "150zlnkq8jhhphfmyzdrpgi1y2sniqgx0a5ij994in3gvari9gpl";
      #         };
      #     });
    };

    fonts = {
      enableFontDir = true;
      enableGhostscriptFonts = true;
      fonts = with pkgs; [
        corefonts
        dejavu_fonts
        source-code-pro
        ubuntu_font_family
        powerline-fonts
        (import ./le-pkgs/sauce-code-pro-nerd-patched.nix)
        (import ./le-pkgs/knack-nerd-patched.nix)
        (import ./le-pkgs/font-hack.nix)
        (import ./le-pkgs/font-icons-ttf.nix)
        (import ./le-pkgs/font-input.nix)
        # Icons
        (import ./le-pkgs/font-octicons.nix)
        font-awesome-ttf
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

      displayManager = {
        # lightdm.enable = true;
        # lightdm.background = /home/jarvis/Pictures/uJHiPpX.jpg;
        slim = {
          enable = true;
          defaultUser = "jarvis";

          extraConfig = ''
            # login_cmd exec /home/jarvis/dotfiles/.config/EXWM/autostart
            console_cmd ${pkgs.xterm}/bin/xterm -T
            welcome_msg "Welcome to host"
          '';
          theme = pkgs.fetchgit{
            url = "https://github.com/CestDiego/slime-cestdiego-theme";
            rev = "f829c222240da5d3ba8a244f7243de4e63e21af9";
            sha256 = "10ae5efb1df404c1e5a05dd3356b6055df0515d2c9d67590d9e2ab38bb91f090";
          };
        };
      };
    };
  }
