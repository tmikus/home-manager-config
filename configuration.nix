{
  lib,
  pkgs,
  ...
}:

{
  nixpkgs.config = {
    # Allow unfree packages
    allowUnfree = true;
  };

  imports = [
    ./alacritty
    ./fish.nix
    ./direnv.nix
    ./fzf.nix
    ./ghostty
    ./git.nix
    ./gitui.nix
    ./intellij
    ./java.nix
    ./jujutsu.nix
    ./mise.nix
    ./neovim.nix
    ./overlays.nix
    ./starship.nix
    ./tmux.nix
    ./yazi.nix
    ./wezterm
    ./zed
    ./zellij
    ./zoxide.nix
    ./zsh.nix
  ];

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
    bacon
    bat
    bun
    ccache
    delta
    deno
    dua
    eza
    fd
    fzf
    gnutar
    go
    jj-spr
    jq
    k9s
    kubectl
    lua-language-server
    mise
    nil
    nixd
    nixfmt
    ripgrep
    rustup
    starship
    tree-sitter
    unzip
    uutils-coreutils-noprefix
    xan
    xh
    wget
    zellij
    zig
  ] ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
    xclip # Clipboard provider for neovim
  ];

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

  xdg.configFile."autostart/jetbrains-toolbox.desktop" = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    source = "${pkgs.jetbrains-toolbox}/share/applications/jetbrains-toolbox.desktop";
  };
  xdg.configFile."autostart/podman-desktop.desktop" = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    source = "${pkgs.podman-desktop}/share/applications/podman-desktop.desktop";
  };
  xdg.configFile."autostart/spotify.desktop" = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    source = "${pkgs.spotify}/share/applications/spotify.desktop";
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
  home.sessionPath = [
    "$HOME/.toolbox/bin"
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
    "$HOME/.jetbrains"
    "/usr/local/bin"
    "$HOME/go/bin"
    "$HOME/Library/Android/sdk/platform-tools"
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PAGER = "less";
    GOPATH = "$HOME/go";
    GOPROXY = "direct";
  };

  home.shellAliases = {
    # Amazon-related aliases
    bb = "brazil-build";
    bbb = "brazil-recursive-cmd --allPackages brazil-build";
    bws = "brazil workspace";
    bws_reset = "brazil-recursive-cmd --allPackages \"git checkout mainline && git reset --hard origin/mainline\"";
    
    # Generic aliases
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

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };
}
