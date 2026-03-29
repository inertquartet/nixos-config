{ config, pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
    ./apps.nix
  ];

  home.username = "inertquartet";
  home.homeDirectory = "/home/inertquartet";

  # Must match system.stateVersion in your host config
  home.stateVersion = "25.11";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
