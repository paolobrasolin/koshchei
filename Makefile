JAB_ECC := 10
JAB_COL := 8

# private-keyring.gpg:
# 	gpg2 --export-secret-keys > $@

# private-keyring.armored.txt:
# 	gpg2 --export-secret-keys --armor > $@

# private-keyring.armored.pdf: private-keyring.armored.typ private-keyring.armored.txt
# 	typst compile $< $@

%.gpg.jabcode.png: %.gpg
	jabcodeWriter \
		--input-file $< \
		--output $@ \
		--color-number $(JAB_COL) \
		--ecc-level $(JAB_ECC) \
		--symbol-number 6 \
		--symbol-version $(shell printf "20 21 %.0s" {1..6}) \
		--symbol-position 0 2 4 8 10 20

%.rev.jabcode.png: %.rev
	jabcodeWriter \
		--input-file $< \
		--output $@ \
		--color-number $(JAB_COL) \
		--ecc-level $(JAB_ECC) \
		--symbol-number 2 \
		--symbol-version $(shell printf "20 15 %.0s" {1..2}) \
		--symbol-position 0 1

.ONESHELL:
%.jabcode.typ: %.jabcode.png
	cat <<- EOF > $@
		#set page(paper: "a4", margin: 1.5cm, header: "$*")
		#set text(font: "DejaVu Sans Mono", size: 10pt)
		#figure(image("$<"))
	EOF

%.jabcode.pdf: %.jabcode.typ %.jabcode.png
	typst compile $< $@

clean:
	rm -fv *.png *.typ *.pdf

clobber: clean
	rm -fv *.pdf

