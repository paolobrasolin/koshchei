#set page(
  paper: "a4",
  margin: 1.5cm,
  header: align(right)[PRIVATE KEYRING],
  number-align: right,
  numbering: "1 OF 1",
)

#text(
  font: "DejaVu Sans Mono",
  size: 10pt,
  read("private-keyring.armored.txt"),
)
