{ ... }:

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

  };
}
