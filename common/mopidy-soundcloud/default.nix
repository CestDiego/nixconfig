{ stdenv, fetchurl, pkgs, pythonPackages, mopidy }:

pythonPackages.buildPythonPackage rec {
  name = "mopidy-soundcloud-${version}";

  version = "2.0.0";

  # src = fetchgit {
  #   url = "https://github.com/mopidy/mopidy-soundcloud";
  #   rev = "refs/tags/${version}";
  #   sha256 = "04apcs2wh1rigd5c4xxhlbb0cccfs58agmb0dgcs5fa0h6ximavg";
  # };

  src = fetchurl {
    url = "https://github.com/mopidy/mopidy-soundcloud/archive/v${version}.tar.gz";
    sha256 = "0vg919slxdgr0rj5m4wcy65rx2m15hkyiwqqbw0zqpc1kx6y9q77";
  };

  propagatedBuildInputs = [ mopidy pythonPackages.requests2 pkgs.dbus_daemon pkgs.gst_ffmpeg pkgs.gst_plugins_ugly pkgs.gst_plugins_bad ];

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = http://www.mopidy.com/;
    description = "Mopidy extension for playing music from Soundcloud";
    license = licenses.gpl3;
    maintainers = [ maintainers.CestDiego ];
  };
}
