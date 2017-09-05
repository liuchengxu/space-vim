function! spacevim#cache#init() abort
  if has('python')
    let s:py_exe = 'python'
    call s:py_init()
  elseif has('python3')
    let s:py_exe = 'python3'
    call s:py_init()
  else
    call s:init()
  endif
endfunction

function! s:init()
  let l:topic_base = g:spacevim_dir."/layers"
  let l:topics_dir = split(globpath(l:topic_base, '*'), '\n')
  let l:topics_path = filter(l:topics_dir, 'isdirectory(v:val)')
  let tps = deepcopy(l:topics_path)

  let g:topics = map(l:tps, 'fnamemodify(v:val, ":t")')
  let g:topic2layers = {}
  let g:layer_path = {}

  for l:topic in l:topics_path
    let l:t_k = fnamemodify(l:topic, ":t")
    let l:layers = split(globpath(l:topic, '*'), '\n')
    let l:lys = deepcopy(l:layers)
    let layer_name = map(l:lys, 'fnamemodify(v:val, ":t")')
    let g:topic2layers[l:t_k] = l:layer_name

    for l:layer in l:layers
      let l:l_k = fnamemodify(l:layer, ":t")
      let g:layer_path[l:l_k] = l:layer
    endfor
  endfor

  let l:private_base = g:spacevim_dir."/private"
  let l:private_dir = split(globpath(l:private_base, '*'), '\n')
  let l:private_path = filter(l:private_dir, 'isdirectory(v:val)')

  let s:cache = g:spacevim_info_path
  call writefile([printf("let g:topics = %s", g:topics)], s:cache)
  call writefile([printf("let g:topic2layers = %s", g:topic2layers)], s:cache, "a")
  call writefile([printf("let g:layer_path = %s", g:layer_path)], s:cache, "a")
  if len(l:private_path)
    let g:private_layers = map(l:private_path, 'fnamemodify(v:val, ":t")')
    call writefile([printf("let g:private_layers = %s", g:private_layers)], s:cache, "a")
  endif
endfunction

function! s:py_init()
execute s:py_exe "<< EOF"
import os
import vim

spacevim_dir = vim.eval('g:spacevim_dir')
topic_base = spacevim_dir + vim.eval('g:spacevim_layers_dir')
private_base = spacevim_dir + vim.eval('g:spacevim_private_layers_dir')

topics = [f for f in os.listdir(topic_base) if os.path.isdir(os.path.join(topic_base,f))]
private_layers = [f for f in os.listdir(private_base) if os.path.isdir(os.path.join(private_base,f))]

layer_path = {}
topic2layers = {}

for t in topics:
    topic_path = topic_base + '/' + t
    layers = [f for f in os.listdir(topic_path) if os.path.isdir(os.path.join(topic_path,f))]
    topic2layers[t] = layers
    for l in layers:
        layer_path[l] = topic_path + '/' + l

vim.command("let g:topics = %s" % topics)
vim.command("let g:topic2layers = %s" % topic2layers)
vim.command("let g:layer_path = %s" % layer_path)
if len(private_layers):
    vim.command("let g:private_layers = %s" % private_layers)

f = open(vim.eval('g:spacevim_info_path'), 'w')
f.write("let g:topics = %s\n" % topics)
f.write("let g:topic2layers = %s\n" % topic2layers)
f.write("let g:layer_path = %s\n" % layer_path)
if len(private_layers):
    f.write("let g:private_layers = %s\n" % private_layers)
f.close()

EOF
endfunction
