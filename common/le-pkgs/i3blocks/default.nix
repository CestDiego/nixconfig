{ stdenv, fetchurl, pkgs}:

stdenv.mkDerivation rec {
    name = "i3blocks-${version}";
    version = "1.4";

    src = fetchurl {
        url = "https://github.com/vivien/i3blocks/archive/${version}.tar.gz";
        sha256 = "1c5l51fz4mzz4mrcdg7ra85bj41w2asq736z3y1acalhnxa2igf9";
    };

    buildInputs = with pkgs; [rubygems git i3
                              openvpn lm_sensors acpi sysstat];

    SSL_CERT_FILE="/etc/ssl/certs/ca-bundle.crt";
    buildPhase = ''
        export HOME=`pwd`
        export GEM_HOME=`pwd`/gem
        export PATH=$PATH:$GEM_HOME/bin
        export RUBYLIB=${pkgs.rubygems}/lib
        gem install ronn
        make all
    '';

    makeFlags = "all";
    installFlags = "PREFIX=\${out} SYSCONFDIR=\${out}/etc";

    postInstall = ''
        mkdir -p $out/share/man/man1
        cp *.1 $out/share/man/man1
    '';

    meta = with stdenv.lib; {
        description = "A simple screen locker like slock";
    };

}
