let s:spacevim_tab = get(s:, 'spacevim_tab', -1)
let s:spacevim_buf = get(s:, 'spacevim_buf', -1)

function! s:new_window()
  execute get(g:, 'spacevim_window', 'vertical topleft new')
endfunction

function! s:spacevim_window_exists()
  let l:buflist = tabpagebuflist(s:spacevim_tab)
  return !empty(l:buflist) && index(l:buflist, s:spacevim_buf) >= 0
endfunction

function! s:assign_name()
  " Assign buffer name
  let l:prefix = '[Layers]'
  let l:name   = l:prefix
  let l:idx    = 2
  while bufexists(l:name)
    let l:name = printf('%s (%s)', l:prefix, l:idx)
    let l:idx = l:idx + 1
  endwhile
  silent! execute 'f' fnameescape(l:name)
endfunction

" Extracted from plug.vim
function! spacevim#layer#status()
  call s:new_window()

  let b:spacevim_preview = -1
  let s:spacevim_tab = tabpagenr()
  let s:spacevim_buf = winbufnr(0)
  call s:assign_name()

  let [l:cnt, l:total] = [0, len(g:layers_loaded)]

  call append(0, ['Enabled layers: ' . '(' . len(g:layers_loaded) . '/' . g:layers_sum . ')'])
  call setline(2, '[' . repeat('=', len(g:layers_loaded)) . ']')
  let l:inx = 3
  for l:layer in g:layers_loaded
    call setline(l:inx, '+ ' . l:layer)
    let l:inx = l:inx + 1
  endfor
  setlocal buftype=nofile bufhidden=wipe nobuflisted nolist noswapfile nowrap cursorline nomodifiable nospell
  setf spacevim
  if exists('g:syntax_on')
    call s:syntax()
  endif
  nnoremap <silent> <buffer> q  :bd<CR>
endfunction

function! s:syntax()
  syntax clear
  syntax region Layer1 start=/\%1l/ end=/\%2l/ contains=LayerNumber
  syntax region Layer2 start=/\%2l/ end=/\%3l/ contains=LayerBracket,LayerX
  syn match LayerNumber /[0-9]\+[0-9.]*/ contained
  syn match LayerBracket /[[\]]/ contained
  syn match LayerX /x/ contained
  syn match LayerDash /^-/
  syn match LayerPlus /^+/
  syn match LayerStar /^*/
  syn match LayerMessage /\(^- \)\@<=.*/
  syn match LayerName /\(^- \)\@<=[^ ]*:/
  syn match LayerInstall /\(^+ \)\@<=[^:]*/
  syn match LayerUpdate /\(^* \)\@<=[^:]*/
  syn match LayerNotLoaded /(not loaded)$/
  syn match LayerError /^x.*/
  syn region LayerDeleted start=/^\~ .*/ end=/^\ze\S/
  syn match LayerH2 /^.*:\n-\+$/
  syn keyword Function LayerInstall LayerStatus LayerUpdate LayerClean
  hi def link Layer1       Title
  hi def link Layer2       Repeat
  hi def link LayerH2      Type
  hi def link LayerX       Exception
  hi def link LayerBracket Structure
  hi def link LayerNumber  Number

  hi def link LayerDash    Special
  hi def link LayerPlus    Constant
  hi def link LayerStar    Boolean

  hi def link LayerMessage Function
  hi def link LayerName    Label
  hi def link LayerInstall Function
  hi def link LayerUpdate  Type

  hi def link LayerError   Error
  hi def link LayerDeleted Ignore

  hi def link LayerNotLoaded Comment
endfunction

" get the whole available layers number s:layers_sum, number
" get the topics s:topics, list
" get the pair topic to layers s:topic2layers, dict
function! spacevim#layer#update(py_exe) abort

execute a:py_exe "<< EOF"
import os
import vim

spacevim_dir = vim.eval('g:spacevim_dir')
topic_base = spacevim_dir + vim.eval('g:spacevim_layers_dir')
private_base = spacevim_dir + vim.eval('g:spacevim_private_layers_dir')

topics = [f for f in os.listdir(topic_base) if os.path.isdir(os.path.join(topic_base,f))]
private_layers = [f for f in os.listdir(private_base) if os.path.isdir(os.path.join(private_base,f))]

layer_path = {}
topic2layers = {}
layers_sum = len(private_layers)

for t in topics:
    topic_path = topic_base + '/' + t
    layers = [f for f in os.listdir(topic_path) if os.path.isdir(os.path.join(topic_path,f))]
    layers_sum += len(layers)
    topic2layers[t] = layers
    for l in layers:
        layer_path[l] = topic_path + '/' + l

vim.command("let g:layers_sum = %d" % layers_sum)
vim.command("let g:topics = %s" % topics)
vim.command("let g:topic2layers = %s" % topic2layers)
vim.command("let g:layer_path = %s" % layer_path)
if len(private_layers):
    vim.command("let g:private_layers = %s" % private_layers)

f = open(vim.eval('g:spacevim_info_path'), 'w')
f.write("let g:layers_sum = %d\n" % layers_sum)
f.write("let g:topics = %s\n" % topics)
f.write("let g:topic2layers = %s\n" % topic2layers)
f.write("let g:layer_path = %s\n" % layer_path)
if len(private_layers):
    f.write("let g:private_layers = %s\n" % private_layers)
f.close()

EOF

endfunction
