{ makeWrapper, stdenv, fetchurl, oraclejdk8, jre, libX11, libXext, libXcursor, libXrandr, libXxf86vm
, mesa, openal
, useAlsa ? false, alsaOss ? null }:

assert useAlsa -> alsaOss != null;

stdenv.mkDerivation {
  name = "mineshafter-2015.07.24";

  src = fetchurl {
    url = "http://mineshafter.info/s/Mineshafter-launcher.jar";
    sha256 = "0f8w8dymz5qd97krwmjw14mpb6pzfqhd6mji92gi38f5bpzbpi3i";
  };

  buildInputs = [ makeWrapper oraclejdk8 libX11 libXext jre
                    libXcursor libXrandr libXxf86vm mesa openal ];
  buildCommand = ''
    mkdir -pv $out/bin
    cp -v $src $out/minecraft.jar


    cat > $out/bin/mineshafter << EOF
    #!${stdenv.shell}

    ${if useAlsa then "${alsaOss}/bin/aoss" else "" } \
      ${oraclejdk8}/bin/java -jar $out/minecraft.jar
    EOF

    chmod +x $out/bin/mineshafter

    wrapProgram $out/bin/mineshafter \
      --set JAVA_HOME "${oraclejdk8}" \
      --suffix LD_LIBRARY_PATH : "${libX11}/lib/:${libXext}/lib/:${libXcursor}/lib/:${libXrandr}/lib/:${libXxf86vm}/lib/:${mesa}/lib/:${openal}/lib"
  '';

  meta = {
      description = "A sandbox-building game";
      homepage = http://www.mineshafter.net;
      maintainers = [ stdenv.lib.maintainers.page ];
      license = stdenv.lib.licenses.unfreeRedistributable;
  };
}
