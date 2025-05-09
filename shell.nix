{pkgs ? import <nixpkgs> {}}:
with pkgs;
  mkShell {
    buildInputs = [
      git
      home-manager
      just
      neovim
      tmux
    ];

    GREETING = "Environment is ready!";

    shellHook = ''
      echo $GREETING | ${pkgs.lolcat}/bin/lolcat
    '';
  }
