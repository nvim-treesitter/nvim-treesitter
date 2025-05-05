<!-- 
  Before proceeding, make sure you have read https://github.com/nvim-treesitter/nvim-treesitter/blob/main/CONTRIBUTING.md!
  Make sure to fill out all fields and read the checklist at the end.
-->

# Name of language

<!-- Link to an official description of the language -->
https://...

<details>
<summary>Representative code sample</summary>
```
max. 50 lines
```
</details>

## Parser repo

https://github.com/...

<details>
<summary>Parsed tree for code sample</summary>
```
paste output of tree-sitter parse or :InspectTree here
```
</details>

## Queries

Source of queries: https://github.com/... (or "written from scratch")

<details>
<summary>Screenshots of code sample</summary>
<!-- paste screenshot of code sample using provided queries here -->
</details>

<!--
CHECKLIST: _Before_ submitting, make sure

* `./scripts/install-parsers.lua <language>` works without warnings
* `./scripts/install-parsers.lua --generate <language>` works without warnings
* `make query` works without warning
* `make docs` is run
-->
