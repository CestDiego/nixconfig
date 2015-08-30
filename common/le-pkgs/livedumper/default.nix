{ stdenv, fetchurl, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  name = "livedumper-${version}";

  version = "0.3.1";

  src = fetchurl {
    url = "https://github.com/m45t3r/livedumper/archive/v${version}.tar.gz";
    sha256 = "029as5jjsa86lgi4c78m0r4p47nbpdqw3nwkk7jfcyz244g69v7y";
  };

  propagatedBuildInputs = [ pythonPackages.livestreamer pythonPackages.requests2 pythonPackages.setuptools];

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = https://github.com/dirkgroenen/livedumper;
    description = "A mopidy webclient based on the Spotify webbased interface";
  };
}
