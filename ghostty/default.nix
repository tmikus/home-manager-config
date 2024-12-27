{ config, ... }:

{
  xdg.configFile."ghostty" = {
    recursive = true;
    source = ./src;
  };
}
