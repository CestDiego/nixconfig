{ stdenv, fetchurl, pkgs, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  name = "pefile-${version}";

  version = "1.2.10-139";


  src = fetchurl {
    url = "https://github.com/erocarrera/pefile/archive/pefile-${version}.tar.gz";
    sha256 = "0vg919slxdgr0rj5m4wcy65rx2m15hkyiwqqbw0zqpc1kx6y9q77";
  };

  buildInputs = [ pythonPackages.pexpect pkgs.git ];

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = http://www.erocarrera.com/;
    description = "Mopidy extension for playing music from Soundcloud";
    license = licenses.gpl3;
    maintainers = [ maintainers.CestDiego ];
  };
}
