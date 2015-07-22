# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./common/base.nix
      ./common/desktop.nix
    ];

    programs.zsh.enable = true;

    time.timeZone = "US/Central";

    nixpkgs.config.allowUnfree = true;
    # Use the gummiboot efi boot loader.
    boot.loader.gummiboot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos"; # Define your hostname.
    networking.hostId = "afbdf530";
    networking.wireless.enable = true;  # Enables wireless.

    # Select internationalisation properties.
    i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
    };

    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = with pkgs; [
    wget
    dropbox

    ## Music
    mpd
    ncmpcpp

    ## Video
    mpv

    ## Email
    gnupg
    offlineimap
    w3m

    ## Applications
    skype

    ];

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Enable udev rules for Android devices
    services.udev.packages = with pkgs; [ android-udev-rules ];

    services.locate.enable = true;
    # Enable CUPS to print documents.
    # services.printing.enable = true;

    # # Set up backup job
    # systemd.services.home-backup = {
    #   enable = true;
    #   description = "Backup my home directory";
    #   startAt = "*-*-* 01:00:00";
    #   path = with pkgs; [ rsync ];
    #   script = ''
    #     rsync -av --delete /home/nafai/ /media/MyBook2TB/Backup/shedemei/home/nafai/
    #   '';
    # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.jarvis = {
    isNormalUser = true;
    home = "/home/jarvis";
    shell = "/run/current-system/sw/bin/zsh";
    description = "Diego Berrocal";
    extraGroups = [ "wheel" "audio" "networkmanager"];
  };

}
