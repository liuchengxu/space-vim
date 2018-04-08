CHANGELOG
=========

## [unreleased]

### Added

- `core/autoload/spacevim/plug/youcompleteme.vim`: keep the config.vim of `ycmd` layer as concise as possible.
- defer loading `YouCompleteMe` via `timer` if possible.
- cscope layer. Fix #130.

### Changed

- If the related layers are not enabled, finish loading the files under `core/ftplugin`.

## [0.7.0] - 2018.01.11

### Changed

- rename `LayerUpdate` to `LayerCache`
- utilize autoload mechanism to *simplify vimrc*, even though this may gain unnoticeable(or little) performance improvement. Specifically, *plug* and *vim* module are introduced and some complex settings are moved to these modules, e.g.,

  ```vim
  let g:fzf_colors = g:spacevim#plug#fzf#colors
  ```

  At the very beginning, I hope to keep space-vim as simple as possible. However, it's unevitable to make space-vim more like a vim plugin than an intuitive vim configuration over time with more and more functionalities added.

### Added

- move language specific settings to `ftplugin`
- quick installer for windows
- optimize the startup time for Vim8 and NeoVim via `timer_start()`
- clojure layer
- which-key layer
- introduce `g:spacevim_layers` to take the place of `Layer` list.

### Removed

- `Layers()` function. As a matter of fact, `Layers()` and `UserInit()` function are not necessary. I just want to explicitly differentate `Layer` from `Plug` at the beginning. But now I have realized that there is no need to bring in another lengthy command list, we already have one :). Furthermore, most people never use the option of `Layer` command.

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
