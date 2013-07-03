## Where we install LFE, in the ERL_LIBS directory.
INSTALLDIR = $(ERL_LIBS)/lfe-$(shell cat VERSION)
EBIN=ebin
FINISH=-run init stop -noshell

get-version:
	@erl -eval 'io:format("~p~n", [ \
		proplists:get_value(vsn,element(3,element(2,hd(element(3, \
			erl_eval:exprs(element(2, erl_parse:parse_exprs(element(2, \
				erl_scan:string("Data = " ++ binary_to_list(element(2, \
					file:read_file("src/plists.app.src"))))))), []))))))])' \
	$(FINISH)

clean:
	rm -rf $(EBIN)

compile: clean
	mkdir $(EBIN)
	erl -run make all $(FINISH)

docs:
	cd doc && \
	erl -eval 'edoc:files(["../src/plists.erl"])' $(FINISH)