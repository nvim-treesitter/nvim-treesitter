# Contributing to `nvim-treesitter`

First of all, thank you very much for contributing to `nvim-treesitter`.

If you haven't already, you should really come and reach out to us on our
[Matrix channel], so we can help you with any question you might have!

The main goal of `nvim-treesitter` is to provide a framework to easily install parsers and queries.

Depending on which part of the plugin you want to contribute to, please read the appropriate section.

## Style Checks and Tests

We haven't implemented any functional tests yet. Feel free to contribute.
However, we check code style with `luacheck` and `stylua`!
Please install `luacheck` and activate our `pre-push` hook to automatically check style before
every push:

```bash
luarocks install luacheck
cargo install stylua
ln -s ../../scripts/pre-push .git/hooks/pre-push
```

## Parsers

To add a new parser, edit the following files:

1. In `lua/parsers.lua`, add an entry to the `M.configs` table of the following form:

```lua
zimbu = {
  install_info = {
    url = 'https://github.com/zimbulang/tree-sitter-zimbu', -- local path or git repo
    files = { 'src/parser.c' }, -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    branch = 'develop', -- only needed if different from default branch
    location = 'parser', -- only needed if the parser is in subdirectory of a "monorepo"
    revision = 'v2.1', -- tag or commit hash; bypasses automated updates
    requires_generate_from_grammar = true, -- only needed if repo does not contain pre-generated src/parser.c
    generate_requires_npm = true, -- only needed if parser has npm dependencies
  },
  maintainers = { '@me' }, -- the person who will be pinged about any issues with the parser or queries
  tier = 3, -- community-contributed parser
  -- optional entries:
  requires = { 'vim' }, -- if the queries inherit from another language
  readme_note = "an example language", -- if the 
}
```

2. In `lockfile.json`, add an entry for the current commit your queries are compatible with:

```json
  "zimbu": {
    "revision": "0d08703e4c3f426ec61695d7617415fff97029bd"
  },
```

3. If the parser name is not the same as the Vim filetype, add an entry to the `filetypes` table in `plugin/filetypes.lua`:

```lua
  zimbu = { 'zu' },
```

**Note: We only support external scanners written in C (preferably) and C++03 for portability reasons.**

## Queries

