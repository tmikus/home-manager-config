{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Tomasz Mikus";
        email = "mikus.tomasz@gmail.com";
      };
      alias = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };
      # extraConfig = {
      # Delta config
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
    # };
  };
}
