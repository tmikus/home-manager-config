{ pkgs, ... }:

{
  # Neovim
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.enable
  programs.neovim.enable = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;
  # All plugins are Lua; no remote plugins need the Ruby/Python providers
  programs.neovim.withRuby = false;
  programs.neovim.withPython3 = false;

  xdg.configFile."nvim" = {
    recursive = true;
    source = "${pkgs.nv-tmikus}";
  };
}
