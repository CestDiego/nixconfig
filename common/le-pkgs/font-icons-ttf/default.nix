{stdenv, fetchurl, unzip}:

stdenv.mkDerivation rec {
  name = "font-icons-ttf-1.0";

  src = fetchurl {
    url = "https://www.dropbox.com/s/nypgaun7ckl97ga/icons.ttf";
    sha256 = "1mhwggmsh8a0p94ra6d4dscmz3k3y8fhfkfghcgiwzh6drgdsyhr";
  };

  buildCommand = ''
    echo "It's src: " $src
    mkdir -p $out/share/fonts/truetype
    cp $src $out/share/fonts/truetype
  '';

  meta = {
    description = "Font Icons - TTF font";

    longDescription = ''
        A non-overlapping mix of Ionicons and Awesome iconic fonts
    '';

    homepage = "https://www.dropbox.com/s/9iysh2i0gadi4ic/icons.pdf";
    license = stdenv.lib.licenses.ofl;

    platforms = stdenv.lib.platforms.all;
    maintainers = [ stdenv.lib.maintainers.cestdiego ];
  };
}
