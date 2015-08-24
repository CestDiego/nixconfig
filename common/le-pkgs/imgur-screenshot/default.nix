{ stdenv, curlFull, gnugrep, scrot, xclip, libnotify }:

stdenv.mkDerivation rec {
  name = "imgur-screenshot-1.5.4";

  phases = [  "installPhase" "fixupPhase" ];

  inherit curlFull gnugrep scrot xclip libnotify;

  installPhase = ''
    mkdir -p "$out/share/imgur-screenshot"
    cp -v ${./ding.wav} "$out/share/imgur-screenshot/ding.wav"
    mkdir -p "$out/bin"
    cp -v ${./imgur-screenshot} "$out/bin/imgur-screenshot"

    substituteAllInPlace "$out/bin/imgur-screenshot"
  '';

  meta = {
    description = "Wrapper around imgur-screenshot to upload shit";
  };
}
