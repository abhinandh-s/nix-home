switch-abhi:
  shuf -i 100-99999999 -n 1 > random.txt
  home-manager switch --flake .#abhi

switch ext:
  home-manager switch --flake .#abhi -b {{ext}}

switch-elliot:
  @shuf -i 100-99999999 -n 1 > random.txt
  home-manager switch --flake .#elliot

dev:
  nix develop

install-home-manager:
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  nix-shell '<home-manager>' -A install

