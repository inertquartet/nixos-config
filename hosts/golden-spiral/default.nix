{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
    ../../modules/system/boot.nix
    ../../modules/system/networking.nix
    ../../modules/system/locale.nix
    ../../modules/system/security.nix
    ../../modules/system/common.nix
    ../../modules/system/desktop.nix
  ];

  networking.hostName = "golden-spiral";

  # Your primary user
  users.users.inertquartet = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    # No password set here — use `passwd` after first boot,
    # or manage via home-manager's hashedPasswordFile option
  };
  
  # 1Password CLI + GUI with polkit integration
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "inertquartet" ];
  };

  # Allow sudo for wheel group
  security.sudo.wheelNeedsPassword = true;

  system.stateVersion = "25.11"; # Set this to the NixOS version you install with; never change it after
}
