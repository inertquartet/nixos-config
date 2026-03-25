{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Chad";
    userEmail = "chad.mcauley@tutamail.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      core.editor = "vim";
    };

    # delta for better diffs — declarative install + config in one block
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        side-by-side = true;
      };
    };
  };
}
