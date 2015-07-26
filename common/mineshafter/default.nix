{ stdenv, fetchurl, jre, libX11, libXext, libXcursor, libXrandr, libXxf86vm
, mesa, openal
, useAlsa ? false, alsaOss ? null }:

assert useAlsa -> alsaOss != null;

stdenv.mkDerivation {
  name = "mineshafter-2015.07.24";

  src = fetchurl {
    url = "http://mineshafter.info/s/Mineshafter-launcher.jar";
    sha256 = "0f8w8dymz5qd97krwmjw14mpb6pzfqhd6mji92gi38f5bpzbpi3i";
  };

  phases = "installPhase";

  installPhase = ''
    set -x
    mkdir -pv $out/bin
    cp -v $src $out/mineshafter.jar

    cat > $out/bin/mineshafter << EOF
    #!${stdenv.shell}

    # wrapper for mineshafter
    export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:${libX11}/lib/:${libXext}/lib/:${libXcursor}/lib/:${libXrandr}/lib/:${libXxf86vm}/lib/:${mesa}/lib/:${openal}/lib/
    ${if useAlsa then "${alsaOss}/bin/aoss" else "" } \
      ${jre}/bin/java -jar $out/mineshafter.jar
    EOF

    chmod +x $out/bin/mineshafter
  '';

  meta = {
      description = "A sandbox-building game";
      homepage = http://www.mineshafter.net;
      maintainers = [ stdenv.lib.maintainers.page ];
      license = stdenv.lib.licenses.unfreeRedistributable;
  };
}
