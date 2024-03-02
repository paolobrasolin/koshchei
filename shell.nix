with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    jabcode-writer jabcode-reader typst
  ];
}
