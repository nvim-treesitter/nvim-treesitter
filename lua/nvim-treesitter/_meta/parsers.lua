---@meta
error('Cannot require a meta file')

---@class InstallInfo
---@field path? string
---@field url string
---@field branch? string
---@field revision? string
---@field files string[]
---@field generate_from_json? boolean
---@field generate? boolean
---@field location? string

---@class ParserInfo
---@field install_info? InstallInfo
---@field maintainers? string[]
---@field requires? string[]
---@field tier integer
---@field readme_note? string

---@alias nvim-ts.parsers table<string,ParserInfo>
