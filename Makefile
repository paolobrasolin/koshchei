log := @printf "\n\u001b[7m ■ %s \u001b[0m\n"

private-keyring.gpg:
	gpg2 --export-secret-keys > $@

private-keyring.armored.txt:
	gpg2 --export-secret-keys --armor > $@

JAB_ECC := 10
JAB_COL := 8

JAB_NUM := 6
JAB_POS := 0 2 4 8 10 20
JAB_VER := $(shell printf "20 21 %.0s" {1..$(JAB_NUM)})

private-keyring.jabcode.png: private-keyring.gpg
	jabcodeWriter \
		--input-file $< \
		--output $@ \
		--color-number $(JAB_COL) \
		--ecc-level $(JAB_ECC) \
		--symbol-number $(JAB_NUM) \
		--symbol-position $(JAB_POS) \
		--symbol-version $(JAB_VER)

private-keyring.jabcode.pdf: private-keyring.jabcode.typ private-keyring.jabcode.png
	typst compile $< $@

private-keyring.armored.pdf: private-keyring.armored.typ private-keyring.armored.txt
	typst compile $< $@
