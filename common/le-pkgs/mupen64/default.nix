{stdenv, fetchurl, which, pkgconfig, SDL, gtk, mesa, SDL_ttf, glibc}:

stdenv.mkDerivation {
  name = "mupen64plus-2.0";

  src = fetchurl {
    url = "https://github.com/mupen64plus/mupen64plus-core/releases/download/2.5/mupen64plus-bundle-linux64-2.5.tar.gz";
    sha256 = "13mlhfi3jyrvjz0s71q311fflpp50amksin5isqsh487h6r9smic";
  };

  buildInputs = [ which pkgconfig SDL gtk mesa SDL_ttf glibc];


  installPhase = ''
    # Remove PATH environment variable from install script
    sed -i -e "s|export PATH=|#export PATH=|" ./install.sh
    sed -i -e "s|/sbin/ldconfig|ldconfig|" ./install.sh
    ./install.sh $out
  '';

  # preConfigure = ''
  #   # Some C++ incompatibility fixes
  #   sed -i -e 's|char \* extstr = strstr|const char * extstr = strstr|' glide64/Main.cpp
  #   sed -i -e 's|char \* extstr = strstr|const char * extstr = strstr|' glide64/Combine.cpp

  #   # Fix some hardcoded paths
  #   sed -i -e "s|/usr/local|$out|g" main/main.c

  #   # Remove PATH environment variable from install script
  #   sed -i -e "s|export PATH=|#export PATH=|" ./install.sh
  # '';

  # buildPhase = "make all";

  # installPhase = "PREFIX=$out make install";

  meta = {
    description = "A Nintendo 64 Emulator";
    homepage = http://code.google.com/p/mupen64plus;
  };
}
