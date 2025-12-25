{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Tomasz Mikus";
        email = "tomasz@mikus.uk";
      };
      aliases = {
        spr = ["util" "exec" "--" "jj-spr"];
      };
      ui = {
        default-command = "log";
        editor = "nvim";
        # Enable pagination for commands that support it (default)
        paginate = "auto";

        # delta
        pager = "delta";
        diff-formatter = ":git";
        delta = {
          navigate = true;
        };
      };
    };
  };
}
