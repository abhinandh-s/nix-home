{
  userSettings,
  config,
  ...
}: 
{
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
