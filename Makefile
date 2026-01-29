NVIM_VERSION ?= nightly

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

NVIM := $(DEPDIR)/nvim-$(NVIM_ARCH)
NVIM_TARBALL := $(NVIM).tar.gz
NVIM_URL := https://github.com/neovim/neovim/releases/download/$(NVIM_VERSION)/$(notdir $(NVIM_TARBALL))
NVIM_BIN := $(NVIM)/nvim-$(NVIM_ARCH)/bin/nvim
NVIM_RUNTIME=$(NVIM)/nvim-$(NVIM_ARCH)/share/nvim/runtime

.PHONY: nvim
nvim: $(NVIM)

$(NVIM):
	$(CURL) $(NVIM_URL) -o $(NVIM_TARBALL)
	mkdir $@
	tar -xf $(NVIM_TARBALL) -C $@
	rm -rf $(NVIM_TARBALL)

EMMYLUALS := $(DEPDIR)/emmylua_check-$(LUALS_ARCH)
EMMYLUALS_TARBALL := $(EMMYLUALS).tar.gz
EMMYLUALS_URL := https://github.com/emmyluals/emmylua-analyzer-rust/releases/latest/download/$(notdir $(EMMYLUALS_TARBALL))

.PHONY: emmyluals
luals: $(EMMYLUALS)

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

PLENARY := $(DEPDIR)/plenary.nvim

.PHONY: plenary
plenary: $(PLENARY)

$(PLENARY):
	git clone --filter=blob:none https://github.com/nvim-lua/plenary.nvim $(PLENARY)

# actual test targets

.PHONY: lua
lua: formatlua checklua

.PHONY: formatlua
formatlua: $(STYLUA)
	$(STYLUA)/stylua .

.PHONY: checklua
checklua: $(EMMYLUALS) $(NVIM)
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
docs: $(NVIM)
	$(NVIM_BIN) -l scripts/update-readme.lua

.PHONY: tests
tests: $(NVIM) $(HLASSERT) $(PLENARY)
	HLASSERT=$(HLASSERT)/highlight-assertions PLENARY=$(PLENARY) \
		$(NVIM_BIN) --headless --clean -u scripts/minimal_init.lua \
		-c "PlenaryBustedDirectory tests/$(TESTS) { minimal_init = './scripts/minimal_init.lua' }"

.PHONY: all
all: lua query docs tests

.PHONY: clean
clean:
	rm -rf $(DEPDIR)
