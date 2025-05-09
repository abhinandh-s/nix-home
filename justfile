switch-abhi:
  home-manager switch --flake .#abhi

switch-elliot:
  home-manager switch --flake .#elliot

dev:
  nix develop

install-home-manager:
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  nix-shell '<home-manager>' -A install

