scriptencoding utf-8

" nerdtree {
  let g:NERDTreeShowHidden=1
  let g:NERDTreeAutoDeleteBuffer=1
  " ❯
  let g:NERDTreeDirArrowExpandable = "\u276f"
  " ▽
  let g:NERDTreeDirArrowCollapsible = "\u25bd"
  let g:NERDTreeIgnore=[
              \ '\.py[cd]$', '\~$', '\.swo$', '\.swp$', '\.DS_Store$',
              \ '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$',
              \ ]
  " close vim if the only window left open is a NERDTree
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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

  let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
  let g:NERDTreeExtensionHighlightColor['css'] = g:spacevim#plug#nerdtree#colors.blue " sets the color of css files to blue
  let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
  let g:NERDTreeExtensionHighlightColor['python'] = g:spacevim#plug#nerdtree#colors.green " sets the color of css files to blue
  let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
  let g:NERDTreeExtensionHighlightColor['org'] = g:spacevim#plug#nerdtree#colors.pink " sets the color of css files to blue

  let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
  let g:NERDTreeExactMatchHighlightColor['tex'] = g:spacevim#plug#nerdtree#colors.rspec_red " sets the color of css files to blue
  let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
  let g:NERDTreeExactMatchHighlightColor['.gitignore'] = g:spacevim#plug#nerdtree#colors.git_orange " sets the color for .gitignore files
  let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
  let g:NERDTreeExactMatchHighlightColor['.ipynb'] = g:spacevim#plug#nerdtree#colors.lightPurple " sets the color for .ipynb files
  let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
  let g:NERDTreeExactMatchHighlightColor['.py'] = g:spacevim#plug#nerdtree#colors.red " sets the color for .ipynb files

  let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
  let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = g:spacevim#plug#nerdtree#colors.rspec_red " sets the color for files ending with _spec.rb
  let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
  let g:NERDTreePatternMatchHighlightColor['*.py$'] = g:spacevim#plug#nerdtree#colors.red " sets the color for files ending with _spec.rb
" }
