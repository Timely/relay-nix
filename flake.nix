{
  description = "Webhook Relay daemon";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.callPackage ./default.nix {
          inherit (pkgs) lib buildGoModule fetchFromGitHub;
        };

        # Optionally add a development shell
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            go
            self.packages.${system}.default
          ];
        };
      }
    );
}
