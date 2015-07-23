{ stdenv, fetchgit, pythonPackages, pygobject, gst_python
, gst_plugins_good, gst_plugins_base
}:

pythonPackages.buildPythonPackage rec {
  name = "mopidy-${version}";

  version = "1.0.8";
  http://www.soulseekqt.net/SoulseekQT/Linux/SoulseekQt-2014-11-30-64bit.tgz
  src = fetchgit {
    url = "https://github.com/mopidy/mopidy";
    rev = "refs/tags/${version}";
    sha256 = "0sjjj9z1dhilhpc8pq4154czrb79z9cm044jvn75kxcjv6v5l2m5";
  };
  propagatedBuildInputs = with pythonPackages; [
    gst_python pygobject pykka tornado gst_plugins_base gst_plugins_good
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
