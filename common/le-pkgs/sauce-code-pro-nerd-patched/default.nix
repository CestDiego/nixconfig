{ stdenv, fetchurl}:

stdenv.mkDerivation {
  name = "sauce-code-pro-nerd-patched-0.4.1";

  src1 = fetchurl {
    url = file://SauceCodePowerlineNerdPatchedMono.otf;
    md5 = "177f0f3890e8a28cceb7446af7c99d9a";
  };

  src2 = fetchurl {
    url = file://SauceCodePowerlineNerdPatched.otf;
    md5 = "3e0f4cb370c33b9f8cfb3dc7cdfada4d";
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
