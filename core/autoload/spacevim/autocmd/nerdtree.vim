scriptencoding utf-8

let s:ignore = [
              \ '\.py[cd]$', '\~$', '\.swo$', '\.swp$', '\.DS_Store$',
              \ '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$',
              \ ]
let s:IndicatorMapCustom = {
            \ 'Modified'  : '✹',
            \ 'Staged'    : '✚',
            \ 'Untracked' : '✭',
            \ 'Renamed'   : '➜',
            \ 'Unmerged'  : '═',
            \ 'Deleted'   : '✖',
            \ 'Dirty'     : '✗',
            \ 'Clean'     : '✓',
            \ 'Unknown'   : '?'
            \ }

let s:colors = {}
" you can add these colors to your .vimrc to help customizing
let s:colors.brown = '905532'
let s:colors.aqua =  '3AFFDB'
let s:colors.blue = '689FB6'
let s:colors.darkBlue = '44788E'
let s:colors.purple = '834F79'
let s:colors.lightPurple = '834F79'
let s:colors.red = 'AE403F'
let s:colors.beige = 'F5C06F'
let s:colors.yellow = 'F09F17'
let s:colors.orange = 'D4843E'
let s:colors.darkOrange = 'F16529'
let s:colors.pink = 'CB6F6F'
let s:colors.salmon = 'EE6E73'
let s:colors.green = '8FAA54'
let s:colors.lightGreen = '31B53E'
let s:colors.white = 'FFFFFF'
let s:colors.rspec_red = 'FE405F'
let s:colors.git_orange = 'F54D27'

let s:ExtensionHighlightColor = {} " this line is needed to avoid error
let s:ExtensionHighlightColor['css'] = s:colors.blue " sets the color of css files to blue
let s:ExtensionHighlightColor = {} " this line is needed to avoid error
let s:ExtensionHighlightColor['python'] = s:colors.green " sets the color of css files to blue
let s:ExtensionHighlightColor = {} " this line is needed to avoid error
let s:ExtensionHighlightColor['org'] = s:colors.pink " sets the color of css files to blue

let s:ExactMatchHighlightColor = {} " this line is needed to avoid error
let s:ExactMatchHighlightColor['tex'] = s:colors.rspec_red " sets the color of css files to blue
let s:ExactMatchHighlightColor = {} " this line is needed to avoid error
let s:ExactMatchHighlightColor['.gitignore'] = s:colors.git_orange " sets the color for .gitignore files
let s:ExactMatchHighlightColor = {} " this line is needed to avoid error
let s:ExactMatchHighlightColor['.ipynb'] = s:colors.lightPurple " sets the color for .ipynb files
let s:ExactMatchHighlightColor = {} " this line is needed to avoid error
let s:ExactMatchHighlightColor['.py'] = s:colors.red " sets the color for .ipynb files

let s:PatternMatchHighlightColor = {} " this line is needed to avoid error
let s:PatternMatchHighlightColor['.*_spec\.rb$'] = s:colors.rspec_red " sets the color for files ending with _spec.rb
let s:PatternMatchHighlightColor = {} " this line is needed to avoid error
let s:PatternMatchHighlightColor['*.py$'] = s:colors.red " sets the color for files ending with _spec.rb

function! spacevim#autocmd#nerdtree#Init()
  let g:NERDTreeMinimalUI = 1
  let g:NERDTreeDirArrows = 1 " Disable that old “Press ? for help”
  let g:NERDTreeShowHidden = 1
  let g:NERDTreeAutoDeleteBuffer = 1

  " Disable arrow icons at the left side of folders for NERDTree.
  " For the benefits of vim-devicons.
  if get(g:, 'spacevim_disable_nerdtree_arrow_icons', 0)
    let g:NERDTreeDirArrowExpandable = "\u00a0"
    let g:NERDTreeDirArrowCollapsible = "\u00a0"
  elseif get(g:, 'spacevim_nerd_fonts', 0)
    let g:NERDTreeDirArrowExpandable = ''
    let g:NERDTreeDirArrowCollapsible = ''
  else
    " ○ ●
    let g:NERDTreeDirArrowExpandable = "\u25cb"
    let g:NERDTreeDirArrowCollapsible = "\u25cf"
    " ❯
    " f47c:
    let g:NERDTreeDirArrowExpandable = "\u276f"
    let g:NERDTreeDirArrowCollapsible = ""
  endif

  let g:NERDTreeIgnore = s:ignore
" }

" nerdtree-git-plugin {
  let g:NERDTreeIndicatorMapCustom = s:IndicatorMapCustom
" }

" vim-nerdtree-syntax-highlight {
  " let g:NERDTreeFileExtensionHighlightFullName = 1
  " let g:NERDTreeExactMatchHighlightFullName = 1
  " let g:NERDTreePatternMatchHighlightFullName = 1
  " let g:NERDTreeLimitedSyntax = 1

  let g:NERDTreeExtensionHighlightColor = s:ExtensionHighlightColor " this line is needed to avoid error
  let g:NERDTreeExactMatchHighlightColor = s:ExactMatchHighlightColor " this line is needed to avoid error
"}
endfunction
