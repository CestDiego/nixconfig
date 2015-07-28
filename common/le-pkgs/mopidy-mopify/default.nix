{ stdenv, fetchgit, pythonPackages, mopidy }:

pythonPackages.buildPythonPackage rec {
  name = "mopidy-mopify-${version}";

  version = "1.5.4";

  src = fetchgit {
    url = "https://github.com/dirkgroenen/mopidy-mopify";
    rev = "refs/tags/${version}";
    sha256 = "07nllsa9npzdmic0kp4jisfxh3886qwvsayx646hq7vvlc7dwhyf";
  };

  propagatedBuildInputs = [ mopidy ];

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = https://github.com/dirkgroenen/mopidy-mopify;
    description = "A mopidy webclient based on the Spotify webbased interface";
    license = licenses.gpl3;
    maintainers = [ maintainers.Gonzih ];
  };
}
