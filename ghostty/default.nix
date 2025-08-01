{ pkgs, ... }:

{
  xdg.configFile."ghostty/config" = {
    source = if pkgs.stdenv.hostPlatform.isLinux
      then ./src/config_linux
      else ./src/config;
  };
}
