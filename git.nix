{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Tomasz Mikus";
        email = "tomasz@mikus.uk";
      };
      alias = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };
      core = {
        pager = "delta";
      };
      delta = {
        navigate = true;
      };
      diff = {
        colorMoved = "default";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      merge = {
        conflictstyle = "diff3";
      };

      # Other
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
      push = {
        autoSetupRemote = true;
      };
      rebase = {
        autostash = true;
      };
    };
  };
}
