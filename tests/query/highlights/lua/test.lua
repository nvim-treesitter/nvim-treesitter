-- luacheck: ignore
local a = { 1, 2, 3, 4, 5 }
--          ^ @number     ^ @punctuation.bracket
--    ^ @variable

local _ = next(a)
--          ^ @function.builtin
-- ^ @keyword

_ = next(a)
--   ^ @function.builtin

next(a)
-- ^ @function.builtin

-- Checking for incorrect hlgroup of injected luap
string.match(s, '\0%d[^\n]+')
--                       ^ !constant
