{ stdenv, fetchurl, fetchgit, pythonPackages, pygobject, gst_python
, gst_plugins_good, gst_plugins_base, gst_ffmpeg, gst_plugins_ugly, gst_plugins_bad,
dbus_daemon
}:

pythonPackages.buildPythonPackage rec {
  name = "mopidy-${version}";

  version = "1.0.8";

  src = fetchurl {
    url = "https://github.com/mopidy/mopidy/archive/v${version}.tar.gz";
    sha256 = "1sph3v2wgc7vhic4wzslclm2a72cfx79fd6n2l0xqsyzd73qhzk4";
  };

  propagatedBuildInputs = with pythonPackages; [
    gst_python pygobject pykka tornado gst_plugins_base gst_plugins_good
    dbus_daemon
    # For some plugins like soundcloud of tunein
    gst_ffmpeg gst_plugins_ugly gst_plugins_bad
    # Mopify new dependency
    configobj
  ];

  # There are no tests
  doCheck = false;

  postInstall = ''
    wrapProgram $out/bin/mopidy \
      --prefix GST_PLUGIN_SYSTEM_PATH : "$GST_PLUGIN_SYSTEM_PATH"
  '';

  meta = with stdenv.lib; {
    homepage = http://www.mopidy.com/;
    description = ''
      An extensible music server that plays music from local disk, Spotify,
      SoundCloud, Google Play Music, and more
    '';
    license = licenses.asl20;
    maintainers = [ maintainers.rickynils ];
    hydraPlatforms = [];
  };
}
