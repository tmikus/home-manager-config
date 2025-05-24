{ pkgs, ... }:

{
  programs.gitui = {
    enable = true;
    keyConfig = builtins.readFile (
      pkgs.fetchFromGitHub {
        owner = "gitui-org";
        repo = "gitui";
        rev = "master"; # main branch on 2025-05-24
        sha256 = "sha256-ZF3q3QNtYiUM6KXgJboYNs14//BYgtAShzzUlql6V7M=";
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
