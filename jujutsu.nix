{
  programs.jujutsu = {
    enable = true;
    settings = {
      aliases = {
        l = ["log" "--no-pager" "--limit" "10"];
        ll = ["log" "--limit" "30"];
        la = ["log" "-r" "all()"];
        s = ["status"];
        d = ["diff"];
        ds = ["diff" "--stat"];
        spr = ["util" "exec" "--" "jj-spr"];
        land = ["util" "exec" "--" "sh" "-c" "jj spr land -r @- && jj git fetch && jj rebase -r @ -d main@origin"];
        el = ["evolog" "--no-pager" "--limit" "10"];
      };
      user = {
        name = "Tomasz Mikus";
        email = "tomasz@mikus.uk";
      };
      spr = {
        branchPrefix = "tmikus-";
      };
      remotes.origin = {
        auto-track-bookmarks = "glob:*";
      };
      templates = {
        git_push_bookmark = ''"push-" ++ change_id.short()'';
      };
      snapshot = {
        max-new-file-size = "10MiB";
      };
      ui = {
        default-command = "l";
        editor = "nvim";
        paginate = "auto";
        pager = "delta";
        diff-formatter = ":git";
        delta = {
          navigate = true;
        };
      };
      merge-tools = {
        nvim = {
          program = "nvim";
          merge-args = ["-d" "$left" "$base" "$right" "$output" "-c" "wincmd J"];
        };
      };
      revset-aliases = {
        "trunk()" = "main@origin";
        "mine()" = ''author(exact:"tomasz@mikus.uk")'';
        "wip()" = ''description(exact:"") & mine()'';
        "stack()" = "ancestors(@, 10) & mine()";
      };
      revsets = {
        # Show all revisions in log by default (no elided revisions)
        log = "::";
      };
    };
  };
}
