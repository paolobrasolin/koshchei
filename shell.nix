with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    qrencode zbar imagemagick
    jabcode-writer jabcode-reader typst
  ];
}
