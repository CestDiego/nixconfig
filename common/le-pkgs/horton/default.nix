{ pkgs, stdenv, fetchurl, pythonPackages, python, atlas, libint2, libxc}:

pythonPackages.buildPythonPackage rec {
  name = "horton-${version}";

  version = "2.0.0";

  src = fetchurl {
    url = "https://github.com/theochem/horton/archive/${version}.tar.gz";
    sha256 = "05wf0waj8795qmibwr4827n1xx94z4b813d0inj6zdk0qgkkm2b3";
  };

  refatoms = fetchurl {
    url = "http://users.ugent.be/~tovrstra/horton/refatoms.tar.bz2";
    sha256 = "000j0q0ws6jfnh8cp467nhj3k8jqxh39ajd5cpizdwi30wqyndfl";
  };

  buildInputs = (with pythonPackages; [
    numpy h5py scipy nose sympy matplotlib
  ]) ++ (with pkgs; [cython atlas curl libint2 libxc]);


  LIBINT2_LIBRARY_DIRS="${libint2}/lib";
  LIBINT2_INCLUDE_DIRS="${libint2}/include/libint2";
  LIBINT2_LIBRARIES = "int2";

  LIBXC_LIBRARY_DIRS="${libxc}/lib";
  LIBXC_INCLUDE_DIRS="${libxc}/include";
  LIBXC_LIBRARIES = "xc";

  BLAS_INCLUDE_DIRS="${atlas}/include";
  BLAS_LIBRARY_DIRS="${atlas}/lib";
  BLAS_LIBRARIES="atlas";

  postBuild = "(cd data/refatoms; tar -xvjf $refatoms; chmod +x ./fixformat.py; ${python.interpreter} ./fixformat.py)";

  doCheck = true;

  checkPhase = ''
   export HORTONDATA="$out/share/horton";
   export PYTHONPATH="$out/lib/python2.7/site-packages/:$out/lib/python2.7/site-packages/horton:$PYTHONPATH"
   echo "Le PYTHONPATH: " $PYTHONPATH;
   echo "Le horton Data: " $HORTONDATA;
   nosetests -v horton;
  '';

  meta = with stdenv.lib; {
    homepage = http://www.theochem.github.io/horton/;
    description = ''
        HORTON: Helpful Open-source Research TOol for N-fermion systems.
    '';
    # maintainers = [ maintainers.rickynils ];
  };
}
