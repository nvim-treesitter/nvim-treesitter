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

local filename = utils.join_path(utils.get_package_path(), "lockfile.json")

local locked_parsers = ts_install.load_lockfile()

local function write_lockfile(verbose, skipped_parers)
  local sorted_parsers = {}
  -- Load previous lockfile
  skipped_parers = skipped_parers or {}

  for k, v in pairs(parsers.get_parser_configs()) do
    table.insert(sorted_parsers, { name = k, parser = v })
  end

  table.sort(sorted_parsers, function(a, b)
    return a.name < b.name
  end)

  local Job = require "plenary.job"
  local jobs = {}

  for _, v in ipairs(sorted_parsers) do
    if not vim.tbl_contains(skipped_parers, v.name) then
      local url = v.parser.install_info.url
      local maintainers = v.parser.maintainers or {}
      local filetype = v.parser.filetype or v.name
      local job = Job:new { command = "git", args = { "ls-remote", url, "HEAD" } }
      job:after_success(function(this_job)
        print("checked " .. v.name)
        local latest_sha = this_job:result()[1]:gsub("\tHEAD", "")
        locked_parsers[v.name] = {
          revision = latest_sha,
          url = url,
          maintainers = maintainers,
          filetype = filetype,
        }
      end)
      job:start()
      table.insert(jobs, job)
    else
      print("Skipping " .. v.name)
    end
  end
  Job.join(unpack(jobs))

  if verbose then
    print(vim.inspect(locked_parsers))
  end

  local fd = assert(io.open(filename, "w"))
  fd:write(vim.json.encode(locked_parsers), "\n")
  fd:flush()
end

write_lockfile()
vim.cmd "q"
