{ stdenv, fetchgit, curl }:

stdenv.mkDerivation rec {
  version = "0.1.0";
  name = "pushblast-${version}";

  src = fetchgit {
    url = "https://github.com/alebcay/pushblast";
    rev = "6e7265aa3153e9f505046cfdcb653b009d179c45";
    sha256 = "1al8msvpzdkm02yfzj4a51cla39bx78p1s2d0f907rkcvyvs097s";
  };

  buildInputs = [curl];
  installPhase = ''
    echo "This dir"
    pwd
    ls $src
    mkdir -p $out/bin
    cp $src/pushblast $out/bin/
    sed -i s,/usr/local,$out, $out/bin/pushblast
  '';

  meta = {
      description = "A sandbox-building game";
      homepage = http://www.minecraft.net;
      maintainers = [ stdenv.lib.maintainers.page ];
      license = stdenv.lib.licenses.unfreeRedistributable;
  };
}
