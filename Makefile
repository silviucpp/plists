clean:
	rm -rf ebin

compile: clean
	mkdir ebin
	erl -run make all -run init stop -noshell