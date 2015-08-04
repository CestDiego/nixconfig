{ stdenv, fetchurl, gfortran, gcc}:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "libint-2.0.3-stable";

  src = fetchurl {
    url = "http://downloads.sourceforge.net/project/libint/libint-for-mpqc/libint-2.0.3-stable.tgz";
    sha256 = "00jv1xw5jwfi5y4z912ri5l7kvnyqw6v35p3nh2qvc30dvnl8jax";
  };

  buildInputs = [ gfortran gcc ];

  CFLAGS = "-fPIC";
  CPPFLAGS = "-fPIC";
  CONFIG_SHELL= "/bin/sh";
  configureFlags = [
  "--with-cxx-optflags='-O1'"
  ];

  preConfigure = ''
    sed s,/bin/rm,rm, -i configure
    sed s,/bin/rm,rm, -i Makefile
  '';



  meta = {
    description = "Libint2 for Horton";
  };
}
