{stdenv, fetchurl, unzip}:

stdenv.mkDerivation rec {
  name = "font-octicons-1.0";

  src = fetchurl {
    url = file://Octicons.ttf;
    sha256 = "0m9csk188agdxcb3qvyg54ikbdvkik11d5m01xvsf1vq0000nbkz";
  };

  buildCommand = ''
    mkdir -p $out/share/fonts/truetype
    cp $src $out/share/fonts/truetype
  '';

  meta = {
    description = "GitHub's Icon Font";
    homepage = "https://www.dropbox.com/s/9iysh2i0gadi4ic/icons.pdf";
  };
}
