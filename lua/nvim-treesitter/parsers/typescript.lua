return {
  install_info = {
    files = { 'src/parser.c', 'src/scanner.c' },
    generate_requires_npm = true,
    location = 'typescript',
    url = 'https://github.com/tree-sitter/tree-sitter-typescript',
  },
  maintainers = { '@steelsojka' },
  requires = { 'ecma' },
}
