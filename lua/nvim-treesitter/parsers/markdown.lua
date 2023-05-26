return {
  install_info = {
    files = { 'src/parser.c', 'src/scanner.c' },
    location = 'tree-sitter-markdown',
    url = 'https://github.com/MDeiml/tree-sitter-markdown',
  },
  maintainers = { '@MDeiml' },
  readme_note = 'basic highlighting',
  requires = { 'markdown_inline' },
  tier = 1,
}
