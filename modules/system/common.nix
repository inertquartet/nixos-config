{ pkgs, ... }:

{
  # zram swap — better than a swapfile on a laptop with SSD
  # avoids writing compressed swap to your encrypted Btrfs unnecessarily
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  # Firmware updates via fwupd — important for the 7420 (Dell actively publishes updates)
  services.fwupd.enable = true;

  # Pipewire audio (modern replacement for PulseAudio)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Printing (optional but useful)
  services.printing.enable = true;

  # Flatpak for GUI apps that fight with Nix packaging
  services.flatpak.enable = true;

  # Base system packages — keep this list small; user packages go in Home Manager
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    vim
  ];

  # Nix settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ]; # enable flakes
    auto-optimise-store = true; # deduplicate Nix store entries
  };

  # Automatic garbage collection — keeps disk usage from growing unbounded
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d"; # keep last 30 days of generations
  };
}
