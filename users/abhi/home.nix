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

  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    userName = userSettings.name;
    userEmail = userSettings.email;
    signing = {
      signByDefault = true;
      key = "FFF41332AF327F6B01C58C1EC773B58665274E3E";
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
    mutableKeys = true; # allows you to import/export keys manually
    mutableTrust = true; # allows setting trust interactively
    settings = {
      use-agent = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentry = {
      package = pkgs.pinentry-curses; # or `pinentry-tty` if you're super minimal
    };
    enableSshSupport = false; # or true if you want to use GPG for SSH
    extraConfig = ''
      allow-loopback-pinentry
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
    # CARGO_REGISTRY_TOKEN = "${config.sops.secrets.cargo-token}";
  };
  programs.home-manager.enable = true;
}
