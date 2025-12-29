# NOTE: This file is for testing queries. If evaluated with nix, this will probably error.
{ pkgs, stdenv, lib }: let
  match = builtins.match;
in {
  regex = builtins.match "^.*[{](.+)[}].*$" "blahblah {something} blahblah" [ "something" ];

  regex2 = match "^.*[{](.+)[}].*$" "blahblah {something} blahblah" [ "something" ];

  drv1 = stdenv.mkDerivation {
    buildPhase = "mkdir $out";
    installPhase = ''
      echo "bar" > $out/foo.txt
    '';
  };

  drv2 = pkgs.writeShellApplication {
    name = "shellApp";
    buildInputs = [];
    text = ''
      echo "Hello world!"
    '';
  };

  drv3 = pkgs.runCommand "foo-bar" {} ''
    mkir $out
    echo "bar" > $out/foo.txt
  '';

  drv4 = pkgs.runCommandNoCC "foo-bar" {} ''
    mkir $out
    echo "bar" > $out/foo.txt
  '';

  drv5 = pkgs.writeShellScriptBin "hello" ''
    echo "Hello world!"
  '';

  drv6 = pkgs.writeFishBin "hello" ''
    echo "Hello world!"
  '';

  drv7 = pkgs.writeHaskellBin "hello" ''
    main :: IO ()
    main = putStrLn "Hello world!"
  '';

  drv8 = pkgs.writeJSBin "hello" ''
    console.log('Hello world!');
  '';

  drv9 = pkgs.writePerlBin "hello" ''
    print("Hello world!\n");
  '';

  drv10 = pkgs.writePythonBin "hello" ''
    print("Hello world!");
  '';

  drv11 = pkgs.writeRustBin "hello" ''
    fn main() {
      println!("Hello world!");
    }
  '';

  drv12 = lib.nixos.runTest {
    nodes = null;
    testScript = ''
      print("Hello world!");
    '';
  };

  mod1 = {
    type = "lua";
    config = ''
      require('nvim-treesitter.config').setup()
    '';
  };
}
