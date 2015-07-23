{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
    git
    python27
    emacs
    vim
    silver-searcher
    ## Le locate and updatedb

    ## Music
    ncmpcpp
    # mopidy
    # mopidy-spotify
    # mopidy-mopify
    ];

    services.mopidy = {
        enable = true;
        # extensionPackages = [ pkgs.mopidy-spotify pkgs.mopidy-mopify ];
        extensionPackages = [   pkgs.mopidy-soundcloud
                                pkgs.mopidy-moped
                                pkgs.mopidy-mopify
                                pkgs.mopidy-tunein ];
        configuration = ''
            [local]
            enabled = true
            media_dir = /home/jarvis/Music/mopidy

            [soundcloud]
            auth_token = 1-35204-19558561-b8d3bc2c3bd5ecb
            explore_songs = 25

            # [spotify]
            # enabled = true
            # username = ${username}
            # password = ${password}
            # bitrate = 320
            # timeout = 10

            # [mopify]
            # enabled = true
            # debug = false
        '';
    };

    nixpkgs.config.packageOverrides = pkgs: {
        mopidy = pkgs.callPackage "/etc/nixos/common/mopidy" {};
        mopidy-mopify = pkgs.callPackage "/etc/nixos/common/mopidy-mopify" {};
        ncmpcpp = pkgs.callPackage "/etc/nixos/common/ncmpcpp" {};
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
        mopidy-soundcloud = pkgs.callPackage "/etc/nixos/common/mopidy-soundcloud" {};
        mopidy-tunein = pkgs.callPackage "/etc/nixos/common/mopidy-tunein" {};
        };
}
