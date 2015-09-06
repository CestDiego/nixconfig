set -e
source $stdenv/setup

installPhase() {
    cd projects/unix
    make all SHAREDIR=$out
    PREFIX=$out make install LIBDIR=$out SHAREDIR= $out
}
