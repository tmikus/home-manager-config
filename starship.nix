{
  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;
      format = builtins.concatStringsSep "" [
        "$username"
        "$hostname"
        "$directory"
        "\${custom.git_conditional}"
        "\${custom.jj}"
        "$line_break"
        "$jobs"
        "$battery"
        "$time"
        "$status"
        "$os"
        "$container"
        "$netns"
        "$shell"
        "$character"
      ];

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

      custom = {
        git_conditional = {
          command = "starship module git_branch; starship module git_status";
          # when = "test ! -d .jj"; # Only show if .jj folder doesn't exist
          when = "[ ! -d .jj ]";
          format = "$output";
        };
        jj = {
          command = "prompt";
          format = "$output";
          ignore_timeout = true;
          shell = ["starship-jj" "--ignore-working-copy" "starship"];
          use_stdin = false;
          when = true;
        };
      };
    };
  };
}
