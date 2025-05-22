{
  userSettings,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./secrets
    ./lib
    ./mod
    ./dev.nix
  ];

  home.username = userSettings.name;
  home.homeDirectory = "/home/" + userSettings.name;
  home.stateVersion = "24.11";

  programs.bash = {
    enable = true;
    bashrcExtra = /*bash*/''
      . ~/.nix-profile/etc/profile.d/nix.sh
      export GPG_TTY=$(tty)
      export CARGOT=$(cat ${config.sops.secrets."abhi-cargo-token".path});
      eval "$(zoxide init bash)"
      # Add /usr/local/mytools/bin to PATH if not already present
      if [[ ":$PATH:" != *":/home/abhi/.cargo/bin:"* ]]; then
        export PATH="/home/abhi/.cargo/bin:$PATH"
      fi
    '';
    # promptInit = ''
    #   # Provide a nice prompt if the terminal supports it.
    #   if [ "$TERM" != "dumb" ] || [ -n "$INSIDE_EMACS" ]; then
    #     PROMPT_COLOR="1;31m"
    #     ((UID)) &amp;&amp; PROMPT_COLOR="1;32m"
    #     if [ -n "$INSIDE_EMACS" ]; then
    #       # Emacs term mode doesn't support xterm title escape sequence (\e]0;)
    #       PS1="\n\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] "
    #     else
    #       PS1="\n\[\033[$PROMPT_COLOR\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] "
    #     fi
    #     if test "$TERM" = "xterm"; then
    #       PS1="\[\033]2;\h:\u:\w\007\]$PS1"
    #     fi
    #   fi
    # '';
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "\${xdg.configHome}/emacs/bin"
    ".cargo/bin"
  ];

  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    userName = userSettings.name;
    userEmail = userSettings.email.personal;
    signing = {
      signByDefault = true;
      key = "55BBE35CA185AD09";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
    aliases = {
      c = "commit -m 'Refactoring'";
      cm = "commit -m";
      ga = "git add";
      gp = "git push";
      gs = "git status";
      gaa = "git add *";
      gcm = "git commit -m";
    };
    ignores = [
      "*~"
      "*.swp"
      "debug/"
      "target/"
      "**/*.rs.bk"
      "*.pdb"
      "*.aux"
      "*.dvi"
      "*.fdb_latexmk"
      "*.fls"
      "*.log"
      "*.synctex"
      "*.lot"
      "*.toc"
      "*.out"
      "*.synctex.gz"
      "#*.org#"
      ".#*"
      "ltximg/"
      "ltximg/*"
    ];
  };

  programs.gpg = {
    enable = true;
    # mutableKeys = true; # allows you to import/export keys manually
    # mutableTrust = true; # allows setting trust interactively
    settings = {
      use-agent = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    #  pinentry = {
    #    package = pkgs.pinentry-curses; # or `pinentry-tty` if you're super minimal
    #  };
    #   defaultCacheTtl = 2592000;
    #   maxCacheTtl = 2592000; # ~ 1 month
    #   enableSshSupport = false; # or true if you want to use GPG for SSH
    extraConfig = ''
      pinentry-program /usr/bin/pinentry-curses
    '';
  };

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
    ".cargo/config.toml".text = ''      [build]
      target-dir = ".cargo/__cache/target"
    '';
  };

  # sops.templates."your-config-with-secrets.toml".content = ''
  #   password = "${config.sops.secrets.cargo-token}"
  # '';

  home.sessionVariables = {
    EDITOR = "nvim";
    GPG_TTY = "$(tty)";
  };
  programs.home-manager.enable = true;
}
