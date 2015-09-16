/*
  Please understand and agree to the terms here
  if you are going to use this:
  http://input.fontbureau.com/download
*/

{ stdenv, fetchurl, unzip}:

stdenv.mkDerivation {
  name = "font-hack-2.013";
  src = fetchurl {
    url = "https://github.com/chrissimpkins/Hack/releases/download/v2.013/Hack-v2_013-ttf.zip";
    md5 = "ff656d8c80daae7eec792ac15f8e8917";
  };

  phases = "installPhase";

  buildInputs = [ unzip ];

  installPhase = let
    fonts_dir = "$out/share/fonts/truetype";
  in ''
    echo "Dis be the dir: " $PWD
    ${unzip}/bin/unzip $src
    ls
    mkdir -pv ${fonts_dir}
    find . -name "*.ttf" -exec cp {} ${fonts_dir} \;
  '';

  meta = {
    homepage = "http://sourcefoundry.org/hack/";
    description = "Hack font";
  };
}
