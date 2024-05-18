{ config, lib, pkgs, ... }:

{
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
    initExtraFirst = ''
      autoload -Uz compinit
      compinit
    '';
    initExtra = ''
      # Add mechanic to the environment
      [ -f "$HOME/.local/share/mechanic/complete.zsh" ] && source "$HOME/.local/share/mechanic/complete.zsh"
    '';
    profileExtra = ''
      # Add toolbox to PATH
      export PATH="$PATH:${builtins.getEnv "HOME"}/.toolbox/bin" 

      # Set PATH, MANPATH, etc., for Homebrew.
      [ -f "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
    shellAliases = lib.mkMerge [
      {
        bb="brazil-build $@";
        bbb="brazil-recursive-cmd --allPackages brazil-build $@";
        bws="brazil workspace $@";
        reset_nvim="rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.config/nvim ~/.cache/nvim";
        update_db="sudo /usr/libexec/locate.updatedb";
      }
      (if pkgs.stdenv.hostPlatform.isDarwin then {
        morning="ssh-add -D && mwinit && ssh-add --apple-use-keychain ~/.ssh/id_ecdsa";
      } else {
        morning="mwinit -o";
      })
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
}
