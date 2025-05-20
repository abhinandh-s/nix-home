{
  description = "Home Manager configuration of abhi";

  inputs = {
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-fonts = {
      url = "github:abhinandh-s/nix-fonts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    unstable-nixpkgs,
    home-manager,
    sops-nix,
    rust-overlay,
    ...
  }: let
    randomNumber = builtins.readFile ./random.txt; # to keep home-manager.backupFileExtension happy
    system = "x86_64-linux";
    # pkgs = nixpkgs.legacyPackages.${system};
    overlays = [
      (import rust-overlay)
      (final: prev: {
        unstable = import unstable-nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      })
    ];
    pkgs = import nixpkgs {
      inherit system overlays;
    };
  in {
    homeConfigurations = {
      abhi = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./users/abhi/home.nix
          sops-nix.homeManagerModules.sops
        ];

        extraSpecialArgs = {
          performFullSetup = true;
          inherit inputs;
          userSettings = {
            name = "abhi";
            email = {
              personal = "abhinandhsuby@proton.me";
              dev = "ugabhi@proton.me";
            };
          };
        };
      };
      elliot = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./users/elliot/home.nix
          sops-nix.homeManagerModules.sops
        ];

        extraSpecialArgs = {
          performFullSetup = false;
          inherit inputs;
          userSettings = {
            name = "elliot";
            email = "ugabhi@proton.me";
          };
        };
      };
    };
    devShells.${system}.default = import ./shell.nix {inherit pkgs;};
  };
}
