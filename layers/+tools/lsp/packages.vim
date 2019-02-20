function! s:coc() abort
  MP 'neoclide/coc.nvim', { 'do': { -> coc#util#install()} }

  call timer_start(200, function('spacevim#plug#coc#Init'))

  " Load these two plugins in core/ftplugin/vim.vim
  MP 'Shougo/neco-vim',   { 'on': [] }
  MP 'neoclide/coc-neco', { 'on': [] }
endfunction

function! s:vim_lsp() abort
  MP 'prabirshrestha/async.vim'
  MP 'prabirshrestha/vim-lsp'
endfunction

function! s:lcn() abort
  MP 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
endfunction

let g:spacevim_lsp_engine = get(g:, 'spacevim_lsp_engine', 'lcn')

call s:{g:spacevim_lsp_engine}()
