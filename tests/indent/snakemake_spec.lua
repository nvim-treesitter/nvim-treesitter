local Runner = require('tests.indent.common').Runner
local XFAIL = require('tests.indent.common').XFAIL

local run = Runner:new(it, 'tests/indent/snakemake', {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 0,
  expandtab = true,
})

describe('indent Snakemake:', function()
  describe('whole file:', function()
    run:whole_file('.', {
      expected_failures = {},
    })
  end)

  describe('new line:', function()
    run:new_line('blocks.smk', { on_line = 1, text = 'input: 1', indent = 4 })
    run:new_line('blocks.smk', { on_line = 2, text = 'input: 1', indent = 4 })
    run:new_line('blocks.smk', { on_line = 5, text = 'input: 1', indent = 8 })
    run:new_line('blocks.smk', { on_line = 6, text = 'input: 1', indent = 8 })
    run:new_line('blocks.smk', { on_line = 8, text = 'pass', indent = 0 })
    run:new_line('blocks.smk', { on_line = 10, text = 'pass', indent = 0 })
    run:new_line('blocks.smk', { on_line = 12, text = 'pass', indent = 4 })
    run:new_line('blocks.smk', { on_line = 15, text = 'pass', indent = 4 })
    run:new_line('directive_parameters.smk', { on_line = 4, text = 'before_a = 0,', indent = 8 })
    run:new_line('directive_parameters.smk', { on_line = 5, text = 'after_a = 1.1,', indent = 8 })
    run:new_line(
      'directive_parameters.smk',
      { on_line = 7, text = '"""dedent_after_last_param"""', indent = 4 }
    )
    run:new_line(
      'directive_parameters.smk',
      { on_line = 14, text = 'b = "indent_after_param_with_comma"', indent = 8 }
    )
    run:new_line(
      'directive_parameters.smk',
      { on_line = 15, text = 'b = "indent_after_param_with_comma"', indent = 8 }
    )
    run:new_line(
      'directive_parameters.smk',
      { on_line = 17, text = 'b = "indent_after_opening"', indent = 8 }
    )
    for _, line in ipairs({ 22, 24, 26, 28, 30, 32, 34, 36 }) do
      run:new_line('directive_parameters.smk', { on_line = line, text = '"doc"', indent = 4 })
    end
  end)
end)
