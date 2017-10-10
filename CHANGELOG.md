CHANGELOG
=========

## [unreleased]

### Changed

- rename `LayerUpdate` to `LayerCache`

### Added

- move language specific settings to `ftplugin`

## [0.6.0] - 2017.06.09

### Changed

- change the functions for indentifying the platform to global variables
- more beautiful statusline for Terminal vim due to the circled numbers
- markdown layer preview plugin

### Added

- support for tab
- Layers() in `.spacevim`
- s:post_user_config() for vim-airline in `core_config.vim`

## [0.5.0] - 2016.12.27

### Changed

- default statusline

## [0.4.0] - 2016.12.20

### Added

- LaTeX layer
- Elixir layer
- Lightline layer

### Changed

- Replace vim-markdown-preview with vim-Xmark to markdown layer
- Replace bronson/vim-trailing-whitespace with ntpeters/vim-better-whitespace
- A lot of details

### Removed

- Colors layer

## [0.3.0] - 2016.12.11

### Added

- Auto-completion layer
- Command: `Exclude`

### Changed

- `Plug` to `MP` in packages.vim. `MP` means "MyPlugin".

## [0.2.0] - 2016.12.09

- Bug fixes.
