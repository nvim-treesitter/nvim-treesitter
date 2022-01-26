-- Execute as `nvim --headless -c "luafile ./scripts/write-lockfile.lua"`

local skip_langs = vim.fn.getenv "SKIP_LOCKFILE_UPDATE_FOR_LANGS"
if skip_langs == vim.NIL then
  skip_langs = {}
else
  skip_langs = vim.fn.split(skip_langs, ",")
end

local ts_install = require "nvim-treesitter.install"
local utils = require "nvim-treesitter.utils"
local parsers = require "nvim-treesitter.parsers"

print("Skipping languages: " .. vim.inspect(skip_langs))

local function call_proc(process, opts, cb)
  local std_output = ""
  local error_output = ""

  local function onread(handle, is_stderr)
    return function(err, data)
      if data then
        if is_stderr then
          error_output = (error_output or "") .. data
        else
          std_output = (std_output or "") .. data
        end
      end
    end
  end
  local uv = vim.loop

  local handle

  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)

  local stdio = { nil, stdout, stderr }

  handle = uv.spawn(
    process,
    { args = opts.args, cwd = uv.cwd(), stdio = stdio },
    vim.schedule_wrap(function(code)
      if code ~= 0 then
        stdout:read_stop()
        stderr:read_stop()
      end

      local check = uv.new_check()
      check:start(function()
        for _, pipe in ipairs(stdio) do
          if pipe and not pipe:is_closing() then
            return
          end
        end
        check:stop()
        handle:close()
        cb(code, std_output, error_output)
      end)
    end)
  )

  uv.read_start(stdout, onread(handle, false))
  uv.read_start(stderr, onread(handle, true))

  return handle
end

local filename = utils.join_path(utils.get_package_path(), "lockfile.json")

local locked_parsers = ts_install.load_lockfile()

local completed = 0

local function write_lockfile(verbose, skipped_parers)
  local requested_parsers = {}
  local active_jobs = {}
  -- Load previous lockfile
  skipped_parers = skipped_parers or {}

  for k, v in pairs(parsers.get_parser_configs()) do
    if not vim.tbl_contains(skipped_parers, k) then
      table.insert(requested_parsers, { name = k, parser = v })
    else
      print("Skipping " .. v.name)
    end
  end

  table.sort(requested_parsers, function(a, b)
    return a.name < b.name
  end)

  for _, v in ipairs(requested_parsers) do
    local url = v.parser.install_info.url
    local maintainers = v.parser.maintainers or {}
    local filetype = v.parser.filetype or v.name
    local abi = v.parser.abi or "NA"
    local revision = v.parser.revision or v.parser.branch or "master"

    local on_done = function(success, result, errors)
      completed = completed + 1
      if not success then
        print("error: " .. errors)
        return
      end
      local latest_sha = result:gsub("\tHEAD\n", "")
      locked_parsers[v.name] = {
        revision = latest_sha or revision,
        url = url,
        maintainers = maintainers,
        filetype = filetype,
        abi = abi,
      }
    end

    local handle = call_proc("git", { args = { "ls-remote", url, "HEAD" } }, on_done)
    table.insert(active_jobs, handle)
  end

  print("active: " .. #active_jobs)
  print("parsers: " .. #requested_parsers)

  vim.wait(#active_jobs * 60 * 1000, function()
    return completed == #active_jobs
  end)

  if verbose then
    print(vim.inspect(locked_parsers))
  end

  local fd = assert(io.open(filename, "w"))
  fd:write(vim.json.encode(locked_parsers), "\n")
  fd:flush()
end

write_lockfile()
vim.cmd "q"
