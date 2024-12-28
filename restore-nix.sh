# Script used to repair the nix configuration after a macos update
echo "# Nix" >> /etc/zshrc
echo "if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then" >> /etc/zshrc
echo "  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'" >> /etc/zshrc
echo "fi" >> /etc/zshrc
echo "# End Nix" >> /etc/zshrc
