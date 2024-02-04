.PHONY: fmt
fmt:
	stylua --config-path .stylua.toml --glob *.lua -- lua

.PHONY: lint
lint:
	luacheck .
