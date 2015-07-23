{ stdenv, pkgs, fetchurl, pythonPackages, mopidy }:

pythonPackages.buildPythonPackage rec {
  name = "mopidy-tunein-${version}";

  version = "0.2.2";

  # src = fetchgit {
  #   url = "https://github.com/kingosticks/mopidy-tunein";
  #   rev = "refs/tags/${version}";
  #   sha256 = "1pkdqbk32pdvdds6m1w47ymrbkbqwbpjky71imh0faw08f7289n8";
  # };

  src = fetchurl {
    url = "https://github.com/kingosticks/mopidy-tunein/archive/v${version}.tar.gz";
    sha256 = "16x848l497xzy7yskv36xxdl28i4l4r29xhz091ypcc84jjpvv5s";
  };

  propagatedBuildInputs = [ mopidy pythonPackages.requests2 pkgs.dbus_daemon pkgs.gst_ffmpeg pkgs.gst_plugins_ugly pkgs.gst_plugins_bad ];

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = http://www.mopidy.com/;
    description = "Mopidy extension for playing music from TuneIn Radio";
    license = licenses.gpl3;
    maintainers = [ maintainers.CestDiego ];
  };
}
