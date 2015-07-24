with import <nixpkgs> {}; with xlibs;

stdenv.mkDerivation rec {
    name = "minecraft";
    buildInputs = [ makeWrapper ];

    buildPhase = "true";

    libPath = lib.makeLibraryPath [ openjdk libXrandr libXinerama libXcursor ];

    unpackPhase = "true";

    installPhase = ''
    mkdir -p $out/bin
    cp ${./mybinaryprogram} $out/bin/mybinaryprogram
    wrapProgram $out/bin/mybinaryprogram \
        --prefix LD_LIBRARY_PATH : "${libPath}"
    '';
}
