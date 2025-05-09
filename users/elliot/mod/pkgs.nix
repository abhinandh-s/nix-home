{
  pkgs,
  performFullSetup,
  ...
}: {
  home.packages = with pkgs; [
    alacritty
    xsel # for clipboard
    xclip
    pinentry-all
    vim
    tmux
    just
  ];

  # this is a custom option declared in lib/optional.nix
  #
  # ```nix
  # home.optional.packages {
  #   enable = bool;
  #   packages = [ list of pkgs ];
  # }
  # ```
  home.optional.packages = {
    enable = performFullSetup;
    packages = with pkgs; [
      rnote
      evince
      neovim
      fzf
      lazygit
      xdotool
      firefox-bin
      zoxide
      lua-language-server
      nixd
      anki-bin
      alejandra
      telegram-desktop
      tree
      (writeShellScriptBin "ff"
        /*
        bash
        */
        ''
          ${fzf}/bin/fzf -e --cycle --walker-skip=.git,.direnv | xargs -r nvim
        '')
    ];
  };
}
