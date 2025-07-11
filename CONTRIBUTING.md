# Contributing to `nvim-treesitter`

The main parts of `nvim-treesitter` are
* a curated list of [parsers](#Parsers);
* a collection of [queries](#Queries).

Before describing these in detail, some general advice:
* Some basic knowledge of how tree-sitter works is assumed; we recommend reading
  - the [upstream documentation](https://tree-sitter.github.io/tree-sitter/);
  - [Neovim's documentation](https://neovim.io/doc/user/treesitter.html#treesitter).
* There are dedicated Matrix channels for questions and general help:
  - [#nvim-treesitter](https://matrix.to/#/#nvim-treesitter:matrix.org) for questions specific to Neovim's implementation and the queries here;
  - [#tree-sitter](https://matrix.to/#/#tree-sitter-chat:matrix.org) for general questions regarding treesitter queries and the `tree-sitter` CLI.

## Parsers

To add a new parser, edit the following files:

1. In `lua/parsers.lua`, add an entry to the returned table of the following form:

```lua
zimbu = {
  install_info = {
    url = 'https://github.com/zimbulang/tree-sitter-zimbu', -- git repo; use `path` for local path
    revision = 'v2.1', -- tag or commit hash
    -- optional entries:
    branch = 'develop', -- only needed if different from default branch
    location = 'parser', -- only needed if the parser is in subdirectory of a "monorepo"
    generate = true, -- only needed if repo does not contain pre-generated src/parser.c
    generate_from_json = false, -- only needed if repo does not contain `src/grammar.json` either
  },
  maintainers = { '@me' }, -- the _query_ maintainers
  tier = 1, -- stable: track versioned releases instead of latest commit
  -- optional entries:
  requires = { 'vim' }, -- if the queries inherit from another language
  readme_note = "an example language",
}
```

>[!IMPORTANT]
> The "maintainers" here refers to the person maintaining the **queries** in `nvim-treesitter`, not the parser maintainers (who likely don't use Neovim). The maintainers' duty is to review issues and PRs related to the query and to keep them updated with respect to parser changes.

>[!NOTE]
> To qualify for Tier 1 ("stable"), a parser needs to
> * make releases following semver (_patch_ for fixes not affecting queries; _minor_ for changes introducing new nodes or patterns; _major_ for changes removing nodes or previously valid patterns);
> * provide WASM release artifacts;
> * include and maintain reference queries.

2. If the parser name is not the same as the Vim filetype, add an entry to the `filetypes` table in `plugin/filetypes.lua`:

```lua
  zimbu = { 'zu' },
```

>[!IMPORTANT]
> Only external scanners written in C are supported for portability reasons.

3. Update the list of [supported languages] by running `make docs` (or `./scripts/update-readme.lua` if on Windows).

4. Test if both `:TSInstall zimbu` and `:TSInstallFromGrammar zimbu` work without errors (`:checkhealth treesitter` or `./scripts/check-parsers.lua zimbu`).

>[!IMPORTANT]
> You also need to add queries in order for the parser to actually be useful!

When you're done, open a Pull Request using the [provided template](.github/PULL_REQUEST_TEMPLATE/new_language.md), e.g. using `gh pr create -B main -T new_language`.

## Queries

To add (or edit existing) queries, create a corresponding `runtime/queries/zimbu/*.scm` file:

- `highlights.scm` used for syntax highlighting,
- `injections.scm` used to specify nodes whose content should be parsed as a different language;
- `folds.scm`; used to define folds;
- `locals.scm`: used to extract keyword definitions, scopes, references, etc. (not used in this plugin).
- `indents.scm`; used to control indentation.

See [tree-sitter queries] for a basic description of the query language. The following tools can be helpful when writing or editing queries:
* [ts_query_ls] is a language server for treesitter queries, which can validate, autocomplete, and format. This tool can also be used as an offline linter and formatter (accessible through `make lintquery`, `make checkquery`, `make formatquery` targets).
* Neovim's `:InspectTree` will show the parsed tree for a buffer and highlight the text corresponding to any given node (and vice versa).
* `:EditQuery` opens a "playground" where you can write query patterns and see which parts of the buffer are captured by each capture.

>[!IMPORTANT]
> The valid captures that can be used in queries is different for each editor, so you cannot just copy them, e.g., from Helix or the parser repositories. For Neovim, all valid captures are listed below. You can verify that your changes adhere to this by running `make lintquery`.

>[!IMPORTANT]
> Since grammars can change constantly, it is important to make sure that the patterns in a query are actually valid for the parser specified in nvim-treesitter's manifest. This can be verified using `make checkquery` (which requires the parser to be installed in the default directory(!) through `nvim-treesitter`). Opening the query in Neovim with the parser installed will also show all invalid patterns, either via [ts_query_ls] or Neovim's builtin query-linter.

>[!TIP]
> Before opening a PR, run `make query` to format, lint, and check all queries.

#### Inheriting languages

If your language is an extension of a language (TypeScript is an extension of JavaScript for
example), you can include the queries from your base language by adding the following _as the first
line of your file_:

```query
; inherits: lang1,(optionallang)
```

If you want to inherit a language, but don't want the languages inheriting from yours to inherit it,
you can mark the language as optional (by putting it between parenthesis).

#### Formatting

All queries are expected to follow a standard format, with every node on a single line and indented by two spaces for each level of nesting. You can automatically format the bundled queries by running the provided formatter `./scripts/format-queries.lua` on a single file (ending in `.scm`) or directory to format.

Should you need to preserve a specific format for a node, you can exempt it (and all contained nodes) by placing before it
```query
; format-ignore
```

### Highlights

Syntax highlighting is specified in a `highlights.scm` query, which assigns treesitter nodes to captures that can be assigned a highlight group. This feature is implemented in Neovim and documented at [`:h treesitter-highlight`](https://neovim.io/doc/user/treesitter.html#treesitter-highlight).
Note that your color scheme needs to define (or link) these captures as highlight groups. You can use Neovim's built-in `:Inspect` function to see exactly which highlight groups are applied at a given position.

The valid captures are listed below.

#### Identifiers

```query
@variable                    ; various variable names
@variable.builtin            ; built-in variable names (e.g. `this`)
@variable.parameter          ; parameters of a function
@variable.parameter.builtin  ; special parameters (e.g. `_`, `it`)
@variable.member             ; object and struct fields

@constant          ; constant identifiers
@constant.builtin  ; built-in constant values
@constant.macro    ; constants defined by the preprocessor

@module            ; modules or namespaces
@module.builtin    ; built-in modules or namespaces
@label             ; GOTO and other labels (e.g. `label:` in C), including heredoc labels
```

#### Literals

```query
@string                 ; string literals
@string.documentation   ; string documenting code (e.g. Python docstrings)
@string.regexp          ; regular expressions
@string.escape          ; escape sequences
@string.special         ; other special strings (e.g. dates)
@string.special.symbol  ; symbols or atoms
@string.special.url     ; URIs (e.g. hyperlinks)
@string.special.path    ; filenames

@character              ; character literals
@character.special      ; special characters (e.g. wildcards)

@boolean                ; boolean literals
@number                 ; numeric literals
@number.float           ; floating-point number literals
```

#### Types

```query
@type             ; type or class definitions and annotations
@type.builtin     ; built-in types
@type.definition  ; identifiers in type definitions (e.g. `typedef <type> <identifier>` in C)

@attribute          ; attribute annotations (e.g. Python decorators, Rust lifetimes)
@attribute.builtin  ; builtin annotations (e.g. `@property` in Python)
@property           ; the key in key/value pairs
```

#### Functions

```query
@function             ; function definitions
@function.builtin     ; built-in functions
@function.call        ; function calls
@function.macro       ; preprocessor macros

@function.method      ; method definitions
@function.method.call ; method calls

@constructor          ; constructor calls and definitions
@operator             ; symbolic operators (e.g. `+` / `*`)
```

#### Keywords

```query
@keyword                   ; keywords not fitting into specific categories
@keyword.coroutine         ; keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
@keyword.function          ; keywords that define a function (e.g. `func` in Go, `def` in Python)
@keyword.operator          ; operators that are English words (e.g. `and` / `or`)
@keyword.import            ; keywords for including or exporting modules (e.g. `import` / `from` in Python)
@keyword.type              ; keywords describing namespaces and composite types (e.g. `struct`, `enum`)
@keyword.modifier          ; keywords modifying other constructs (e.g. `const`, `static`, `public`)
@keyword.repeat            ; keywords related to loops (e.g. `for` / `while`)
@keyword.return            ; keywords like `return` and `yield`
@keyword.debug             ; keywords related to debugging
@keyword.exception         ; keywords related to exceptions (e.g. `throw` / `catch`)

@keyword.conditional         ; keywords related to conditionals (e.g. `if` / `else`)
@keyword.conditional.ternary ; ternary operator (e.g. `?` / `:`)

@keyword.directive         ; various preprocessor directives & shebangs
@keyword.directive.define  ; preprocessor definition directives
```

#### Punctuation

```query
@punctuation.delimiter ; delimiters (e.g. `;` / `.` / `,`)
@punctuation.bracket   ; brackets (e.g. `()` / `{}` / `[]`)
@punctuation.special   ; special symbols (e.g. `{}` in string interpolation)
```

#### Comments

```query
@comment               ; line and block comments
@comment.documentation ; comments documenting code

@comment.error         ; error-type comments (e.g. `ERROR`, `FIXME`, `DEPRECATED`)
@comment.warning       ; warning-type comments (e.g. `WARNING`, `FIX`, `HACK`)
@comment.todo          ; todo-type comments (e.g. `TODO`, `WIP`)
@comment.note          ; note-type comments (e.g. `NOTE`, `INFO`, `XXX`)
```

#### Markup

Mainly for markup languages.

```query
@markup.strong         ; bold text
@markup.italic         ; italic text
@markup.strikethrough  ; struck-through text
@markup.underline      ; underlined text (only for literal underline markup!)

@markup.heading        ; headings, titles (including markers)
@markup.heading.1      ; top-level heading
@markup.heading.2      ; section heading
@markup.heading.3      ; subsection heading
@markup.heading.4      ; and so on
@markup.heading.5      ; and so forth
@markup.heading.6      ; six levels ought to be enough for anybody

@markup.quote          ; block quotes
@markup.math           ; math environments (e.g. `$ ... $` in LaTeX)

@markup.link           ; text references, footnotes, citations, etc.
@markup.link.label     ; link, reference descriptions
@markup.link.url       ; URL-style links

@markup.raw            ; literal or verbatim text (e.g. inline code)
@markup.raw.block      ; literal or verbatim text as a stand-alone block
                       ; (use priority 90 for blocks with injections)

@markup.list           ; list markers
@markup.list.checked   ; checked todo-style list markers
@markup.list.unchecked ; unchecked todo-style list markers
```

```query
@diff.plus       ; added text (for diff files)
@diff.minus      ; deleted text (for diff files)
@diff.delta      ; changed text (for diff files)
```

```query
@tag           ; XML-style tag names (and similar)
@tag.builtin   ; builtin tag names (e.g. HTML5 tags)
@tag.attribute ; XML-style tag attributes
@tag.delimiter ; XML-style tag delimiters
```

#### Non-highlighting captures

```query
@conceal ; captures that are only meant to be concealed
```

>[!TIP]
> * See [`:h tree-sitter-highlight-conceal`](https://neovim.io/doc/user/treesitter.html#treesitter-highlight-conceal).
> * The capture should be meaningful to allow proper highlighting when `set conceallevel=0`.
> * A conceal can be restricted to part of the capture via the [`#offset!` directive](https://neovim.io/doc/user/treesitter.html#treesitter-directive-offset%21).

```query
@spell   ; for defining regions to be spellchecked
@nospell ; for defining regions that should NOT be spellchecked
```

>[!TIP]
> The main types of nodes that should be spell checked are
> - comments
> - strings; where it makes sense. Strings that have interpolation or are typically used for non text purposes are not spell checked (e.g. bash).

#### Predicates

Captures can be restricted according to node contents using [predicates](https://neovim.io/doc/user/treesitter.html#treesitter-predicates).

>[!IMPORTANT]
> For performance reasons, prefer earlier predicates in this list:
>
> 1. `#eq?` (literal match)
> 2. `#any-of?` (one of several literal matches)
> 3. `#lua-match?` (match against a [Lua pattern](https://neovim.io/doc/user/luaref.html#lua-pattern))
> 4. `#match?`/`#vim-match?` (match against a [Vim regular expression](https://neovim.io/doc/user/pattern.html#regexp)

Besides those provided by Neovim, nvim-treesitter also implements

```query
#kind-eq?      ; checks whether a capture corresponds to a given set of nodes
#any-kind-eq?  ; checks whether any of a list of captures corresponds to a given set of nodes
```

#### Directives

Nodes contain metadata that can be modified via [directives](https://neovim.io/doc/user/treesitter.html#treesitter-directives).

#### Priority

Captures can be assigned a priority to control precedence of highlights via the
`#set! priority <number>` directive (see [`:h treesitter-highlight-priority`](https://neovim.io/doc/user/treesitter.html#treesitter-highlight-priority)). This is useful for controlling conflicts with injected languages or when inheriting queries from other languages.

>[!NOTE]
> The default priority for treesitter highlights is `100`; queries should only
set priorities between `90` and `120`, to avoid conflict with other sources of highlighting (such as diagnostics or LSP semantic tokens).

>[!TIP]
> Precedence is also influenced by pattern order in a query file. If possible, try to achieve the correct result by reordering patterns before resorting to explicit priorities.

### Injections

Language injections are controlled by `injections.scm` queries, which specify nodes that should be parsed as a different language. This feature is implemented in Neovim and documented at
[`:h treesitter-language-injections](https://neovim.io/doc/user/treesitter.html#treesitter-language-injections).

The valid captures are:

```query
@injection.language ; dynamic detection of the injection language (i.e. the text of the captured node describes the language)
@injection.content  ; region for the dynamically detected language
@injection.filename ; indicates that the captured node’s text may contain a filename; the corresponding filetype is then looked-up up via vim.filetype.match() and treated as the name of a language that should be used to re-parse the `@injection.content`
```

>[!TIP]
> When writing injection queries, try to ensure that each captured node is only matched by a single pattern.

### Folds

You can define folds for a given language by adding a `folds.scm` query. This is implemented in Neovim. The only valid capture is `@fold`:

```query
(function_definition) @fold ; fold this node
```

Folds should be given to nodes with defined start and end delimiters/patterns, or to consecutive nodes which are part of the same conceptual "grouping", such as consecutive line comments or import statements. The following items are valid fold candidates:

- Function/method definitions
- Class/interface/trait definitions
- Switch/match statements, and individual match arms
- Execution blocks (such as those found in conditional statements or loops)
- Parameter/argument lists
- Array/object/string expressions
- Consecutive import statements, consecutive line comments

The following items would *not* be valid fold candidates:

- Multiline assignment statements
- Multiline property access expressions

As a rule of thumb, these highlight captures usually reside in or around objects which should be folded:

- `@function`, `@function.method`
- `@keyword.import`, `@keyword.conditional`, `@keyword.repeat`
- `@comment`, `@comment.documentation`
- `@string`, `@string.documentation`
- `@markup.heading.x`, `@markup.list`

### Indents

>[!WARNING]
> Treesitter-based indentation is still experimental and likely to have breaking changes in the future.

Indentation for a language is controlled by `indents.scm` queries. The following captures can be used to set the indentation for nodes, either relative or absolute

* `@indent.begin` specifies that the next line should be indented.  Multiple
indents on the same line get collapsed, e.g.,
```query
  (
   (if_statement)
   (ERROR "else") @indent.begin
  )
```
You can also `#set! indent.immediate` to permit the next line to indent even when the block intended to be indented has no content yet. (This can improve interactive typing.)
For example for Python,
```query
 ((if_statement) @indent.begin
   (#set! indent.immediate 1))
```
will allow
```python
  if True:<CR>
      # Auto indent to here
```

* `@indent.end` is used to specify that the indented region ends and any text subsequent to the capture should be dedented.

* `@indent.branch` is used to specify that a dedented region starts at the line _including_ the captured nodes.

* `@indent.dedent` specifies dedenting starting on the _next_ line.

* `@indent.auto` behaves like Vim's [`autoindent`](https://neovim.io/doc/user/options.html#'autoindent') buffer option (copy whatever the indentation of previous line is when opening a new line after it).

* `@indent.ignore` specifies that no indent should be added to this node.

* `@indent.zero` sets the indentation of this node to 0 (i.e., removes _all_ indentation).

* `@indent.align` can be used to specify blocks that should have the same indentation.
This allows
```
  foo(a,
      b,
      c)
```
as well as
```
  foo(
    a,
    b,
    c)
```
and
```
  foo(
    a,
    b,
    c
  )
```
To specify the delimiters to align at, `#set! indent.open_delimiter` and
`indent.close_delimiter`, e.g.,
```query
 ((argument_list) @indent.align
  (#set! indent.open_delimiter "(")
  (#set! indent.close_delimiter ")"))
```
For some languages, the last line of an `indent.align` block must not be
the same indent as the natural next line.
For example in Python,

```python
  if (a > b and
      c < d):
      pass
```
is not correct, whereas
```python
  if (a > b and
	c < d):
      pass
```
would be correctly indented.  This behavior may be selected by setting
`indent.avoid_last_matching_next`. For example,
```query
 (if_statement
  condition: (parenthesized_expression) @indent.align
  (#set! indent.open_delimiter "(")
  (#set! indent.close_delimiter ")")
  (#set! indent.avoid_last_matching_next 1)
 )
```
specifies that the last line of an `@indent.align` capture
should be additionally indented to avoid clashing with the indent of the first
line of the block inside an `if`.

### Locals

Locals are used to keep track of definitions and references in local or global
scopes, see [upstream
documentation](https://tree-sitter.github.io/tree-sitter/syntax-highlighting#local-variables).
Note that nvim-treesitter uses more specific subcaptures for definitions and
**does not use locals** (for highlighting or any other purpose). These queries
are only provided for limited backwards compatibility.

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

#### Definition scope

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
   (#set! definition.var.scope "parent"))
```

Possible scope values are:

- `parent`: The definition is valid in the containing scope and one more scope above that scope
- `global`: The definition is valid in the root scope
- `local`: The definition is valid in the containing scope. This is the default behavior


[supported languages]: https://github.com/nvim-treesitter/nvim-treesitter/SUPPORTED_LANGUAGES.md
[tree-sitter queries]: https://tree-sitter.github.io/tree-sitter/using-parsers/queries/index.html
[ts_query_ls]: https://github.com/ribru17/ts_query_ls
