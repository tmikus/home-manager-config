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
  # Mason installs npm-based tools (LSPs, prettier, eslint_d). Node is only put
  # on Neovim's PATH so the shell keeps using the NVM-managed versions.
  programs.neovim.extraPackages = [ pkgs.nodejs ];
  # sqlite.lua (used by neoclip) can't find libsqlite3 outside of FHS/Homebrew paths
  programs.neovim.extraWrapperArgs = [
    "--set"
    "LIBSQLITE"
    "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}"
  ];

  xdg.configFile."nvim" = {
    recursive = true;
    source = "${pkgs.nv-tmikus}";
  };
}
