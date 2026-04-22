{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Browsers
    firefox

    # Productivity
    libreoffice-fresh

    # System tools
    btop
    ripgrep
    fd
    bat       # better cat
    eza       # better ls

    # Logitech Software

    fastfetch

    # Photo workflow (activate when ready)
    # darktable
    # rawtherapee
    # gphoto2        # camera import
    # rapid-photo-downloader  # import + rename workflow
  ];

  # VS Code with declarative extension list (optional)
  # programs.vscode = {
  #   enable = true;
  #   extensions = with pkgs.vscode-extensions; [ ... ];
  # };
}
