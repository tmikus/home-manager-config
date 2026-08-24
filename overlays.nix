{
  nixpkgs.overlays = [
    (final: prev: {
      jj-spr = prev.callPackage ./packages/jj-spr { };
      nv-tmikus = prev.callPackage ./packages/nv-tmikus { };

      # TEMPORARY: the nixpkgs-unstable channel's mise (2026.7.10) was never built
      # by Hydra for aarch64-darwin, so it compiles from source. Pin mise to a
      # newer nixpkgs rev whose build is in cache.nixos.org. Remove this once the
      # channel advances past mise 2026.7.17 (check: mise disappears from the
      # "will be built" list on home-manager switch).
      mise =
        (import (builtins.fetchTarball {
          url = "https://github.com/NixOS/nixpkgs/archive/cb73bff643b27b72994ddda0f98cb1cc6ed58c9c.tar.gz";
          sha256 = "118vvzsqnv730hz26alhji5wmvd66qscdakgss1m08d6ykiwmi6b";
        }) { system = prev.stdenv.hostPlatform.system; }).mise;

      # TEMPORARY: tmux 3.7's configure aborts on macOS unless it is told
      # explicitly whether to use jemalloc, and nixpkgs' tmux 3.7c passes neither
      # flag, so the darwin build fails outright (which is also why it is missing
      # from cache.nixos.org). Upstream recommends jemalloc on macOS because the
      # system calloc(3) does not reliably zero allocations. Remove once nixpkgs
      # fixes the derivation.
      tmux = prev.tmux.overrideAttrs (
        old:
        prev.lib.optionalAttrs prev.stdenv.hostPlatform.isDarwin {
          buildInputs = old.buildInputs ++ [ prev.jemalloc ];
          configureFlags = old.configureFlags ++ [ "--enable-jemalloc" ];
        }
      );

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
