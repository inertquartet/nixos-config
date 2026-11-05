{ pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    # Browsers
    firefox

    # Productivity
    libreoffice

    # System tools
    btop
    ripgrep
    fd
    bat       # better cat
    eza       # better ls
    fastfetch

    texstudio
    texliveMedium
	
    # fonts
    cascadia-code
    nerd-fonts.hack
    nerd-fonts.caskaydia-cove
    nerd-fonts.noto
    inter
       

    # Photo workflow (activate when ready)
    # darktable
    # rawtherapee
    # gphoto2        # camera import
    # rapid-photo-downloader  # import + rename workflow
  ];

  fonts.fontconfig.enable = true;

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  # Spicetify / Spotify configuration
  programs.spicetify = {
    enable = true;

    theme = spicePkgs.themes.catppuccin;
    colorScheme = "macchiato";

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
      adblock
    ];

    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      lyricsPlus
    ];
  };

  # VS Code with declarative extension list (optional)
  # programs.vscode = {
  #   enable = true;
  #   extensions = with pkgs.vscode-extensions; [ ... ];
  # };
}
