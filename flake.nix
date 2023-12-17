{
  description = "A flake for building PureScript projects.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-filter.url = "github:numtide/nix-filter";
    ps-overlay.url = "github:thomashoneyman/purescript-overlay";
    mkSpagoDerivation.url = "github:jeslie0/mkSpagoDerivation";
    easy-purescript-nix.url = "github:justinwoo/easy-purescript-nix";
  };

  outputs = { self, nixpkgs, flake-utils, nix-filter, ps-overlay, mkSpagoDerivation }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs =
          import nixpkgs {
            inherit system;
            overlays = [ ps-overlay.overlays.default
                         mkSpagoDerivation.overlays.default
                       ];
          };

        dependencies = with pkgs;
          [ purs-backend-es-unstable
            esbuild
          ];

        filter =
          nix-filter.lib;

        patternfly-v5 =
          pkgs.stdenvNoCC.mkDerivation rec {
            pname = "patternfly";
            version = "5.1.0";
            src = builtins.fetchTarball {
              url = "https://registry.npmjs.org/@patternfly/patternfly/-/patternfly-${version}.tgz";
              sha256 = "sha256:1cdcd9z263wjvh9jadrry8b4zndc5m1vkxb4hz04xhj69fz9dyli";
            };
            installPhase = "mkdir -p $out/patternfly; mv * $out/patternfly";
          };

        ps-project =
          pkgs.mkSpagoDerivation {
            name = "foo";
            version = "0.1.0";
            src = filter {
              root = ./.;
              include = [
                "src"
                "test"
                "spago.yaml"
                "spago.lock"
              ];
            };
            spago = pkgs.spago-unstable;
            purs = pkgs.purs-unstable;
            nativeBuildInputs = [ pkgs.esbuild pkgs.purs-backend-es pkgs.sqlite ];
            patches = [ ./patches/backend.patch ];
            buildPhase = "spago build && purs-backend-es bundle-app --no-build --minify --to=main.min.js";
            installPhase = "mkdir $out; cp -r * $out; cp -r .spago $out";
          };
      in
        {
          packages = {
            inherit ps-project;

            default = pkgs.stdenvNoCC.mkDerivation {
              pname = "patternfly-purescript";
              version = "0.1.0";
              src = ./public;
              installPhase = ''
                mkdir $out
                cp -r ${patternfly-v5}/patternfly css/patternfly
                cp -r ${ps-project}/main.min.js js/main.min.js
                cp -r * $out
              '';
            };
          };

          devShell = pkgs.mkShell {
            inputsFrom = [ self.packages.${system}.default ]; # Include build inputs from packages in
            # this list
            packages = with pkgs;
              [ watchexec
                purescript-language-server-unstable
                purs-tidy-unstable
                nodePackages.live-server
                nodejs
              ] ++ dependencies; # Extra packages to go in the shell
          };
        }
    );
}
