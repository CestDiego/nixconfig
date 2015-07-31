{ stdenv, fetchurl, jre, libX11, libXext, libXcursor, libXrandr, libXxf86vm
, mesa, openal
, useAlsa ? false, alsaOss ? null }:

assert useAlsa -> alsaOss != null;

stdenv.mkDerivation {
    name = "nand2tetris";

    src = fetchurl {
        url = "http://www.nand2tetris.org/software/nand2tetris.zip";
        sha256 = "04pj4l5q0a64jncm2kk45r7nxnxa2z9n110dcxbbahdi6wk0png8";
    };

    unpackPhase = ''
    unzip $src
    cd nand2tetris
    ls -lha
    '';
    phases = "installPhase";

    installPhase = ''
        # set -x
        # mkdir -pv $out/bin
        # cp -v $src $out/nand2tetris.jar

        # cat > $out/bin/nand2tetris << EOF
        # #!${stdenv.shell}

        # # wrapper for nand2tetris
        # export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:${libX11}/lib/:${libXext}/lib/:${libXcursor}/lib/:${libXrandr}/lib/:${libXxf86vm}/lib/:${mesa}/lib/:${openal}/lib/
        # ${if useAlsa then "${alsaOss}/bin/aoss" else "" } \
        #   ${jre}/bin/java -jar $out/nand2tetris.jar
        # EOF

        # chmod +x $out/bin/nand2tetris
    '';

    meta = {
        description = "A sandbox-building game";
        homepage = http://www.nand2tetris.net;
        maintainers = [ stdenv.lib.maintainers.page ];
        license = stdenv.lib.licenses.unfreeRedistributable;
    };
}
