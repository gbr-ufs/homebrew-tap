# SPDX-FileCopyrightText: 2026 Gabriel Santos de Souza <gabriel.santosdesouza@dcomp.ufs.br>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  description = "Homebrew Third-Party Repository.";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/master";
  outputs =
    { nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              cocogitto
              nixd
              reuse
            ];
          };
        }
      );
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);
    };
}
