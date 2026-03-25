{
  nixpkgs.overlays = [
    (final: prev: {
      jj-spr = prev.callPackage ./packages/jj-spr { };
      nv-tmikus = prev.callPackage ./packages/nv-tmikus { };

      # Fix direnv build: CGO is required for -linkmode=external
      direnv = prev.direnv.overrideAttrs (old: {
        env = (old.env or { }) // { CGO_ENABLED = 1; };
      });

      # Fix for the tmux not opening ZSH: https://github.com/nix-community/home-manager/issues/5952
      tmuxPlugins = prev.tmuxPlugins // {
        sensible = prev.tmuxPlugins.sensible.overrideAttrs (prev: {
          postInstall =
            prev.postInstall
            + ''
              sed -e 's:\$SHELL:/bin/zsh:g' -i $target/sensible.tmux
            '';
        });
      };
    })
  ];
}
