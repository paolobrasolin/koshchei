with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    qrencode zbar
  ];
}
