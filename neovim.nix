{ pkgs, ... }:

{
  # Neovim
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.enable
  programs.neovim.enable = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;

  xdg.configFile."nvim" = {
    recursive = true;
    source = "${pkgs.nv-tmikus}";
  };
}
