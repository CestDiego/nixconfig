{
    allowUnfree = true;
    firefox = {
        enableGoogleTalkPlugin = true;
        enableAdobeFlash = true;
    };

    # chromium = {
    #     enablePepperFlash = true;
    #     enablePepperPDF = true;
    #     enableWideVine = true;
    # };

    packageOverrides = pkgs : with pkgs ; rec {
        all = with pkgs; buildEnv {
        name = "all";
        paths = [
            emacs
            file
        ];
        };

    };
}
