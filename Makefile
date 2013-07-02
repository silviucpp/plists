clean:
	rm -rf ebin

compile: clean
	mkdir ebin
	erl -run make all -run init stop -noshell

docs:
	cd doc && \
	erl -eval 'edoc:files(["../src/plists.erl"])' -run init stop -noshell