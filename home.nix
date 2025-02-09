{ pkgs, ... }:

{
  imports = [
    ./configuration.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.manage
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  # targets.genericLinux.enable = true; # ENABLE THIS ON NON-NIXOS

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages =
    with pkgs;
    (
      if pkgs.stdenv.hostPlatform.isDarwin then
        [ ]
      else
        with pkgs;
        [
          clang
          gnumake
          plocate
        ]
    );
}
