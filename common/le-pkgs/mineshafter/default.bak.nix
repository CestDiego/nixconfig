{ stdenv, makeWrapper, fetchurl, openjdk, lib, libX11, libXext, libXcursor, libXinerama, libXrandr, libXxf86vm
, mesa, openal, alsaOss, pulseaudioSupport ? false, libpulseaudio }:

stdenv.mkDerivation rec {
  name = "minecraft-lel";

  # src = fetchurl {
  #   url = "http://s3.amazonaws.com/Minecraft.Download/launcher/Minecraft.jar";
  #   sha256 = "04pj4l5q0a64jncm2kk45r7nxnxa2z9n110dcxbbahdi6wk0png8";
  # };

  buildInputs = [ makeWrapper ];

  buildPhase = "true";

    libPath = lib.makeLibraryPath [ openjdk libXrandr libXinerama libXcursor mesa openal alsaOss libpulseaudio ];

  unpackPhase = "true";

  installPhase = ''
    mkdir -pv $out/bin
    cp -v ${./Minecraft.jar} $out/minecraft.jar

    cat > $out/bin/minecraft << EOF
    #!${stdenv.shell}

    # wrapper for minecraft
    ${openjdk}/bin/java -jar $out/minecraft.jar
    EOF

    chmod +x $out/bin/minecraft

    wrapProgram $out/bin/minecraft -- prefix LD_LIBRARY_PATH : "${libPath}"

  '';

  meta = {
      description = "A sandbox-building game";
      homepage = http://www.minecraft.net;
      maintainers = [ stdenv.lib.maintainers.page ];
      license = stdenv.lib.licenses.unfreeRedistributable;
  };
}
