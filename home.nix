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
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.home-manager.enable = true;
}
