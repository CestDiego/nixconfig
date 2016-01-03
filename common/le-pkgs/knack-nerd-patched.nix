with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "hack-font-2.0.0";

  src = fetchurl {
    url = file://Knack.ttf;
    sha256 = "1gh10lg3qcljivx3vgadl9za814hb0cz49z7i6p3jgp0i6r9afbm";
    };


  buildCommand = let
    fonts_dir = "$out/share/fonts/opentype";
  in ''
    ls
    mkdir -pv ${fonts_dir}
    cp $src ${fonts_dir}
  '';

  meta = {
    homepage = https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack;
    description = "Hack font patched with lots of icons";
  };
}
