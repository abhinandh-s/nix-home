{ pkgs, ... }:{
  home.packages = with pkgs; [
    anki-bin
    rnote
    evince
    fzf
    lazygit
    firefox-bin
    zoxide
    lua-language-server
  ];
}
