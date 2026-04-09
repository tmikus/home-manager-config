{ pkgs, config, ... }:

let
  fishPath = "${config.programs.fish.package}/bin/fish";
in
{
  xdg.configFile."ghostty/config" = {
    text = builtins.replaceStrings
      [ "/Users/$USER/.nix-profile/bin/fish" ]
      [ fishPath ]
      (builtins.readFile (
        if pkgs.stdenv.hostPlatform.isLinux
        then ./src/config_linux
        else ./src/config
      ));
  };
  xdg.configFile."ghostty/themes" = {
    source = ./src/themes;
  };
}
