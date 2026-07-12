# modules/system/gaming.nix
{ config, lib, pkgs, ... }:

{
  # ─── Graphics (Intel iGPU) ────────────────────────────────────────────────
  # NOTE: hardware.opengl was renamed to hardware.graphics in NixOS 24.11.
  # On nixos-unstable, use hardware.graphics exclusively.
  hardware.graphics = {
    enable     = true;
    enable32Bit = true;  # Required for Steam and Proton — do not skip

    extraPackages = with pkgs; [
      intel-media-driver    # VA-API (iHD) — modern Intel Gen 8+
      vpl-gpu-rt            # oneVPL/Quick Sync (replaces onevpl-intel-gpu on 25.x)
      intel-compute-runtime # OpenCL / Level Zero
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver    # 32-bit VA-API for Proton
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";  # Force modern iHD backend over i965
  };

  # ─── Steam ───────────────────────────────────────────────────────────────
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin  # GloriousEggroll Proton — better game compatibility
    ];
  };


  # ─── Gaming performance tools ─────────────────────────────────────────────
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud       # In-game performance overlay
    protonup-qt    # GUI for managing additional Proton versions
    vulkan-tools   # vulkaninfo — useful for diagnostics
    libva-utils    # vainfo — verify VA-API is working
    (discord.override {
      withOpenASAR = true;
    }) 
 ];

  # ─── Audio (PipeWire — likely already in desktop.nix, verify) ─────────────
  # If not already set in desktop.nix:
  # services.pipewire = {
  #   enable        = true;
  #   alsa.enable   = true;
  #   alsa.support32Bit = true;
  #   pulse.enable  = true;
  # };
  # security.rtkit.enable = true;

}
