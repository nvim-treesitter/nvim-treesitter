local helpers = require('test.functional.helpers')(after_each)
local Screen = require('test.functional.ui.screen')
local clear, command = helpers.clear, helpers.command
local feed, alter_slashes = helpers.feed, helpers.alter_slashes
local insert = helpers.insert

describe('nvim-treesitter', function()
 local screen

 before_each(function()
   clear()
   screen = Screen.new(81, 15)
   screen:attach()
 end)

 after_each(function()
   screen:detach()
 end)

 it('basically works', function()
   insert("This is a line")

   screen:expect([[
  This is a lin^e                                                                   |
  {2:~                                                                                }|
  {2:~                                                                                }|
  {2:~                                                                                }|
  {2:~                                                                                }|
  {2:~                                                                                }|
  {2:~                                                                                }|
  {2:~                                                                                }|
  {2:~                                                                                }|
  {2:~                                                                                }|
  {2:~                                                                                }|
  {2:~                                                                                }|
  {2:~                                                                                }|
  {2:~                                                                                }|
                                                                                   |
]], {[2] = {bold = true, foreground = Screen.colors.Blue1}})

 end)

end)
