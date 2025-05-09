{userSettings, ...}: {
  imports = [
    ./secrets
    ../common
    ./mod
  ];

  home.username = userSettings.name;
  home.homeDirectory = "/home/" + userSettings.name;
  home.stateVersion = "24.11";

  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    userName = userSettings.name;
    userEmail = userSettings.email;
  };

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
    ".cargo/config.toml".text = ''      [build]
      target-dir = ".cargo/__cache/target"
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.home-manager.enable = true;
}
