{ config, pkgs, ... }:

{
  imports = [
    ./overlays.nix
    ./neovim
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  # targets.genericLinux.enable = true; # ENABLE THIS ON NON-NIXOS

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    clang
    go
    nodejs_20
    python312
    rustc
    rustfmt
    starship
    thefuck
    tree-sitter
    unzip
    zig
    xclip
    wget
  ];

  programs.git = {
    enable = true;
    userName = "Tomasz Mikus";
    userEmail = "mikus.tomasz@gmail.com";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
    };
  };

  programs.java = {
    enable = true;
    package = pkgs.openjdk21;
  };

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
        disabled = false;
      };
    };
  };

  
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
	      # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
        };
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "npm"
        "history"
        "node"
        "rust"
        "thefuck"
      ];
      theme = "robbyrussell";
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tmikus/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };
}
