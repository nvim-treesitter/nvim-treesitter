return {
  install_info = {
    files = { 'src/parser.c', 'src/scanner.cc' },
    location = 'dialects/terraform',
    url = 'https://github.com/MichaHoffmann/tree-sitter-hcl',
  },
  maintainers = { '@MichaHoffmann' },
  requires = { 'hcl' },
  tier = 3,
}
