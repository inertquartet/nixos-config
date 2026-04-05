{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Chad";
      user.email = "chad.mcauley@tutamail.com";
      init.defaultBranch = "main";
      pull.rebase = true;
      core.editor = "vim";
    };
};

  # delta for better diffs — declarative install + config in one block
  programs.delta = {
    enable = true;
    options = {
      navigate = true;
      line-numbers = true;
      side-by-side = true;
      gitconfig-integration = true;
    };
  };
}
