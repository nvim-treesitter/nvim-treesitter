return {
  install_info = {
    files = { 'src/parser.c' },
    generate_requires_npm = true,
    url = 'https://gitlab.com/WhyNotHugo/tree-sitter-jsonc.git',
  },
  maintainers = { '@WhyNotHugo' },
  requires = { 'json' },
}
