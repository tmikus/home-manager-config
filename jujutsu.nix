{
  programs.jujutsu = {
    enable = true;
    settings = {
      aliases = {
        spr = ["util" "exec" "--" "jj-spr"];
      };
      user = {
        name = "Tomasz Mikus";
        email = "tomasz@mikus.uk";
      };
      spr = {
        branchPrefix = "tmikus-";
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
