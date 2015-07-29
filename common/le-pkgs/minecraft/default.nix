{ makeWrapper, stdenv, fetchurl, oraclejdk8, jre, libX11, libXext, libXcursor, libXrandr, libXxf86vm
, mesa, openal
, useAlsa ? false, alsaOss ? null }:

assert useAlsa -> alsaOss != null;

stdenv.mkDerivation {
  name = "minecraft-2015.07.24-oracle";

  src = fetchurl {
    url = "https://s3.amazonaws.com/Minecraft.Download/launcher/Minecraft.jar";
    sha256 = "04pj4l5q0a64jncm2kk45r7nxnxa2z9n110dcxbbahdi6wk0png8";
  };

  buildInputs = [ makeWrapper oraclejdk8 libX11 libXext jre
                    libXcursor libXrandr libXxf86vm mesa openal ];
  buildCommand = ''
    mkdir -pv $out/bin
    cp -v $src $out/minecraft.jar


    cat > $out/bin/minecraft << EOF
    #!${stdenv.shell}

    ${if useAlsa then "${alsaOss}/bin/aoss" else "" } \
      ${oraclejdk8}/bin/java -jar $out/minecraft.jar
    EOF

    chmod +x $out/bin/minecraft

    wrapProgram $out/bin/minecraft \
      --set JAVA_HOME "${oraclejdk8}" \
      --suffix LD_LIBRARY_PATH : "${libX11}/lib/:${libXext}/lib/:${libXcursor}/lib/:${libXrandr}/lib/:${libXxf86vm}/lib/:${mesa}/lib/:${openal}/lib"
  '';

  meta = {
      description = "A sandbox-building game";
      homepage = http://www.minecraft.net;
      maintainers = [ stdenv.lib.maintainers.page ];
      license = stdenv.lib.licenses.unfreeRedistributable;
  };
}
