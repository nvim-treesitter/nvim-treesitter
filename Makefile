.PHONY: fmt
fmt:
	stylua --config-path .stylua.toml -g '*.lua' -g '!lua/fittencode/fs/*.lua' -g '!lua/fittencode/concurrency/*.lua' -- lua

.PHONY: lint
lint:
	luacheck .
