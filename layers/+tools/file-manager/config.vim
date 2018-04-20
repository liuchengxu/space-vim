scriptencoding utf-8

" nerdtree {
  let g:NERDTreeShowHidden=1
  let g:NERDTreeAutoDeleteBuffer=1
  " ❯
  let g:NERDTreeDirArrowExpandable = "\u276f"
  let g:NERDTreeDirArrowCollapsible = "~"
  let g:NERDTreeIgnore = g:spacevim#plug#nerdtree#ignore

  nnoremap <F4> :NERDTreeToggle<CR>
  inoremap <F4> <ESC>:NERDTreeToggle<CR>
  nnoremap <Leader>ft :NERDTreeToggle<CR>
  nnoremap <Leader>fd :NERDTreeFind<CR>
" }

" nerdtree-git-plugin {
  let g:NERDTreeIndicatorMapCustom = g:spacevim#plug#nerdtree#IndicatorMapCustom
" }

" vim-nerdtree-syntax-highlight {
  " let g:NERDTreeFileExtensionHighlightFullName = 1
  " let g:NERDTreeExactMatchHighlightFullName = 1
  " let g:NERDTreePatternMatchHighlightFullName = 1
  " let g:NERDTreeLimitedSyntax = 1

  let g:NERDTreeExtensionHighlightColor = g:spacevim#plug#nerdtree#ExtensionHighlightColor " this line is needed to avoid error
  let g:NERDTreeExactMatchHighlightColor = g:spacevim#plug#nerdtree#ExactMatchHighlightColor " this line is needed to avoid error
" }

" 907th/vim-auto-save{
  let g:auto_save = 1
  let g:auto_save_events=["InsertLeave","TextChanged","QuitPre"]
  let g:auto_save_write_all_buffers=1
  let g:autosave_timer=5000
" }
