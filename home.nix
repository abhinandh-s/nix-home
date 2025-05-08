{ config, pkgs, inputs, performFullSetup, ... }:
let
  fonts = inputs.nix-fonts.packages;
in {

  imports = [
    ./secrets
  ] ++ (if performFullSetup then [
      ./mod
    ] else []);

  home.username = "abhi";
  home.homeDirectory = "/home/abhi";
  home.stateVersion = "24.11"; 

  home.packages = with pkgs; [
    xsel # for clipboard
    xclip
    xdotool
    pinentry-all
    neovim
    just
    nixd
    (pkgs.writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
      '')
  ];

  fonts.fontconfig.enable = true;


  programs.git = {
    enable = true;
    userName = "abhi";
    userEmail = "ugabhi@proton.me";
  };

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
    ".cargo/config.toml".text = ''[build]
target-dir = ".cargo/__cache/target"
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.home-manager.enable = true;
}
