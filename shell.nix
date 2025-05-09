{pkgs ? import <nixpkgs> {}}:
with pkgs;
  mkShell {
    buildInputs = [
      git
      just
      neovim
      tmux
    ];

    GREETING = "Environment is ready!";

    shellHook = ''
      echo $GREETING | ${pkgs.lolcat}/bin/lolcat
    '';
  }
