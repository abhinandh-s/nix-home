{ pkgs, lib, config, ... }:{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;

    policies = lib.mkMerge [
      (import ./policies.nix { inherit config pkgs lib; })
      (import ./extensions.nix { inherit config pkgs lib; })
      { }
    ];

    profiles = {
      abhi = {
        id = 0;
        name = "abhi";
        isDefault = true;
        search = import ./search.nix;
      };
    };
  };
}
