scriptencoding utf-8

let g:spacevim#plug#nerdtree#ignore = [
              \ '\.py[cd]$', '\~$', '\.swo$', '\.swp$', '\.DS_Store$',
              \ '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$',
              \ ]
let g:spacevim#plug#nerdtree#IndicatorMapCustom = {
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

let g:spacevim#plug#nerdtree#colors = {}
" you can add these colors to your .vimrc to help customizing
let g:spacevim#plug#nerdtree#colors.brown = '905532'
let g:spacevim#plug#nerdtree#colors.aqua =  '3AFFDB'
let g:spacevim#plug#nerdtree#colors.blue = '689FB6'
let g:spacevim#plug#nerdtree#colors.darkBlue = '44788E'
let g:spacevim#plug#nerdtree#colors.purple = '834F79'
let g:spacevim#plug#nerdtree#colors.lightPurple = '834F79'
let g:spacevim#plug#nerdtree#colors.red = 'AE403F'
let g:spacevim#plug#nerdtree#colors.beige = 'F5C06F'
let g:spacevim#plug#nerdtree#colors.yellow = 'F09F17'
let g:spacevim#plug#nerdtree#colors.orange = 'D4843E'
let g:spacevim#plug#nerdtree#colors.darkOrange = 'F16529'
let g:spacevim#plug#nerdtree#colors.pink = 'CB6F6F'
let g:spacevim#plug#nerdtree#colors.salmon = 'EE6E73'
let g:spacevim#plug#nerdtree#colors.green = '8FAA54'
let g:spacevim#plug#nerdtree#colors.lightGreen = '31B53E'
let g:spacevim#plug#nerdtree#colors.white = 'FFFFFF'
let g:spacevim#plug#nerdtree#colors.rspec_red = 'FE405F'
let g:spacevim#plug#nerdtree#colors.git_orange = 'F54D27'

let g:spacevim#plug#nerdtree#ExtensionHighlightColor = {} " this line is needed to avoid error
let g:spacevim#plug#nerdtree#ExtensionHighlightColor['css'] = g:spacevim#plug#nerdtree#colors.blue " sets the color of css files to blue
let g:spacevim#plug#nerdtree#ExtensionHighlightColor = {} " this line is needed to avoid error
let g:spacevim#plug#nerdtree#ExtensionHighlightColor['python'] = g:spacevim#plug#nerdtree#colors.green " sets the color of css files to blue
let g:spacevim#plug#nerdtree#ExtensionHighlightColor = {} " this line is needed to avoid error
let g:spacevim#plug#nerdtree#ExtensionHighlightColor['org'] = g:spacevim#plug#nerdtree#colors.pink " sets the color of css files to blue

let g:spacevim#plug#nerdtree#ExactMatchHighlightColor = {} " this line is needed to avoid error
let g:spacevim#plug#nerdtree#ExactMatchHighlightColor['tex'] = g:spacevim#plug#nerdtree#colors.rspec_red " sets the color of css files to blue
let g:spacevim#plug#nerdtree#ExactMatchHighlightColor = {} " this line is needed to avoid error
let g:spacevim#plug#nerdtree#ExactMatchHighlightColor['.gitignore'] = g:spacevim#plug#nerdtree#colors.git_orange " sets the color for .gitignore files
let g:spacevim#plug#nerdtree#ExactMatchHighlightColor = {} " this line is needed to avoid error
let g:spacevim#plug#nerdtree#ExactMatchHighlightColor['.ipynb'] = g:spacevim#plug#nerdtree#colors.lightPurple " sets the color for .ipynb files
let g:spacevim#plug#nerdtree#ExactMatchHighlightColor = {} " this line is needed to avoid error
let g:spacevim#plug#nerdtree#ExactMatchHighlightColor['.py'] = g:spacevim#plug#nerdtree#colors.red " sets the color for .ipynb files

let g:spacevim#plug#nerdtree#PatternMatchHighlightColor = {} " this line is needed to avoid error
let g:spacevim#plug#nerdtree#PatternMatchHighlightColor['.*_spec\.rb$'] = g:spacevim#plug#nerdtree#colors.rspec_red " sets the color for files ending with _spec.rb
let g:spacevim#plug#nerdtree#PatternMatchHighlightColor = {} " this line is needed to avoid error
let g:spacevim#plug#nerdtree#PatternMatchHighlightColor['*.py$'] = g:spacevim#plug#nerdtree#colors.red " sets the color for files ending with _spec.rb
