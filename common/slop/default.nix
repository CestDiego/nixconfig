{ stdenv, fetchgit, cmake, mesa, pkgconfig, libX11, libXext, libXrender, glew, glm, libXrandr }:

stdenv.mkDerivation rec {
  name = "slop-${version}";
  version = "4.2.18";

  src = fetchgit {
    url = "https://github.com/naelstrof/slop";
    rev = "refs/tags/v${version}";
    sha256 = "0668k74a7jpiqmgy0yp99pcywr5k318j6qpvwjz8jhn266wpq1ki";
  };

 buildInputs = [ cmake libX11 libXext mesa pkgconfig libXrender glew libXrandr glm ];

 meta = with stdenv.lib; {
  homepage = https://github.com/naelstrof/slop;
  description = "slop (Select Operation) is an application that queries for a selection from the user and prints the region to stdout.";
  # maim (make image) takes screenshots of your desktop. It has
  # options to take only a region, and relies on slop to query for
  # regions. maim is supposed to be an improved scrot.
  license = licenses.gpl3;

  platforms = platforms.linux;
  # maintainers = [ maintainers.kmicu ];
 };
}
