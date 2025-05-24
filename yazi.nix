{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."yazi/theme.toml" = {
    source = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "flavors";
      rev = "02f3fc64b78223c1005672e105f6d0e97c0db79e"; # main branch on 2025-05-24
      sha256 = "sha256-7facwGT4DoaMwdkBrMzPlqDbrbSjwW57qRD34iP48+0=";
    } + "/catppuccin-mocha.yazi/flavor.toml";
  };
}
