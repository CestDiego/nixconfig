{ stdenv, fetchurl, gfortran, gcc, perl}:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "libxc-2.2.2";

  src = fetchurl {
    url = "http://www.tddft.org/programs/octopus/down.php?file=libxc/libxc-2.2.2.tar.gz";
    sha256 = "0hn6gkm1cazf5vh1k3h1lvl4vm9sy9kvq1q7jrcisd6wbyxx18bc";
  };

  buildInputs = [ gfortran gcc perl];

  CFLAGS = "-fPIC";
  CPPLAGS = "-fPIC";
  FCCPP = "-ffreestanding";

  meta = {
    description = "Libint2 for Horton";
  };
}
