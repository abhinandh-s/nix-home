{ config, pkgs, inputs, ... }:
let
  fonts = inputs.nix-fonts.packages;
in {

  imports = [
    ./secrets
  ];

  home.username = "abhi";
  home.homeDirectory = "/home/abhi";
  home.stateVersion = "24.11"; 

  home.packages = with pkgs; [
    neovim
    lua-language-server
    nixd
    # nerd-fonts.FiraCode
    # nerd-fonts.FiraMono
    # nerd-fonts.JetBrainsMono
    # nerd-fonts.NerdFontsSymbolsOnly

    (pkgs.writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
      '')
  ] ++ (with pkgs; [
      firefox-bin
      zoxide
    ]);

  fonts.fontconfig.enable = true;


  programs.git = {
    enable = true;
    userName = "abhi";
    userEmail = "ugabhi@proton.me";
    };

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
    ".cargo/config.toml".text = ''[build]
target-dir = "~/.cargo/__cache/target"
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.home-manager.enable = true;
}
