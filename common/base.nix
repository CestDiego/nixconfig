{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    subversion
    emacs
    vim
    silver-searcher
    ## Le locate and updatedb

    ## Music
    ncmpcpp
    mpc_cli

    ## Terminal Apps
    fasd
    ngrok # <- this lets you get http stuff.

    ## Langs
    python27
    clojure
    leiningen

    ## X to Nix
    python2nix

    # File System
    ranger

    # System Monitor
    python27Packages.glances

    # mopidy
    # mopidy-spotify
    # mopidy-mopify
    john
    # pushblast
    bluez
    # horton

    ## needed for killall command
    psmisc

    nmap
    nmap_graphical
    wireshark

    atlas
    libxc
    libint2

    # Virtualization
    lxc
    vagrant

    # VirtualEnvs
    python27Packages.virtualenv
  ];

  # services.tor.client.enable
  # services.tor.client = {

  # }
  services.mopidy = {
    enable = true;
    # extensionPackages = [ pkgs.mopidy-spotify pkgs.mopidy-mopify ];
    extensionPackages = [
      # pkgs.mopidy-soundcloud
      pkgs.mopidy-moped
      pkgs.mopidy-mopify
      pkgs.mopidy-tunein
    ];
    configuration = ''
    [local]
      enabled = true
      media_dir = "/home/jarvis/Music/mopidy"
      '';
    };

    nixpkgs.config.packageOverrides = pkgs: {
      mopidy = pkgs.callPackage "/etc/nixos/common/le-pkgs/mopidy" {};
      mopidy-mopify = pkgs.callPackage "/etc/nixos/common/le-pkgs/mopidy-mopify" {};
      pushblast = pkgs.callPackage "/etc/nixos/common/le-pkgs/pushblast" {};
      horton = pkgs.callPackage "/etc/nixos/common/le-pkgs/horton" {};
      libint2 = pkgs.callPackage "/etc/nixos/common/le-pkgs/libint2" {};
      libxc = pkgs.callPackage "/etc/nixos/common/le-pkgs/libxc" {};
      ncmpcpp = pkgs.callPackage "/etc/nixos/common/le-pkgs/ncmpcpp" {};
      # ncmpcpp = pkgs.lib.overrideDerivation pkgs.ncmpcpp (attrs: rec {
      #     name = "ncmpcpp-${version}";
      #     version = "0.6.5";

      #     src = pkgs.fetchurl {
      #         url = "http://ncmpcpp.rybczak.net/stable/${name}.tar.bz2";
      #         sha256 = "1zfidkskmiqx1wfykinmr639lhd90s7b0rks6vaci4n56ml8y4ji";
      #     };

      #     outputsSupport = true;
      #     visualizerSupport = true;
      #     clockSupport = true;
      # });
    } // {
    # mopidy-soundcloud = pkgs.callPackage "/etc/nixos/common/le-pkgs/mopidy-soundcloud" {};
    mopidy-tunein = pkgs.callPackage "/etc/nixos/common/le-pkgs/mopidy-tunein" {};
  };
}
