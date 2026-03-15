{
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    beeVim.url = "git+https://codeberg.org/brustybee/beeVim";
    # beeVim.url = "git+file:/home/bee/beeVim";
    beeVim.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mydwm = {
      url = "git+https://codeberg.org/brustybee/mydwm";
      # url = "git+file:/home/bee/mydwm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.platforms.all;
      imports = [ (inputs.nixpkgs.lib.modules.importApply ./common inputs) ];

      flake =
        let
          inherit (inputs) nixpkgs home-manager;

          builders = import ./lib/mkFlakeOutputs.nix { inherit nixpkgs home-manager inputs; };
          inherit (builders) mkSystemWithHM mkSystemWithHMasModule mkSystem;

          merge = builtins.foldl' nixpkgs.lib.recursiveUpdate { };
        in
        merge [
          (mkSystemWithHM {
            user = "bee";
            hostname = "nixios";
            system = "x86_64-linux";
            systemState = "25.11";
          })
        ];
    };
}
