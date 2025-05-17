{config, ...}: let
  # conf = builtins.readFile config.sops.templates."cargo-credentials.toml".path;
in {
  sops.templates."cargo-credentials.toml".content = ''
    [registry]
    token = "${config.sops.placeholder."abhi-cargo-token"}";
  '';
   # home.file = {
   #   ".cargo/cred.toml".source = conf;
   # };
}
