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

    ## Heroku
    # heroku

    ## X to Nix
    python2nix

    # File System
    ranger

    # Languages
    pltScheme
    # System Monitor
    python27Packages.glances
    python27Packages.pip
    python27Packages.beautifulsoup4
    guile

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

    # Presentation thingy
    arandr

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

      heroku = pkgs.heroku.overrideDerivation (args: rec {
        version = "3.42.22";
        name = "heroku-${version}";

        src = pkgs.fetchurl {
            url = "https://s3.amazonaws.com/assets.heroku.com/heroku-client/heroku-client-${version}.tgz";
            sha256 = "1xm2wrlrip9fxbamljw0jxrl381gj4p1yi8wamm70zgqrjq78bkm";
        };
      });
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
