return {
  install_info = {
    files = { 'src/parser.c', 'src/scanner.cc' },
    generate_requires_npm = true,
    url = 'https://github.com/theHamsta/tree-sitter-hlsl',
  },
  maintainers = { '@theHamsta' },
  requires = { 'cpp' },
}
