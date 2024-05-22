{ config, ... }:

{
  xdg.configFile."alacritty" = {
    recursive = true;
    source = ./src;
  };
}
