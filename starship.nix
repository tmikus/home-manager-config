{
  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;

      # Shows the username
      username = {
        style_user = "white bold";
        style_root = "black bold";
        format = "[$user]($style) ";
        disabled = false;
        show_always = false;
      };

      # Shows current directory
      directory = {
        truncation_symbol = "…/";
        home_symbol = "󰋜 ~";
        read_only_style = "197";
        read_only = "  ";
        format = "at [$path]($style)[$read_only]($read_only_style) ";
      };

      # Shows current git branch
      git_branch = {
        symbol = " ";
        format = "via [$symbol$branch]($style)";
        truncation_symbol = "…/";
        style = "bold green";
      };

      # Shows current git status
      git_status = {
        format = "([ \( $all_status$ahead_behind\)]($style) )";
        style = "bold green";
        conflicted = "[ confliced=$count](red) ";
        up_to_date = "[󰘽 up-to-date](green) ";
        untracked = "[󰋗 untracked=$count](red) ";
        ahead = " ahead=$count";
        diverged = " ahead=$ahead_count  behind=$behind_count";
        behind = " behind=$count";
        stashed = "[ stashed=$count](green) ";
        modified = "[󰛿 modified=$count](yellow) ";
        staged = "[󰐗 staged=$count](green) ";
        renamed = "[󱍸 renamed=$count](yellow) ";
        deleted = "[󰍶 deleted=$count](red) ";
      };

      # Shows kubernetes context and namespace
      kubernetes = {
        format = "via [󱃾 $context\($namespace\)](bold purple) ";
        disabled = true;
      };
    };
  };

}
