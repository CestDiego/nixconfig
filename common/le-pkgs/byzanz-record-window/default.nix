{ stdenv, byzanz, pulseaudioFull, xwininfo }:

stdenv.mkDerivation rec {
  name = "byzanz-record-window-0.1";

  phases = [  "installPhase" "fixupPhase" ];

  inherit byzanz pulseaudioFull xwininfo;

  installPhase = ''
    mkdir -p "$out/share/byzanz-record-window"
    cp -v ${./ding.wav} "$out/share/byzanz-record-window/ding.wav"
    mkdir -p "$out/bin"
    cp -v ${./byzanz-record-window} "$out/bin/byzanz-record-window"

    substituteAllInPlace "$out/bin/byzanz-record-window"
  '';

  meta = {
    description = "Wrapper around byzanz-record to record specific X window";
  };
}
