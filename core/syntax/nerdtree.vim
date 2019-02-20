" https://github.com/scrooloose/nerdtree/issues/807
" remove the slashes after each directory node
setlocal conceallevel=3
syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained

function! s:get_color(group, attr) abort
  return synIDattr(synIDtrans(hlID(a:group)), a:attr)
endfunction

let s:use_gui = has('gui_running') || (has('termguicolors') && &termguicolors)
let s:normal_bg = s:get_color('Normal', 'bg')

" NERDTress File highlighting
function! s:hl(extension, group)
  exec 'syn match' a:extension '/^\s\+.*'. a:extension .'$/'

  let fg = s:get_color(a:group, 'fg')
  let attrs = s:use_gui ? "guibg=".s:normal_bg." guifg=".fg : "ctermbg=".s:normal_bg." ctermfg=".fg

  execute 'hi!' a:extension attrs
endfunction

let s:hi_group = {
      \ 'Comment': ['md', 'org', 'txt'],
      \ 'Constant': ['gitignore'],
      \ 'String': ['toml', 'yml', 'ini', 'info', 'conf', 'yaml'],
      \ 'Character': ['png', 'svg', 'jpg', 'bmp', 'gif'],
      \ 'Number': ['sass', 'scss', 'css', 'less', 'coffee'],
      \ 'Float': ['sh', 'bash', 'zsh', 'ksh', 'ps1', 'fish', 'bat'],
      \ 'Identifier': ['vim', 'ts', 'vue', 'swift', 'dart'],
      \ 'Function': ['html', 'js', 'jsx', 'ts'],
      \ 'Statement': ['py', 'pyc', 'pyo', 'rb', 'php', 'lua'],
      \ 'Label': ['hs', 'go', 'java'],
      \ 'Operator': ['rc'],
      \ 'PreCondit': ['profile'],
      \ 'Boolean': ['cpp', 'cc', 'hpp', 'cxx', 'hxx', 'h'],
      \ 'Include': ['history'],
      \ }

for [group, exts] in items(s:hi_group)
  for ext in exts
    call s:hl(ext, group)
  endfor
endfor

unlet s:hi_group s:use_gui s:normal_bg
