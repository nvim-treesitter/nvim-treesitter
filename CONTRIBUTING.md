# Contributing to `nvim-treesitter`

First of all, thank you very much for contributing to `nvim-treesitter`.

If you haven't already, you should really come and reach out to us on our [gitter](https://gitter.im/nvim-treesitter/community?utm_source=share-link&utm_medium=link&utm_campaign=share-link)
room, so we can help you with any question you might have!

As you know, `nvim-treesitter` is roughly splitted in two parts :
  - Parser configurations : for various things like `locals`, `highlights`
  - What we like to call *modules* : tiny lua modules that provide a given feature, based on parser configurations

Depending on which part of the plugin you want to contribute to, please read the appropriate section.

## Parser configurations

Contributing to parser configurations is basically modifying one of the `queries/*/*.scm`.
Each of these `scheme` files contains a *tree-sitter query* for a given purpose.
Before going any further, we highly suggest that you [read more about tree-sitter queries](https://tree-sitter.github.io/tree-sitter/using-parsers#pattern-matching-with-queries).

Each query has an appropriate name, which is then used by modules to extract data from the syntax tree.
For now two types of queries are used by `nvim-treesitter`:
  - `highlights.scm` : used for syntax highlighting, using the `highlight` module.
  - `locals.scm` : used to extract keyword definitions, scopes, references,... using the `locals` module.

For both of these types there is a *norm* you will have to follow so that features work fine.
Here are some global advices :
  - If your language is listed [here](https://tree-sitter.github.io/tree-sitter/using-parsers#pattern-matching-with-queries),
    you can debug and experiment with your queries there.
  - If not, you should consider installing the [tree-sitter cli](https://github.com/tree-sitter/tree-sitter/tree/master/cli),
    you should then be able to open a local playground using `tree-sitter build-wasm && tree-sitter web-ui` within the
    parsers repo.

### Highlights

As languages differ quite a lot, here is a set of captures available to you when building a `highlights.scm` query.
One important thing to note is that many of these capture groups are not supported by `neovim` for now, and will not have any
effect on highlighting. We will work on improving highlighting in the near future though.

#### Misc
`@comment`
`@error` for error `(ERROR)` nodes.
`@punctuation.delimiter` for `;` `.` `,`
`@punctuation.bracket` for `()` or `{}`

Some captures are related to language injection (like markdown code blocks). As this is not supported by neovim yet, these
are optional and will not have any effect for now.
`@embedded`
`@injection`
  `language`
  `content`

#### Constants
`@constant`
  `builtin`
  `macro`
`@string`
  `regex`
  `escape`
`@character`
`@number`
`@boolean`
`@float`

#### Functions
`@function`
  `builtin`
  `macro`
`@parameter`

`@method`
`@field` or `@property`

`@constructor`

#### Keywords
`@conditional`
`@repeat`
`@label` for C/Lua-like labels
`@operator`
`@keyword`
`@exception`
`@include` keywords for including modules (e.g. import/from in Python)

`@type`
        `builtin`
`@structure`

### Locals

`@definition` for various definitions
  `function`
  `method`
  `var`
  `macro`
  `type`
  `field`

`@scope`

`@reference`

