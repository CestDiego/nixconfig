{ stdenv, fetchFromGitHub, perl, libxcb , libXft}:

let
  version = "1.0";
in
  stdenv.mkDerivation rec {
    name = "bar-xft-${version}";

    src = fetchFromGitHub {
        owner = "krypt-n";
        repo = "bar";
        rev = "020a3e1848ce03287886e9ff80b0b443e9aed543";
        sha256 = "1slpprl09bpdh2h359nbxwyji3ihl77djhi6qi7j1ji85zdx9xwa";
    };

    buildInputs = [ libxcb perl libXft ];

    prePatch = ''sed -i "s@/usr@$out@" Makefile'';

    meta = {
      description = "A lightweight xcb based bar with xft font support";
      homepage = https://github.com/LemonBoy/bar;
      maintainers = [ stdenv.lib.maintainers.meisternu ];
      license = "Custom";
      platforms = stdenv.lib.platforms.linux;
    };
}
