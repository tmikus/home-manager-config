{
  nixpkgs.overlays = [
    (final: prev:
      {
        nv-tmikus = prev.callPackage ./packages/nv-tmikus { };

        # Fix for the tmux not opening ZSH: https://github.com/nix-community/home-manager/issues/5952
        tmuxPlugins = prev.tmuxPlugins // {
            sensible = prev.tmuxPlugins.sensible.overrideAttrs (prev: {
                postInstall = prev.postInstall + ''
                sed -e 's:\$SHELL:/bin/zsh:g' -i $target/sensible.tmux
                '';
            });
        };
    })
  ];
}
