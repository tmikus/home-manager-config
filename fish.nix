{ lib, pkgs, ... }:

{
  # Use home-manager's built-in direnv integration
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Declarative environment variables
  home.sessionVariables = {
    GOPATH = "$HOME/go";
  };

  # Declarative PATH management
  home.sessionPath = [
    "$HOME/.toolbox/bin"
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
    "$HOME/.jetbrains"
    "/usr/local/bin"
    "$HOME/go/bin"
    "$HOME/Library/Android/sdk/platform-tools"
    "$HOME/.local/share/mise/shims"
  ];

  programs.fish = {
    enable = true;

    shellInit = ''
      # Source nix daemon for PATH setup
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
        source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
      end

      # If nix-daemon command does not exist, then prompt the user to run the ./restore-nix.sh script
      if not command -v nix-daemon > /dev/null
        set_color red
        echo "ERROR: Nix and Home Manager command not found."
        set_color normal
        echo "    Looks like the latest version of MacOS has changed the /etc/zshrc file."
        echo "    Please run the following script to restore Nix and Home Manager."
        echo ""
        echo "    sudo ~/.config/home-manager/restore-nix.sh"
        echo ""
      end
    '';

    loginShellInit = ''
      # Set PATH, MANPATH, etc., for Homebrew.
      if test -f /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
      end
    '';

    interactiveShellInit = ''
      # Only set theme if not already set to ayu
      if test "$__fish_theme" != "ayu"
        fish_config theme choose ayu
        set -U __fish_theme ayu
      end

      # Add mechanic to the environment
      if test -f "$HOME/.local/share/mechanic/complete.fish"
        source "$HOME/.local/share/mechanic/complete.fish"
      end

      # Load mise completions
      if test -f "$HOME/.local/share/mise/completions.fish"
        source "$HOME/.local/share/mise/completions.fish"
      end

      # Add Ghostty integration
      if set -q GHOSTTY_RESOURCES_DIR
        source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
      end

      # Import optional config
      if test -f "$HOME/.local-fishrc"
        source "$HOME/.local-fishrc"
      end
    '';

    # Use functions for commands that need arguments
    functions = {
      # Disable greeting
      fish_greeting = "";
      # Brazil build helpers that support arguments
      bbb = "brazil-recursive-cmd --allPackages brazil-build $argv";
      bws_reset = ''brazil-recursive-cmd --allPackages "git checkout mainline && git reset --hard origin/mainline"'';
    };

    # Use abbreviations for common commands (expand inline, visible in history)
    shellAbbrs = {
      bb = "brazil-build";
      bws = "brazil workspace";
      g = "git";
      gc = "git commit";
      gp = "git push";
      gl = "git log";
      gs = "git status";
      hm = "home-manager";
    };

    # Simple aliases for command substitutions
    shellAliases = {
      cat = "bat";
      ls = "eza";
      ll = "eza -l";
      l = "eza -l";
      la = "eza -a";
      lla = "eza -la";
      reset_nvim = "rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.config/nvim ~/.cache/nvim";
      update_home_manager = "nix-channel --update && home-manager switch";
    } // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
      morning = "ssh-add -D && mwinit -f && ssh-add --apple-use-keychain ~/.ssh/id_ecdsa";
      update_db = "sudo /usr/libexec/locate.updatedb";
    } // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
      morning = "mwinit -o";
      update_db = "sudo updatedb";
    };
  };
}
