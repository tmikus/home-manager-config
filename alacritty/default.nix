{ config, ... }:

{
  home.file.".alacritty.toml" = { source = ./alacritty.toml; };
}
