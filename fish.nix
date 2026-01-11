{ lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellInit = ''
      # Source nix daemon for PATH setup
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
        source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
      end

      # If nix-daemon command does not exist, then prompt the user to run the ./restore-nix.sh script
      if not command -v nix-daemon > /dev/null
        set RED '\033[0;31m'
        set NC '\033[0m'
        echo -e "$RED""ERROR: Nix and Home Manager command not found.""$NC"
        echo "    Looks like the latest version of MacOS has changed the /etc/zshrc file."
        echo "    Please run the following script to restore Nix and Home Manager."
        echo ""
        echo "    sudo ~/.config/home-manager/restore-nix.sh"
        echo ""
      end
    '';

    loginShellInit = ''
      # Add toolbox to PATH
      set -gx GOPATH "$HOME/go"
      fish_add_path -g "$HOME/.toolbox/bin"
      fish_add_path -g "$HOME/.cargo/bin"
      fish_add_path -g "$HOME/.local/bin"
      fish_add_path -g "$HOME/.jetbrains"
      fish_add_path -g "/usr/local/bin"
      fish_add_path -g "$GOPATH/bin"
      fish_add_path -g "$HOME/Library/Android/sdk/platform-tools"

      # Set PATH, MANPATH, etc., for Homebrew.
      if test -f /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
      end
    '';

    interactiveShellInit = ''
      set -g fish_greeting

      # Only set theme if not already set to ayu
      if test "$__fish_theme" != "ayu"
        fish_config theme choose ayu
        set -U __fish_theme ayu
      end

      # Add mechanic to the environment
      if test -f "$HOME/.local/share/mechanic/complete.fish"
        source "$HOME/.local/share/mechanic/complete.fish"
      end

      # Use mise shims for faster startup
      fish_add_path -g "$HOME/.local/share/mise/shims"
      if test -f "$HOME/.local/share/mise/completions.fish"
        source "$HOME/.local/share/mise/completions.fish"
      end

      if command -v direnv > /dev/null
        direnv hook fish | source
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

    shellAliases = lib.mkMerge [
      {
        bb = "brazil-build $argv";
        bbb = "brazil-recursive-cmd --allPackages brazil-build $argv";
        bws = "brazil workspace $argv";
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
  };
}
