{
  programs.jujutsu = {
    enable = true;
    settings = {
      aliases = {
        l = ["log" "--no-pager" "--limit" "10"];
        rebase_main = ["rebase" "-r" "@" "-d" "main@origin"];
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
        default-command = "l";
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
      revset-aliases = {
        # Define trunk as main@origin
        "trunk()" = "main@origin";
      };
      revsets = {
        # Show all revisions in log by default (no elided revisions)
        log = "::";
      };
    };
  };
}
