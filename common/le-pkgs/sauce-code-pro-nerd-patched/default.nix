{ stdenv, fetchurl}:

stdenv.mkDerivation {
  name = "sauce-code-pro-nerd-patched-0.4.1";

  src1 = fetchurl {
    url = file://SauceCodePowerlineNerdPatchedMono.otf;
    sha256 = "0a0rj14f3d4lxj88hc7bxlnkzn3ln074dq2gxrzmz2dw79i493q4";
  };

  src2 = fetchurl {
    url = file://SauceCodePowerlineNerdPatched.otf;
    sha256 = "10fmhfzdzcn8ijypl2jz5rk1ii619rlqyf0h8vk4k12qkcyy3gl4";
  };

  buildCommand = let
    fonts_dir = "$out/share/fonts/opentype";
  in ''
    ls
    pwd
    mkdir -pv ${fonts_dir}
    cp $src1 ${fonts_dir}
    cp $src2 ${fonts_dir}
  '';

  meta = {
    homepage = https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/SourceCodePro;
    description = "Sauce Code Pro patched with lots of icons";
  };
}
