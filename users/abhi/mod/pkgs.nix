{
  pkgs,
  performFullSetup,
...
}: {
  home.packages = with pkgs; [
    alacritty
    xsel # for clipboard
    xclip
    gcc
    neovim    
    vim
    tmux
    just
    sops

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
   #   rnote
    nemo-with-extensions
          unstable.rust-analyzer
    rust-bin.stable.latest.default
     tailwindcss-language-server
      tailwindcss
      #  evince
      emmet-language-server
      neovim
      deno
      fzf
      zathura
      lazygit
     # xdotool
      zoxide
      typst
      lua-language-server
      nixd
     # anki-bin
      alejandra
     # telegram-desktop
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
