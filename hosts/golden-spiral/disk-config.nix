{ ... }:

{
  # Btrfs subvolume mounts — adjust UUIDs after partitioning
  # The LUKS container is declared in boot.nix; these mount what's inside it

  fileSystems."/" = {
    device = "/dev/mapper/cryptroot";
    fsType = "btrfs";
    options = [ "subvol=@" "compress=zstd:3" "noatime" ];
  };

  fileSystems."/home" = {
    device = "/dev/mapper/cryptroot";
    fsType = "btrfs";
    options = [ "subvol=@home" "compress=zstd:3" "noatime" ];
  };

  fileSystems."/nix" = {
    device = "/dev/mapper/cryptroot";
    fsType = "btrfs";
    # noatime is important here — the Nix store has enormous numbers of reads
    options = [ "subvol=@nix" "compress=zstd:3" "noatime" ];
  };

  fileSystems."/.snapshots" = {
    device = "/dev/mapper/cryptroot";
    fsType = "btrfs";
    options = [ "subvol=@snapshots" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/098F-3B19";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ]; # restrict EFI partition permissions
  };

  swapDevices = []; # use zram instead — declared in common.nix
}
