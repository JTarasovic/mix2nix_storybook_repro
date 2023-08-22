{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: 
  let 
    system = "x86_64-linux";
    beam = nixpkgs.legacyPackages.${system}.beam;
    beamPackages = beam.packagesWith beam.interpreters.erlang_26;
    lib = nixpkgs.lib;

    mixNixDeps = import ./mix_deps.nix { inherit lib beamPackages; };

    thisDrv = beamPackages.mixRelease {
        pname = "test";
        version = "0.0.0";
        src = ./.;
        mixNixDeps = mixNixDeps;
    };
 in
  {
    packages.x86_64-linux.default = thisDrv;
  };
}
