{ config, pkgs, lib, ... }:

{
  # systemd-based initramfs — required for TPM2+PIN and FIDO2+PIN unlock
  # This replaces the legacy busybox stage 1 with a proper systemd environment
  boot.initrd.systemd.enable = true;

  # systemd-boot as bootloader
  # Generations appear in the boot menu automatically — this is your rollback UI
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;  # keep last 10 generations in boot menu
    editor = false;           # disable boot entry editing (security: prevents kernel param tampering)
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # LUKS2 device
  # After install, enroll TPM2 and FIDO2 keyslots with systemd-cryptenroll.
  # This declaration tells the initramfs how to unlock it at boot.
  boot.initrd.luks.devices."cryptroot" = {
    device = "/dev/disk/by-uuid/6117ec91-278c-4ff9-b381-44e009e9fe16"; # replace after partitioning
  };

  # Make cryptsetup available in initramfs for emergency recovery
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" "tpm_tis" ];

  # Ensure systemd-cryptenroll tooling is available in the live system
  environment.systemPackages = with pkgs; [
    cryptsetup        # cryptenroll, luksOpen, etc.
    tpm2-tools        # TPM2 diagnostics
    sbctl             # Secure Boot key management (needed for Phase 3 / lanzaboote)
  ];

  # Emergency/rescue mode: ensure your user can log in
  # This gives you a root shell on emergency.target without requiring the graphical stack
  systemd.enableEmergencyMode = true; # don't auto-reboot on emergency — let you intervene

  # Phase 3 placeholder — uncomment when adding lanzaboote:
  # boot.loader.systemd-boot.enable = lib.mkForce false;
  # boot.lanzaboote = {
  #   enable = true;
  #   pkiBundle = "/etc/secureboot";
  # };
}
