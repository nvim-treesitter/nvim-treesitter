# Nvim under test ("system under test")
NVIM_VERSION ?= nightly
# Nvim running the test harness ("host")
NVIM_HOST_VERSION := nightly
EMMYLUA_VERSION ?= 0.25.1

DEPDIR ?= .test-deps
CURL ?= curl -sL --create-dirs

ifeq ($(shell uname -s),Darwin)
    NVIM_ARCH ?= macos-arm64
    LUALS_ARCH ?= darwin-arm64
    STYLUA_ARCH ?= macos-aarch64
    RUST_ARCH ?= aarch64-apple-darwin
else
    NVIM_ARCH ?= linux-x86_64
    LUALS_ARCH ?= linux-x64
    STYLUA_ARCH ?= linux-x86_64
    RUST_ARCH ?= x86_64-unknown-linux-gnu
endif

.DEFAULT_GOAL := all

# download test dependencies

# Each version is downloaded once to $(DEPDIR)/nvim-<version>: the release build and the test
# harness modules from the same git ref (cached, "make clean" to update).
NVIM_TEST_FILES := assert.lua,harness.lua,reporter.lua,runner.lua,testutil.lua

NVIM_BIN := $(DEPDIR)/nvim-$(NVIM_VERSION)/bin/nvim
NVIM_RUNTIME := $(DEPDIR)/nvim-$(NVIM_VERSION)/share/nvim/runtime
NVIM_HOST := $(DEPDIR)/nvim-$(NVIM_HOST_VERSION)
NVIM_HOST_BIN := $(NVIM_HOST)/bin/nvim

.PHONY: nvim
nvim: $(NVIM_BIN) $(NVIM_HOST_BIN)

# Downloads to a temp dir, renamed after all downloads succeed.
$(DEPDIR)/nvim-%/bin/nvim:
	rm -rf $(DEPDIR)/nvim-$* $(DEPDIR)/nvim-$*.tmp
	mkdir -p $(DEPDIR)/nvim-$*.tmp
	$(CURL) --fail https://github.com/neovim/neovim/releases/download/$*/nvim-$(NVIM_ARCH).tar.gz \
		| tar -xz --strip-components=1 -C $(DEPDIR)/nvim-$*.tmp
	$(CURL) --fail --parallel --output "$(DEPDIR)/nvim-$*.tmp/test/#1" \
		"https://raw.githubusercontent.com/neovim/neovim/$*/test/{$(NVIM_TEST_FILES)}"
	mv $(DEPDIR)/nvim-$*.tmp $(DEPDIR)/nvim-$*

EMMYLUALS := $(DEPDIR)/emmylua_check-$(LUALS_ARCH)
EMMYLUALS_TARBALL := $(EMMYLUALS).tar.gz
EMMYLUALS_URL := https://github.com/emmyluals/emmylua-analyzer-rust/releases/download/$(EMMYLUA_VERSION)/$(notdir $(EMMYLUALS_TARBALL))

.PHONY: emmyluals
emmyluals: $(EMMYLUALS)

$(EMMYLUALS):
	$(CURL) $(EMMYLUALS_URL) -o $(EMMYLUALS_TARBALL)
	mkdir $@
	tar -xf $(EMMYLUALS_TARBALL) -C $@
	rm -rf $(EMMYLUALS_TARBALL)

STYLUA := $(DEPDIR)/stylua-$(STYLUA_ARCH)
STYLUA_TARBALL := $(STYLUA).zip
STYLUA_URL := https://github.com/JohnnyMorganz/StyLua/releases/latest/download/$(notdir $(STYLUA_TARBALL))

.PHONY: stylua
stylua: $(STYLUA)

$(STYLUA):
	$(CURL) $(STYLUA_URL) -o $(STYLUA_TARBALL)
	unzip $(STYLUA_TARBALL) -d $(STYLUA)
	rm -rf $(STYLUA_TARBALL)

TSQUERYLS := $(DEPDIR)/ts_query_ls-$(RUST_ARCH)
TSQUERYLS_TARBALL := $(TSQUERYLS).tar.gz
TSQUERYLS_URL := https://github.com/ribru17/ts_query_ls/releases/latest/download/$(notdir $(TSQUERYLS_TARBALL))

.PHONY: tsqueryls
tsqueryls: $(TSQUERYLS)

$(TSQUERYLS):
	$(CURL) $(TSQUERYLS_URL) -o $(TSQUERYLS_TARBALL)
	mkdir $@
	tar -xf $(TSQUERYLS_TARBALL) -C $@
	rm -rf $(TSQUERYLS_TARBALL)

HLASSERT := $(DEPDIR)/highlight-assertions-$(RUST_ARCH)
HLASSERT_TARBALL := $(HLASSERT).tar.gz
HLASSERT_URL := https://github.com/nvim-treesitter/highlight-assertions/releases/latest/download/$(notdir $(HLASSERT_TARBALL))

.PHONY: hlassert
hlassert: $(HLASSERT)

$(HLASSERT):
	$(CURL) $(HLASSERT_URL) -o $(HLASSERT_TARBALL)
	mkdir $@
	tar -xf $(HLASSERT_TARBALL) -C $@
	rm -rf $(HLASSERT_TARBALL)

# actual test targets

.PHONY: lua
lua: formatlua checklua

.PHONY: formatlua
formatlua: $(STYLUA)
	$(STYLUA)/stylua .

.PHONY: checklua
checklua: $(EMMYLUALS) $(NVIM_BIN)
	VIMRUNTIME=$(NVIM_RUNTIME) $(EMMYLUALS)/emmylua_check --warnings-as-errors .

.PHONY: query
query: formatquery lintquery checkquery

.PHONY: lintquery
lintquery: $(TSQUERYLS)
	$(TSQUERYLS)/ts_query_ls lint runtime/queries

.PHONY: formatquery
formatquery: $(TSQUERYLS)
	$(TSQUERYLS)/ts_query_ls format runtime/queries

.PHONY: checkquery
checkquery: $(TSQUERYLS)
	$(TSQUERYLS)/ts_query_ls check runtime/queries

.PHONY: docs
docs: $(NVIM_BIN)
	$(NVIM_BIN) -l scripts/update-readme.lua

.PHONY: tests
tests: $(NVIM_BIN) $(NVIM_HOST_BIN) $(HLASSERT)
	HLASSERT=$(HLASSERT)/highlight-assertions NVIM_LOG_FILE=$(abspath $(DEPDIR))/nvim.log \
		NVIM_PRG=$(abspath $(NVIM_BIN)) \
		$(NVIM_HOST_BIN) --clean -l $(NVIM_HOST)/test/runner.lua --helper=tests/helper.lua tests/$(TESTS)

.PHONY: all
all: lua query docs tests

.PHONY: clean
clean:
	rm -rf $(DEPDIR)
