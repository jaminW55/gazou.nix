# default.nix
with import <nixpkgs> {};
{
  gazou = pkgs.callPackage ./gazou.nix {};
  tachidesk = pkgs.callPackage ./tachidesk.nix {};
}