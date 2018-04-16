scriptencoding utf-8

if !empty(glob("$HOME/.local/share/nvim/plugged/vim-mucomplete")) ||  !empty(glob("$HOME/.vim/plugged/vim-mucomplete"))
  let g:mucomplete#enable_auto_at_startup = 1
  set completeopt+=noselect
  inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
  inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
  inoremap <expr>  <cr> mucomplete#popup_exit("\<cr>")

  " Fix key mappings' clash from vim-better-default
  iunmap <c-j>
  iunmap <c-h>
endif

" enter key setting
function ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippet()
    if g:ulti_expand_res > 0
        return snippet
    else
      return "\<C-y>"
    endif
endfunction

inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
