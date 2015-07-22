{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    python
    emacs
    vim
    silver-searcher
  ];

}
