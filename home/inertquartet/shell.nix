{ config, pkgs, ... } :
{
  programs.bash.enable = true;
 
  home.shellAliases = {
    snap-home = "sudo snapper -c home create --description";
  };
}
