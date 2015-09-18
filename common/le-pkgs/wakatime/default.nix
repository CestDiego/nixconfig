{ stdenv, fetchurl, python, pythonPackages}:

pythonPackages.buildPythonPackage rec {
  name = "wakatime-${version}";

  version = "4.1.7";

  src = fetchurl {
    url = "https://github.com/wakatime/wakatime/archive/${version}.tar.gz";
    sha256 = "0wril5d9qj61qc5pcqkbv276b2s4cz39rjwn8i49i1ghzqy8bll2";
  };

  meta = with stdenv.lib; {
    homepage = http://www.wakatime.com/;
    description = ''
    WakaTime was built to solve time tracking for programmers.

    Since we work inside a text editor, why should we have to start and stop a timer? WakaTime uses open-source text editor plugins to automatically track the time you spend programming so you never have to manually track it again!

    P.S. wakati means time in Swahili
    '';
  };
}
