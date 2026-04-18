project('style-switcher', 'vala', 'c',
  version: '0.1.0',
  meson_version: '>= 1.0.0'
)

gnome = import('gnome')

sources = [
  'style-switcher.vala',
]

deps = [
  dependency('gtk4'),
  dependency('libadwaita-1'),
]


blueprints = custom_target('blueprints',
  input: files(
    'style-switcher.blp',
    'window.blp'
  ),
  output: '.',
  command: [find_program('blueprint-compiler'), 'batch-compile', '@OUTPUT@', '@CURRENT_SOURCE_DIR@', '@INPUT@'],
)

sources += gnome.compile_resources('style-switcher-resources',
  'style-switcher.gresource.xml',
  c_name: 'style_switcher',
  dependencies: blueprints,
  source_dir: meson.current_build_dir(),
)

executable('style-switcher', sources,
  dependencies: deps,
  install: true,
)