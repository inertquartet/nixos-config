# modules/system/printing.nix
{ config, lib, pkgs, ... }:

{
  services.printing = {
    enable = true;
  # No drivers needed — IPP Everywhere handles it
  };

  # Network discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Scanning (SANE) — use hplipWithPlugin only if sane-backends alone
  # doesn't discover the scanner
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
  };

  users.users.inertquartet.extraGroups = [ "scanner" "lp" ];
}


