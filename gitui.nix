{ pkgs, ... }:

{
  programs.gitui = {
    enable = false;
    keyConfig = builtins.readFile (
      pkgs.fetchFromGitHub {
        owner = "gitui-org";
        repo = "gitui";
        rev = "69fd7e664c15297253a51f9bf4375f31fba37c0c"; # main branch on 2025-05-27
        sha256 = "sha256-A1FD4zeGyTq+2Q1q0uCBBgLqYhV4BwUsYSJWGhrqe8c=";
      } + "/vim_style_key_config.ron"
    );
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
