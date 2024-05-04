.PHONY: cf
cf:
	CodeFormat format -c .editorconfig -w lua/

.PHONY: sl
sl:
	stylua --config-path .stylua.toml -g '*.lua' -g '!lua/fittencode/fs/*.lua' -g '!lua/fittencode/concurrency/*.lua' -- lua

.PHONY: lint
lint:
	luacheck .
