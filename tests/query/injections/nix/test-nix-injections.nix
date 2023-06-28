{ pkgs, stdenv }:
# NOTE: This file is for testing queries. If evaluated with nix, this will probably error.
{ 
  regex = builtins.match "^.*[{](.+)[}].*$" "blahblah {something} blahblah" [ "something" ];

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

  drv4 = pkgs.writeShellScriptBin "hello" ''
    echo "Hello world!"
  '';

  drv5 = pkgs.writeFishBin "hello" ''
    echo "Hello world!"
  '';

  drv6 = pkgs.writeHaskellBin "hello" ''
    main :: IO ()
    main = putStrLn "Hello world!"
  '';

  drv7 = pkgs.writeJSBin "hello" ''
    console.log('Hello world!');
  '';

  drv8 = pkgs.writePerlBin "hello" ''
    print("Hello world!\n");
  '';

  drv9 = pkgs.writePythonBin "hello" ''
    print("Hello world!");
  '';

  drv10 = pkgs.writeRustBin "hello" ''
    fn main() {
      println!("Hello world!");
    }
  '';

  drv11 = {
    nodes = null;
    testScript = ''
      print("Hello world!");
    '';
  };

  mod1 = {
    type = "lua";
    config = ''
      require('nvim-treesitter.configs').setup()
    '';
  };
}
