# Contributing to `nvim-treesitter`

First of all, thank you very much for contributing to `nvim-treesitter`.

If you haven't already, you should really come and reach out to us on our
[Matrix channel], so we can help you with any question you might have!

The main goal of `nvim-treesitter` is to provide a framework to easily install parsers and queries.

Depending on which part of the plugin you want to contribute to, please read the appropriate section.

## Style Checks and Tests

We haven't implemented any functional tests yet. Feel free to contribute.
However, we check code style with `luacheck` and `stylua`!
Please install luacheck and activate our `pre-push` hook to automatically check style before
every push:

```bash
luarocks install luacheck
cargo install stylua
ln -s ../../scripts/pre-push .git/hooks/pre-push
```

## Parser configurations

Contributing to parser configurations is basically modifying one of the `runtime/queries/*/*.scm`.
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
- If not, you should consider installing the [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/tree/master/cli),
  you should then be able to open a local playground using `tree-sitter build-wasm && tree-sitter web-ui` within the
  parsers repo.
- Examples of queries can be found in [runtime/queries/](runtime/queries/)
- Matches in the bottom will override queries that are above of them.

#### Inheriting languages

If your language is an extension of a language (TypeScript is an extension of JavaScript for
example), you can include the queries from your base language by adding the following _as the first
line of your file_.

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

As languages differ quite a lot, here is a set of captures available to you when building a `highlights.scm` query. Note that your color scheme needs to define (or link) these captures as highlight groups.

#### Identifiers

```query
@variable            ; various variable names
@variable.builtin    ; built-in variable names (e.g. `this`)
@variable.parameter  ; parameters of a function
@variable.member     ; object and struct fields

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
@type.qualifier   ; type qualifiers (e.g. `const`)

@attribute        ; attribute annotations (e.g. Python decorators)
@property         ; the key in key/value pairs
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
@keyword.import            ; keywords for including modules (e.g. `import` / `from` in Python)
@keyword.storage           ; modifiers that affect storage in memory or life-time
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

@comment.error         ; error-type comments (e.g. `ERROR`, `FIXME`, `DEPRECATED:`)
@comment.warning       ; warning-type comments (e.g. `WARNING:`, `FIX:`, `HACK:`)
@comment.todo          ; todo-type comments (e.g. `TODO:`, `WIP:`, `FIXME:`)
@comment.note          ; note-type comments (e.g. `NOTE:`, `INFO:`, `XXX`)
```

#### Markup

Mainly for markup languages.

```query
@markup.strong         ; bold text
@markup.italic         ; italic text
@markup.strikethrough  ; struck-through text
@markup.underline      ; underlined text (only for literal underline markup!)

@markup.heading        ; headings, titles (including markers)

@markup.quote          ; block quotes
@markup.math           ; math environments (e.g. `$ ... $` in LaTeX)
@markup.environment    ; environments (e.g. in LaTeX)

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
@tag.attribute ; XML-style tag attributes
@tag.delimiter ; XML-style tag delimiters
```

#### Non-highlighting captures

```query
@none    ; completely disable the highlight
@conceal ; captures that are only meant to be concealed
```

```query
@spell   ; for defining regions to be spellchecked
@nospell ; for defining regions that should NOT be spellchecked
```

The main types of nodes which are spell checked are:
- Comments
- Strings; where it makes sense. Strings that have interpolation or are typically used for non text purposes are not spell checked (e.g. bash).

#### Predicates

Captures can be restricted according to node contents using [predicates](https://neovim.io/doc/user/treesitter.html#treesitter-predicates). For performance reasons, prefer earlier predicates in this list:

1. `#eq?` (literal match)
2. `#any-of?` (one of several literal matches)
3. `#lua-match?` (match against a [Lua pattern](https://neovim.io/doc/user/luaref.html#lua-pattern))
4. `#match?`/`#vim-match?` (match against a [Vim regular expression](https://neovim.io/doc/user/pattern.html#regexp)

#### Conceal

Captures can be concealed by setting the [`conceal` metadata](https://neovim.io/doc/user/treesitter.html#treesitter-highlight-conceal), e.g..,
```query
    (fenced_code_block_delimiter @markup.raw.block (#set! conceal ""))
```
The capture should be meaningful to allow proper highlighting when `set conceallevel=0`. If the unconcealed capture should not be highlighted (e.g., because an earlier pattern handles this), you can use `@conceal`.

A conceal can be restricted to part of the capture via the [`#offset!` directive](https://neovim.io/doc/user/treesitter.html#treesitter-directive-offset%21).

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
