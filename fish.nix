{
    programs.fish = {
        enable = true;
        shellInit = ''
            # Source nix daemon for PATH setup
            if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
                source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
            end
        '';
        shellAliases = {
            bb = "brazil-build $@";
            bbb = "brazil-recursive-cmd --allPackages brazil-build $@";
            bws = "brazil workspace $@";
            bws_reset = "brazil-recursive-cmd --allPackages \"git checkout mainline && git reset --hard origin/mainline\"";
            cat = "bat";
            ls = "eza";
            ll = "ls -l";
            l = "ls -l";
            la = "ls -a";
            reset_nvim = "rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.config/nvim ~/.cache/nvim";
            update_home_manager = "nix-channel --update && home-manager switch";
        };
    };
}
