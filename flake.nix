{
  description = "Custom Rofi Applets with Home Manager integration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: {
    homeManagerModules.default = import ./modules/rofi-applets.nix;

    packages = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"] (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      inherit (import ./modules/build-packages.nix {inherit pkgs;}) launcher powermenu networkmanager;
    });
  };
}
