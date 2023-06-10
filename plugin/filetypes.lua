local filetypes = {
  bash = { 'sh', 'apkbuild', 'PKGBUILD' },
  bibtex = { 'bib' },
  c_sharp = { 'cs' },
  commonlisp = { 'lisp' },
  devicetree = { 'dts' },
  diff = { 'gitdiff' },
  eex = { 'eelixir' },
  embedded_template = { 'eruby' },
  git_config = { 'gitconfig' },
  git_rebase = { 'gitrebase' },
  glimmer = { 'handlebars', 'html.handlebars' },
  godot_resource = { 'gdresource' },
  haskell_persistent = { 'haskellpersistent' },
  html = { 'html_tags' },
  janet_simple = { 'janet' },
  javascript = { 'javascript', 'javascriptreact', 'ecma', 'jsx' },
  latex = { 'tex', 'cls', 'sty' },
  m68k = { 'asm68k' },
  markdown = { 'pandoc', 'quarto', 'rmd' },
  ocaml_interface = { 'ocamlinterface' },
  poe_filter = { 'poefilter' },
  qmljs = { 'qml' },
  scala = { 'scala', 'sbt' },
  ssh_config = { 'sshconfig' },
  starlark = { 'bzl' },
  surface = { 'sface' },
  t32 = { 'trace32' },
  tlaplus = { 'tla' },
  tsx = { 'typescriptreact', 'typescript.tsx' },
  uxntal = { 'tal' },
  v = { 'vlang' },
  verilog = { 'sysverilog' },
  vhs = { 'tape' },
  vimdoc = { 'help' },
  xml = { 'xml', 'xsd', 'xslt', 'svg' },
}

for lang, ft in pairs(filetypes) do
  vim.treesitter.language.register(lang, ft)
end
