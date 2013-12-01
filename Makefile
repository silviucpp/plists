EBIN=ebin
SRC=src
FINISH=-run init stop -noshell

get-version:
	@erl -eval 'io:format("~p~n", [ \
		proplists:get_value(vsn,element(3,element(2,hd(element(3, \
			erl_eval:exprs(element(2, erl_parse:parse_exprs(element(2, \
				erl_scan:string("Data = " ++ binary_to_list(element(2, \
					file:read_file("src/plists.app.src"))))))), []))))))])' \
	$(FINISH)

# Note that this make target expects to be used like so:
#	$ ERL_LIBS=some/path make get-installdir
#
# Which would give the following result:
#	some/path/plists-1.0.0
get-installdir:
	@echo $(ERL_LIBS)/plists-$(shell make get-version)

clean:
	rm -rf $(EBIN)

compile: clean
	mkdir $(EBIN)
	erl -run make all $(FINISH)

docs:
	cd doc && \
	erl -eval 'edoc:files(["../src/plists.erl"])' $(FINISH)

# Running 'make install' without setting ERL_LIBS in the env will result in
# an error. You should do a system-wide install like this:
# 	$ ERL_LIBS=/opt/erlang/r15b03/lib make install
install: INSTALLDIR=$(shell make get-installdir)
install:
	if [ "$$ERL_LIBS" != "" ]; \
	then mkdir -p $(INSTALLDIR)/$(EBIN); \
		 mkdir -p $(INSTALLDIR)/$(SRC); \
	     cp -pPR $(EBIN) $(INSTALLDIR); \
	     cp -pPR $(SRC) $(INSTALLDIR); \
	else \
		echo "ERROR: No 'ERL_LIBS' value is set in the env." \
		&& exit 1; \
	fi
