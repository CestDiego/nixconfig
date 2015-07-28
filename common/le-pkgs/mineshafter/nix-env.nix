{
    allowUnfree = true; #- required when using oraclejdk and oraclejre

    packageOverrides = pkgs : with pkgs; {

        minecraftEnv = pkgs.myEnvFun {
          name = "minecraft";
          buildInputs = with pkgs; [ jdk jre xlibs.libX11 xlibs.libXext
                  xlibs.libXcursor xlibs.libXrandr xlibs.libXxf86vm mesa openal ];
          extraCmds = ''
    	export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:${jdk}/lib/${jdk.architecture}/:${jre}/lib/${jre.architecture}/:${xlibs.libX11}/lib/:${xlibs.libXext}/lib/:${xlibs.libXcursor}/lib/:${xlibs.libXrandr}/lib/:${xlibs.libXxf86vm}/lib/:${mesa}/lib/:${openal}/lib
    	export PATH=\$PATH:~/src/java/minecraft/bin
          '';
        };

        minecraftOracleEnv = pkgs.myEnvFun {
          name = "minecraftOracle";
          buildInputs = with pkgs; [ oraclejdk8 xlibs.libX11 xlibs.libXext
                  xlibs.libXcursor xlibs.libXrandr xlibs.libXxf86vm mesa openal ];
          extraCmds = ''
    	export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:${jdk}/lib/${jdk.architecture}/:${jre}/lib/${jre.architecture}/:${xlibs.libX11}/lib/:${xlibs.libXext}/lib/:${xlibs.libXcursor}/lib/:${xlibs.libXrandr}/lib/:${xlibs.libXxf86vm}/lib/:${mesa}/lib/:${openal}/lib
    	export PATH=\$PATH:~/src/java/minecraft/bin
          '';
        };
    }
}