Contributing to queries for an existing parser is basically modifying one of the `runtime/queries/*/*.scm`.
Each of these `scheme` files contains a _tree-sitter query_ for a given purpose.
Before going any further, we highly suggest that you [read more about tree-sitter queries](https://tree-sitter.github.io/tree-sitter/using-parsers#pattern-matching-with-queries).

Each query has an appropriate name, which is then used by modules to extract data from the syntax tree.
For now these are the types of queries used by `nvim-treesitter`:

- `highlights.scm`: used for syntax highlighting, using the `highlight` module.
- `locals.scm`: used to extract keyword definitions, scopes, references, etc, using the `locals` module.
- `textobjects.scm`: used to define text objects.
- `folds.scm`: used to define folds.
- `injections.scm`: used to define injections.

For these types there is a _norm_ you will have to follow so that features work fine.
Here are some global advices:

- If your language is listed [here](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages),
  you can debug and experiment with your queries there.
- If not, you should consider installing the [tree-sitter cli](https://github.com/tree-sitter/tree-sitter/tree/master/cli),
  you should then be able to open a local playground using `tree-sitter build-wasm && tree-sitter web-ui` within the
  parsers repo.
- Examples of queries can be found in [runtime/queries/](runtime/queries/)
- Matches in the bottom will override queries that are above of them.

If the parser and queries are added to (a local checkout) of `nvim-treesitter` and installed via `:TSInstall`, you can test whether the queries are compatible by running `./scripts/check-queries.lua`.

If your language is an extension of a language (TypeScript is an extension of JavaScript for
example), you can include the queries from your base language by adding the following _as the first
line of your file_.

```query
; inherits: lang1,(optionallang)
```

If you want to inherit a language, but don't want the languages inheriting from yours to inherit it,
you can mark the language as optional (by putting it between parenthesis).

### Highlights

As languages differ quite a lot, here is a set of captures available to you when building a `highlights.scm` query. Note that your colorscheme needs to define (or link) these captures as highlight groups.

#### Misc

```query
@comment               ; line and block comments
@comment.documentation ; comments documenting code
@error                 ; syntax/parser errors
@none                  ; completely disable the highlight
@preproc               ; various preprocessor directives & shebangs
@define                ; preprocessor definition directives
@operator              ; symbolic operators (e.g. `+` / `*`)
```

#### Punctuation

```query
@punctuation.delimiter ; delimiters (e.g. `;` / `.` / `,`)
@punctuation.bracket   ; brackets (e.g. `()` / `{}` / `[]`)
@punctuation.special   ; special symbols (e.g. `{}` in string interpolation)
```

#### Literals

```query
@string               ; string literals
@string.documentation ; string documenting code (e.g. Python docstrings)
@string.regex         ; regular expressions
@string.escape        ; escape sequences
@string.special       ; other special strings (e.g. dates)

@character            ; character literals
@character.special    ; special characters (e.g. wildcards)

@boolean              ; boolean literals
@number               ; numeric literals
@float                ; floating-point number literals
```

#### Functions

```query
@function         ; function definitions
@function.builtin ; built-in functions
@function.call    ; function calls
@function.macro   ; preprocessor macros

@method           ; method definitions
@method.call      ; method calls

@constructor      ; constructor calls and definitions
@parameter        ; parameters of a function
```

#### Keywords

```query
@keyword             ; various keywords
@keyword.coroutine   ; keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
@keyword.function    ; keywords that define a function (e.g. `func` in Go, `def` in Python)
@keyword.operator    ; operators that are English words (e.g. `and` / `or`)
@keyword.return      ; keywords like `return` and `yield`

@conditional         ; keywords related to conditionals (e.g. `if` / `else`)
@conditional.ternary ; ternary operator (e.g. `?` / `:`)

@repeat              ; keywords related to loops (e.g. `for` / `while`)
@debug               ; keywords related to debugging
@label               ; GOTO and other labels (e.g. `label:` in C)
@include             ; keywords for including modules (e.g. `import` / `from` in Python)
@exception           ; keywords related to exceptions (e.g. `throw` / `catch`)
```

#### Types

```query
@type            ; type or class definitions and annotations
@type.builtin    ; built-in types
@type.definition ; identifiers in type definitions (e.g. `typedef <type> <identifier>` in C)
@type.qualifier  ; type qualifiers (e.g. `const`)

@storageclass    ; modifiers that affect storage in memory or life-time
@attribute       ; attribute annotations (e.g. Python decorators)
@field           ; object and struct fields
@property        ; similar to `@field`
```

#### Identifiers

```query
@variable         ; various variable names
@variable.builtin ; built-in variable names (e.g. `this`)

@constant         ; constant identifiers
@constant.builtin ; built-in constant values
@constant.macro   ; constants defined by the preprocessor

@namespace        ; modules or namespaces
@symbol           ; symbols or atoms
```

#### Text

Mainly for markup languages.

```query
@text                  ; non-structured text
@text.strong           ; bold text
@text.emphasis         ; text with emphasis
@text.underline        ; underlined text
@text.strike           ; strikethrough text
@text.title            ; text that is part of a title
@text.quote            ; text quotations
@text.uri              ; URIs (e.g. hyperlinks)
@text.math             ; math environments (e.g. `$ ... $` in LaTeX)
@text.environment      ; text environments of markup languages
@text.environment.name ; text indicating the type of an environment
@text.reference        ; text references, footnotes, citations, etc.

@text.literal          ; literal or verbatim text (e.g., inline code)
@text.literal.block    ; literal or verbatim text as a stand-alone block
                       ; (use priority 90 for blocks with injections)

@text.todo             ; todo notes
@text.note             ; info notes
@text.warning          ; warning notes
@text.danger           ; danger/error notes

@text.diff.add         ; added text (for diff files)
@text.diff.delete      ; deleted text (for diff files)
```

#### Tags

Used for XML-like tags.

```query
@tag           ; XML tag names
@tag.attribute ; XML tag attributes
@tag.delimiter ; XML tag delimiters
```

#### Conceal

```query
@conceal ; for captures that are only used for concealing
```

`@conceal` must be followed by `(#set! conceal "")`.

#### Spell

```query
@spell   ; for defining regions to be spellchecked
@nospell ; for defining regions that should NOT be spellchecked
```

The main types of nodes which are spell checked are:
- Comments
- Strings; where it makes sense. Strings that have interpolation or are typically used for non text purposes are not spell checked (e.g. bash).

#### Priority

Captures can be assigned a priority to control precedence of highlights via the
`#set! "priority" <number>` directive (see `:h treesitter-highlight-priority`).
The default priority for treesitter highlights is `100`; queries should only
set priorities between `90` and `120`, to avoid conflict with other sources of
highlighting (such as diagnostics or LSP semantic tokens).

### Locals

Locals are used to keep track of definitions and references in local or global
scopes, see [upstream
documentation](https://tree-sitter.github.io/tree-sitter/syntax-highlighting#local-variables).
Note that nvim-treesitter uses more specific subcaptures for definitions and
**does not use locals for highlighting**.

```query
@local.definition            ; various definitions
@local.definition.constant   ; constants
@local.definition.function   ; functions
@local.definition.method     ; methods
@local.definition.var        ; variables
@local.definition.parameter  ; parameters
@local.definition.macro      ; preprocessor macros
@local.definition.type       ; types or classes
@local.definition.field      ; fields or properties
@local.definition.enum       ; enumerations
@local.definition.namespace  ; modules or namespaces
@local.definition.import     ; imported names
@local.definition.associated ; the associated type of a variable

@local.scope                 ; scope block
@local.reference             ; identifier reference
```

#### Definition Scope

You can set the scope of a definition by setting the `scope` property on the definition.

For example, a JavaScript function declaration creates a scope. The function name is captured as the definition.
This means that the function definition would only be available WITHIN the scope of the function, which is not the case.
The definition can be used in the scope the function was defined in.

```javascript
function doSomething() {}

doSomething(); // Should point to the declaration as the definition
```

```query
(function_declaration
  ((identifier) @local.definition.var)
   (#set! "definition.var.scope" "parent"))
```

Possible scope values are:

- `parent`: The definition is valid in the containing scope and one more scope above that scope
- `global`: The definition is valid in the root scope
- `local`: The definition is valid in the containing scope. This is the default behavior

### Folds

You can define folds for a given language by adding a `folds.scm` query :

```query
@fold ; fold this node
```

If the `folds.scm` query is not present, this will fall back to the `@local.scope` captures in the `locals`
query.

### Injections

Some captures are related to language injection (like markdown code blocks). They are used in `injections.scm`.

If you want to dynamically detect the language (e.g. for Markdown blocks) use the `@injection.language` to capture
the node describing the language and `@injection.content` to describe the injection region.

```query
@injection.language ; dynamic detection of the injection language (i.e. the text of the captured node describes the language)
@injection.content  ; region for the dynamically detected language
```

For example, to inject javascript into HTML's `<script>` tag

```html
<script>someJsCode();</script>
```

```query
(script_element
  (raw_text) @injection.content
  (#set! injection.language "javascript")) ; set the parser language for @injection.content region to javascript
```

For regions that don't have a corresponding `@injection.language`, you need to manually set the language 
through `(#set injection.language "lang_name")`

To combine all matches of a pattern as one single block of content, add `(#set! injection.combined)` to such pattern

### Indents

```query
@indent.begin       ; indent children when matching this node
@indent.end         ; marks the end of indented block
@indent.align       ; behaves like python aligned/hanging indent
@indent.dedent      ; dedent children when matching this node
@indent.branch      ; dedent itself when matching this node
@indent.ignore      ; do not indent in this node
@indent.auto        ; behaves like 'autoindent' buffer option
@indent.zero        ; sets this node at position 0 (no indent)
```

[Matrix channel]: https://matrix.to/#/#nvim-treesitter:matrix.org
