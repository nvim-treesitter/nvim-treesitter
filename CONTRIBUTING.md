# Contributing to `nvim-treesitter`

First of all, thank you very much for contributing to `nvim-treesitter`.

If you haven't already, you should really come and reach out to us on our [gitter](https://gitter.im/nvim-treesitter/community?utm_source=share-link&utm_medium=link&utm_campaign=share-link)
room, so we can help you with any question you might have!

As you know, `nvim-treesitter` is roughly splitted in two parts :

- Parser configurations : for various things like `locals`, `highlights`
- What we like to call *modules* : tiny lua modules that provide a given feature, based on parser configurations

Depending on which part of the plugin you want to contribute to, please read the appropriate section.

## Style Checks and Tests

We haven't implemented any functional tests yet. Feel free to contribute.
However, we check code style with `luacheck`!
Please install luacheck and activate our `pre-push` hook to automatically check style before
every push:

```bash
luarocks install luacheck
ln -s ../../scripts/pre-push .git/hooks/pre-push
```

## Adding new modules

If you want to see a new functionality added to `nvim-treesitter` feel free to first open an issue
to that we can track our solution!
Thus far, there is basically two types of modules:

- Little modules (like `incremental selection`) that are built in `nvim-treesitter`, we call them
  `builtin modules`.
- Bigger modules (like `completion-treesitter`, or `nvim-tree-docs`), or modules that integrate
  with other plugins, that we call `remote modules`.

In any case, you can build your own module ! To help you started in the process, we have a template
repository designed to build new modules [here](https://github.com/nvim-treesitter/module-template).
Feel free to use it, and contact us over on our
[gitter](https://gitter.im/nvim-treesitter/community?utm_source=share-link&utm_medium=link&utm_campaign=share-link).

## Parser configurations

Contributing to parser configurations is basically modifying one of the `queries/*/*.scm`.
Each of these `scheme` files contains a *tree-sitter query* for a given purpose.
Before going any further, we highly suggest that you [read more about tree-sitter queries](https://tree-sitter.github.io/tree-sitter/using-parsers#pattern-matching-with-queries).

Each query has an appropriate name, which is then used by modules to extract data from the syntax tree.
For now two types of queries are used by `nvim-treesitter`:

- `highlights.scm`: used for syntax highlighting, using the `highlight` module.
- `locals.scm`: used to extract keyword definitions, scopes, references, etc, using the `locals` module.
- `textobjects.scm`: used to define text objects.
- `folds.scm`: used to define folds.

For these types there is a *norm* you will have to follow so that features work fine.
Here are some global advices :

- If your language is listed [here](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages),
  you can install the [playground plugin](https://github.com/nvim-treesitter/playground).
- If your language is listed [here](https://tree-sitter.github.io/tree-sitter/using-parsers#pattern-matching-with-queries),
  you can debug and experiment with your queries there.
- If not, you should consider installing the [tree-sitter cli](https://github.com/tree-sitter/tree-sitter/tree/master/cli),
  you should then be able to open a local playground using `tree-sitter build-wasm && tree-sitter web-ui` within the
  parsers repo.
- Examples of queries can be found in [queries/](queries/)
- Matches in the bottom will override queries that are above of them.

If your language is an extension of a language (TypeScript is an extension of JavaScript for
example), you can include the queries from your base language by adding the following _as the first
line of your file_.

```scheme
; inherits: lang1,(optionallang)
```

If you want to include a language for a given query, but don't want for the queries including the
query you qre writing to include it too, you can mark the language as optional (by putting it
between parenthesis).

### Highlights

As languages differ quite a lot, here is a set of captures available to you when building a `highlights.scm` query.
One important thing to note is that many of these capture groups are not supported by `neovim` for now, and will not have any
effect on highlighting. We will work on improving highlighting in the near future though.

#### Misc

```
@comment
@error for error `ERROR` nodes.
@none to disable completely the highlight
@punctuation.delimiter for `;` `.` `,`
@punctuation.bracket for `()` or `{}`
@punctuation.special for symbols with special meaning like `{}` in string interpolation.
```

Some captures are related to language injection (like markdown code blocks). As this is not supported by neovim yet, these
are optional and will not have any effect for now.

```
@embedded
@injection
@injection.language
@injection.content
```

#### Constants

```
@constant
@constant.builtin
@constant.macro
@string
@string.regex
@string.escape
@string.special
@character
@number
@boolean
@float
```

#### Functions

```
@function
@function.builtin
@function.macro
@parameter

@method
@field
@property

@constructor
```

#### Keywords

```
@conditional
@repeat
@label for C/Lua-like labels
@keyword
@keyword.function
@keyword.operator (for operators that are English words, e.g. `and`, `or`)
@operator (for symbolic operators, e.g. `+`, `*`)
@exception
@include keywords for including modules (e.g. import/from in Python)

@type
@type.builtin
@namespace for identifiers referring to namespaces
@attribute for e.g. Python decorators
```

#### Variables

```
@variable
@variable.builtin
```

#### Text

Mainly for markup languages.

```
@text
@text.strong
@text.emphasis
@text.underline
@text.title
@text.literal
@text.uri
```

#### Tags

Used for xml-like tags

```
@tag
@tag.delimiter
```

### Locals

```
@definition for various definitions
@definition.function
@definition.method
@definition.var
@definition.parameter
@definition.macro
@definition.type
@definition.field
@definition.enum
@definition.namespace for modules or C++ namespaces
@definition.import for imported names

@definition.associated to determine the type of a variable
@definition.doc for documentation adjacent to a definition. E.g.

@scope
@reference
@constructor
```

#### Definition Scope

You can set the scope of a definition by setting the `scope` property on the definition.

For example, a javascript function declaration creates a scope. The function name is captured as the definition.
This means that the function definition would only be available WITHIN the scope of the function, which is not the case.
The definition can be used in the scope the function was defined in.

```javascript
function doSomething() {}

doSomething(); // Should point to the declaration as the definition
```

```scheme
(function_declaration
  ((identifier) @definition.var)
   (set! "definition.var.scope" "parent"))
```

Possible scope values are:

- `parent`: The definition is valid in the containing scope and one more scope above that scope
- `global`: The definition is valid in the root scope
- `local`: The definition is valid in the containing scope. This is the default behavior

### Folds

You can define folds for a given language by adding a `folds.scm` query :

```
@fold
```

If the `fold.scm` query is not present, this will fallback to the `@scope` captures in the `locals`
query.
