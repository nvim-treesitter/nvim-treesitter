return {
  install_info = {
    files = { 'src/parser.c', 'src/scanner.cc' },
    generate_requires_npm = true,
    url = 'https://github.com/tree-sitter/tree-sitter-cpp',
  },
  maintainers = { '@theHamsta' },
  requires = { 'c' },
}
