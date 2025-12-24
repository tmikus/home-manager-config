{ lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "zsh-autocomplete";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "25.03.19";
          sha256 = "eb5a5WMQi8arZRZDt4aX1IV+ik6Iee3OxNMCiMnjIx4=";
        };
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.1";
          sha256 = "vpTyYq9ZgfgdDsWzjxVAE7FZH4MALMNZIFyEOBLm5Qo=";
        };
      }
    ];
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        # If nix-daemon command does not exist, then prompt the user to run the ./restore-nix.sh script
        if ! command -v nix-daemon &> /dev/null
        then
            RED='\033[0;31m'
            NC='\033[0m' # No Color
            echo "''${RED}ERROR: Nix and Home Manager command not found.''${NC}"
            echo "    Looks like the latest version of MacOS has changed the /etc/zshrc file."
            echo "    Please run the following script to restore Nix and Home Manager."
            echo ""
            echo "    sudo ~/.config/home-manager/restore-nix.sh"
            echo ""
        fi

        autoload -Uz compinit
        compinit
      '')
      (lib.mkAfter ''
        # Add mechanic to the environment
        [ -f "$HOME/.local/share/mechanic/complete.zsh" ] && source "$HOME/.local/share/mechanic/complete.zsh"

        if command -v mise &> /dev/null
        then
            eval "$(mise activate zsh)"
        fi
        [ -f "$HOME/.local/share/mise/completions.zsh" ] && source "$HOME/.local/share/mise/completions.zsh"

        if command -v direnv &> /dev/null
        then
            eval "$(direnv hook zsh)"
        fi

        # Remove OhMyZsh alias that is used by Git Kraken
        unalias gk

        # Add Ghostty integration
        if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
            source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
        fi

        # Import optional config
        if [[ -f "$HOME/.local-zshrc" ]]; then
            source "$HOME/.local-zshrc"
        fi
      '')
    ];
    profileExtra = ''
      # Add toolbox to PATH
      export GOPATH="${builtins.getEnv "HOME"}/go"
      export PATH="$PATH:${builtins.getEnv "HOME"}/.toolbox/bin:${builtins.getEnv "HOME"}/.cargo/bin:${builtins.getEnv "HOME"}/.local/bin:${builtins.getEnv "HOME"}/.jetbrains:/usr/local/bin/:$GOPATH/bin:/Users/tmikus/Library/Android/sdk/platform-tools"

      # Add the Chromium build tools
      export PATH="$PATH:/Users/tmikus/projects/depot_tools"

      # Set PATH, MANPATH, etc., for Homebrew.
      [ -f "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
    shellAliases = lib.mkMerge [
      {
        bb = "brazil-build $@";
        bbb = "brazil-recursive-cmd --allPackages brazil-build $@";
        bws = "brazil workspace $@";
        bws_reset = "brazil-recursive-cmd --allPackages \"git checkout mainline && git reset --hard origin/mainline\"";
        cat = "bat";
        ls = "eza";
        ll = "ls -l";
        l = "ls -l";
        la = "ls -a";
        reset_nvim = "rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.config/nvim ~/.cache/nvim";
        update_home_manager = "nix-channel --update && home-manager switch";
      }
      (
        if pkgs.stdenv.hostPlatform.isDarwin then
          {
            morning = "ssh-add -D && mwinit -f && ssh-add --apple-use-keychain ~/.ssh/id_ecdsa";
            update_db = "sudo /usr/libexec/locate.updatedb";
          }
        else
          {
            morning = "mwinit -o";
            update_db = "sudo updatedb";
          }
      )
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "npm"
        "history"
        "jj"
        "node"
        "rust"
      ];
      theme = "robbyrussell";
    };
  };
}
