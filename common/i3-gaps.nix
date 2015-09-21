# i3 desktop config
{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
    dmenu2     # for app launcher
    feh       # for background image
    i3
    i3lock    # screen lock
    i3status  # sys info
    i3blocks  # clickable bar


    # for i3Blocks
    acpi # battery 
    openvpn
    lm_sensors
    sysstat

    rofi
    rofi-pass
    pass

    gnome3.dconf
    gnome3.adwaita-icon-theme
    gnome.gnome_icon_theme
    gnome3.gnome_themes_standard

    numix-gtk-theme
    numix-icon-theme
    # Theme Switcher
    lxappearance

    xorg.utilmacros
    xorg.xcursorgen
    xorg.xcursorthemes
    ];

    networking.networkmanager.enable = true;
    services.dbus.enable = true;

    nixpkgs.config.packageOverrides = pkgs: {
        # i3 = pkgs.stdenv.lib.overrideDerivation pkgs.i3 (oldAttrs: rec {
        #     src = pkgs.fetchgit {
        #         url = "http://github.com/Airblader/i3.git";
        #         rev = "refs/heads/gaps-next";
        #         sha256 = "0pv56llkxdqb46j6fxkh43vvgc6i7xpvqry26xyvq85chs2v17q9";
        #     };

        #     postUnpack = ''
        #         find .
        #         echo $out
        #         echo -n "4.10.2 (2015-07-14, branch \\\"gaps-next\\\")" > ./i3/I3_VERSION
        #         echo -n "4.10.2" > ./i3/VERSION
        #     '';
        # });
        i3blocks = pkgs.callPackage "/etc/nixos/common/le-pkgs/i3blocks" {};

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

    # desktopManager = {
    #   default = "none";
    #   xterm.enable = false;
    # };
  };
}
