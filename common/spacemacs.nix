{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    emacs
    silver-searcher
  ];

}
