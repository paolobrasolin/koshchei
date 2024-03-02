log := @printf "\n\u001b[7m ■ %s \u001b[0m\n"

#=[ Converting original file to QR codes ]======================================

%.source: %
	$(log) "Copy original file"
	cp $< $@

%.source-parts: %.source
	$(log) "Create folder for parts"
	mkdir -p $@
	$(log) "Split source files into parts"
	split --bytes=1273 $* $@/

%.source-codes: %.source-parts
	$(log) "Create folder for QR codes"
	mkdir -p $@
	$(log) "Generate QR codes"
	for f in $</*; do cat $$f | qrencode -8 -v 40 -l H -s 2 -m 4 -t PNG -o $@/$$(basename $$f).png; done

#=[ Converting QR codes to recovered file ]=====================================

%.target-codes:
	echo "You should provide the input images yourself."
	exit 1

%.target-parts: %.target-codes
	$(log) "Create folder for parts"
	mkdir -p $@
	$(log) "Read QR codes"
	for f in $</*; do zbarimg -Sbinary $$f > $@/$$(basename $$f); done

%.target: %.target-parts
	$(log) "Join parts"
	cat $</* >> $@

#=[ Use test data to check mechanism works ]====================================

test-data.bin:
	$(log) "Generate test data"
	dd if=/dev/urandom bs=2953 count=4 status=none > $@

test-data.bin.target-codes: test-data.bin.source-codes
	$(log) "Fake QR recovery"
	cp -r $< $@

%.check: %.source %.target
	$(log) "Check source and target match"
	diff $^

