{
  description = "Chad's NixOS configuration";

  inputs = {
    # The main NixOS package set. "nixos-unstable" gives you rolling fresh packages.
    # If you want a stable base, use "nixos-24.11" (or current stable) instead.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager — tracks the same branch as nixpkgs to avoid version mismatches
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";  # critical: use the same nixpkgs, not a second copy
    };

    # Lanzaboote for Secure Boot — add now, enable in Phase 3
    lanzaboote = {
      # url = "github:nix-community/lanzaboote/v1.0.0";
      
      # Resolve issue introduced by recent NixOS unstable change that disallows setting `bootspec.enable`
      # This is done by pinning to a lanzaboote commit that addresses this issue
      # Ref: https://github.com/nix-community/lanzaboote/pull/617
      url = "github:nix-community/lanzaboote/0403b4b7e8b2612657f0053a4c315e6c43eee9e6";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hardware: community collection of per-device hardware quirk modules
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, lanzaboote, nixos-hardware, ... }@inputs: {

    nixosConfigurations.golden-spiral = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # Pass inputs through so host/module files can reference them if needed
      specialArgs = { inherit inputs; };

      modules = [
      {
        # allow 1Password even thought it's "unfree" software
        nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
          "1password"
          "1password-cli"
          "1password-gui"
	  "discord"
          "steam"
          "steam-unwrapped"
          "hplip"
        ];
      }

        # nixos-hardware module for Dell Latitude 7420 — handles Intel GPU quirks,
        # power management, and known firmware workarounds automatically
        nixos-hardware.nixosModules.dell-latitude-7420

        # Your machine config
        ./hosts/golden-spiral

        # Home Manager as a NixOS module (applies with nixos-rebuild switch)
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;    # use system nixpkgs, not a second copy
          home-manager.useUserPackages = true;  # install user packages into /etc/profiles
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.inertquartet = import ./home/inertquartet;
        }

        # Lanzaboote module — imported now but not yet activated (Phase 3)
        lanzaboote.nixosModules.lanzaboote
      ];
    };
  };
}
