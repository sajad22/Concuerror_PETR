###-----------------------------------------------------------------------------
### Application info
###-----------------------------------------------------------------------------

NAME := concuerror

REBAR=$(shell which rebar3 || echo "./rebar3")

.PHONY: default
default bin/$(NAME): $(REBAR)
	$(REBAR) escriptize

MAKEFLAGS += --no-builtin-rules
.SUFFIXES:

###-----------------------------------------------------------------------------
### Rebar
###-----------------------------------------------------------------------------

REBAR_URL="https://s3.amazonaws.com/rebar3/rebar3"

./$(REBAR):
	curl -o $@ $(REBAR_URL) && chmod +x $@

###-----------------------------------------------------------------------------
### Compile
###-----------------------------------------------------------------------------

.PHONY: dev native pedantic
dev native pedantic: $(REBAR)
	$(REBAR) as $@ escriptize

###-----------------------------------------------------------------------------
### Edoc
###-----------------------------------------------------------------------------

.PHONY: edoc
edoc: $(REBAR)
	$(REBAR) edoc

###-----------------------------------------------------------------------------
### Lint
###-----------------------------------------------------------------------------

.PHONY: lint
lint: $(REBAR)
	$(REBAR) as lint lint

###-----------------------------------------------------------------------------
### Dialyzer
###-----------------------------------------------------------------------------

.PHONY: dialyzer
dialyzer: $(REBAR)
	$(REBAR) dialyzer

###-----------------------------------------------------------------------------
### Test
###-----------------------------------------------------------------------------

CONCUERROR?=$(abspath bin/$(NAME))

.PHONY: tests
tests: tests-1 tests-2

.PHONY: tests-1
tests-1: bin/$(NAME)
	@$(RM) tests/thediff
	@(cd tests; ./runtests.py suites/ba*/src/*)

.PHONY: tests-2
tests-2: bin/$(NAME)
	@$(RM) tests/thediff
	@(cd tests; ./runtests.py suites/b[^a]*/src/* suites/[^b]*/src/*)


.PHONY: tests-3
tests-3: bin/$(NAME)
	@$(RM) tests/thediff
	@(cd tests; ./runtests.py $(SC) suites/ba*/src/*)

## -j 1: ensure that the outputs of different suites are not interleaved
.PHONY: tests-real
tests-real: bin/$(NAME)
	@$(RM) $@/thediff
	$(MAKE) -j 1 -C $@ \
		TOP_DIR=$(abspath .) \
		CONCUERROR=$(CONCUERROR) \
		DIFFER=$(abspath tests/differ) \
		DIFFPRINTER=$(abspath $@/thediff)

.PHONY: tests-unit
tests-unit: bin/$(NAME)
	$(REBAR) eunit

###-----------------------------------------------------------------------------
### Cover
###-----------------------------------------------------------------------------

.PHONY: cover
cover: cover/data bin/$(NAME)
	$(RM) $</*
	$(MAKE) tests tests-real \
		CONCUERROR=$(abspath priv/concuerror) \
		CONCUERROR_COVER=$(abspath cover/data)
	cd cover; ./cover-report data

cover/data:
	@printf " MKDIR $@\n"
	@mkdir -p $@

###-----------------------------------------------------------------------------
### Clean
###-----------------------------------------------------------------------------

.PHONY: clean
clean: $(REBAR)
	$(REBAR) clean --all

.PHONY: distclean
distclean:
	$(RM) bin/$(NAME)
	$(RM) -r _build
	$(RM) ./$(REBAR)

.PHONY: cover-clean
cover-clean:
	$(RM) -r cover/data
	$(RM) cover/*.COVER.html

.PHONY: maintainer-clean
maintainer-clean: distclean cover-clean
