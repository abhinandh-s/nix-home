{
  description = "Home Manager configuration of abhi";

  inputs = {
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
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    sops-nix,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
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
            email = "ugabhi@proton.me";
          };
        };
      };
    };
    devShells.${system}.default = import ./shell.nix {inherit pkgs;};
  };
}
