# i3 desktop config
{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
    dmenu2     # for app launcher
    feh       # for background image
    i3
    i3lock    # screen lock
    i3status  # sys info

    gnome3.dconf
    gnome.gnome_icon_theme
    gnome3.gnome_themes_standard

    xorg.utilmacros
    xorg.xcursorgen
    xorg.xcursorthemes
    ];

    networking.networkmanager.enable = true;
    services.dbus.enable = true;

    nixpkgs.config.packageOverrides = pkgs: {
        i3 = pkgs.stdenv.lib.overrideDerivation pkgs.i3 (oldAttrs: rec {
            src = pkgs.fetchgit {
                url = "http://github.com/Airblader/i3.git";
                rev = "refs/heads/gaps-next";
                sha256 = "81b2c65663c3ce13a7e62f233d5d902fe50dd0356b7a239807f30230c40670d5";
            };

            postUnpack = ''
                find .
                echo $out
                echo -n "4.10.2 (2015-07-14, branch \\\"gaps-next\\\")" > ./i3/I3_VERSION
                echo -n "4.10.2" > ./i3/VERSION
            '';
        });

        i3lock = pkgs.stdenv.lib.overrideDerivation pkgs.i3lock (oldAttrs: rec {
            src = pkgs.fetchgit {
                url = "https://github.com/eBrnd/i3lock-color.git";
                rev = "refs/heads/master";
                sha256 = "8f6ad6683f7977903bb92731b2d4ca7a990a84d6a867640c4930be97c6a146af";
            };

        });
    };

  services.xserver = {
    windowManager = {
      i3.enable = true;
      default = "i3";
    };

    # displayManager = {
    #   sessionCommands = "i3status &";
    # };

    desktopManager = {
      default = "none";
      xterm.enable = false;
    };
  };
}
