let g:spacevim#neovim#floating#open = {}

function! g:spacevim#neovim#floating#open.open(row, col, width, height) abort
  let opts = {
        \ 'relative': 'editor',
        \ 'row': a:row,
        \ 'col': a:col,
        \ 'width': a:width,
        \ 'height': a:height
        \ }

  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)

  call setwinvar(win, '&winhl', 'Normal:Pmenu')
  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ norelativenumber
        \ signcolumn=no

  return win
endfunction

" +-----------------+
" |        |        |
" |  HERE  |        |
" |        |        |
" +-----------------+
function! spacevim#neovim#floating#open.left() abort
  let width = &columns / 2
  let height = &lines
  let row = 0
  let col = 0

  return self.open(row, col, width, height)
endfunction

" +-----------------+
" |        |        |
" |        |  HERE  |
" |        |        |
" +-----------------+
function! spacevim#neovim#floating#open.right() abort
  let width = &columns / 2
  let gap = &cmdheight
  if &laststatus > 0
    let gap += 1
  endif
  let height = &lines - gap
  let row = 0
  let col = &columns / 2

  return self.open(row, col, width, height)
endfunction

" +-----------------+
" |      HERE       |
" +-----------------+
" |                 |
" +-----------------+
function! spacevim#neovim#floating#open.up() abort
  let width = &columns
  let height = &lines / 2
  let row = 0
  let col = 0

  call self.open(row, col, width, height)
endfunction

" +-----------------+
" |                 |
" +-----------------+
" |       HERE      |
" +-----------------+
function! spacevim#neovim#floating#open.down() abort
  let width = &columns
  let height = &lines / 2
  let row = &lines / 2
  let col = 0

  return self.open(row, col, width, height)
endfunction


" +-----------------+
" |  HERE  |        |
" +--------+        |
" |                 |
" +-----------------+
function! spacevim#neovim#floating#open.upLeft() abort
  let width = &columns / 2
  let height = &lines / 2
  let row = 0
  let col = 0

  call self.open(row, col, width, height)
endfunction

" +-----------------+
" |                 |
" +--------+        |
" |  HERE  |        |
" +-----------------+
function! spacevim#neovim#floating#open.downLeft() abort
  let width = &columns / 2
  let height = &lines / 2
  let row = height
  let col = 0

  return self.open(row, col, width, height)
endfunction

" +-----------------+
" |                 |
" |        +--------|
" |        |  HERE  |
" +-----------------+

function! spacevim#neovim#floating#open.downRight() abort
  let width = &columns / 2
  let height = &lines / 2
  let row = height
  let col = width

  call self.open(row, col, width, height)
endfunction

" +-----------------+
" |        |  HERE  |
" |        +--------|
" |                 |
" +-----------------+
function! spacevim#neovim#floating#open.upRight() abort
  let width = &columns / 2
  let height = &lines / 2
  let row = 0
  let col = width

  return self.open(row, col, width, height)
endfunction


" +--------------+
" |   +------+   |
" |   | HERE |   |
" |   +------+   |
" +--------------+
function! spacevim#neovim#floating#open.center() abort
  let width = &columns * 2 / 3
  let height = &lines  * 2 / 3
  let row = height / 4
  let col = width / 4

  return self.open(row, col, width, height)
endfunction
