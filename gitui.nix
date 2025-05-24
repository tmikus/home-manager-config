{ pkgs, ... }:

{
  programs.gitui = {
    enable = true;
    theme = builtins.readFile (
      pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "gitui";
        rev = "df2f59f847e047ff119a105afff49238311b2d36"; # main branch on 2025-05-24
        sha256 = "sha256-DRK/j3899qJW4qP1HKzgEtefz/tTJtwPkKtoIzuoTj0=";
      } + "/themes/catppuccin-mocha.ron"
    );
  };
}
