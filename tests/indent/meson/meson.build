project('simple', 'c')

src = [
  'source1.c',
  'source2.c',
]

if 1 == 2
  if meson.is_cross_build()
    src += [
      'src1.c',
      'src2.c']
  endif
endif

inc = include_directories([
  'dir1/',
])


dep = declare_dependency(
  sources : src,
  include_directories : inc,
)

executable('myexe', src,
  include_directories : [
    'd1',
    [
      'd2',
      'd3',
    ]
  ],
  dependencies: dep)
