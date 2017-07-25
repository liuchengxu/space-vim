
MP 'rdnetto/YCM-Generator',  { 'on': ['YcmGenerateConfig', 'CCGenerateConfig'], 'branch': 'stable' }

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status ==# 'installed' || a:info.force
    !./install.py --clang-completer
  endif
endfunction

MP 'Valloric/YouCompleteMe', { 'do': function('BuildYCM'), 'on': [] }

" Load YCM for specific filetypes
function! s:invoke_ycm()
  let l:supported = ['c', 'cpp', 'python', 'vim', 'javascript', 'go', 'sh', 'rust']
  let l:cur_ft = &filetype
  if index(l:supported, l:cur_ft) > -1
    call plug#load('YouCompleteMe')
  endif
endfunction

augroup loadYcm
  autocmd!
  autocmd InsertEnter * call s:invoke_ycm() | autocmd! loadYcm
augroup END
