{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    # Declares flake.homeModules / flake.homeConfigurations.
    # inputs.home-manager.flakeModules.home-manager
  ];

  systems = [ "x86_64-linux" ];

  # flake-parts looks for `nixpkgs` among the flake's own declared inputs,
  # and there are none (tack resolves them), so provide pkgs explicitly.
  perSystem = { system, ... }: {
    _module.args.pkgs = inputs.nixpkgs.legacyPackages.${system};
  };
}
