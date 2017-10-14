function! spacevim#cache#init() abort
  if has('python') || has('python3')
    let s:py_exe = has('python') ? 'python' : 'python3'
    try
      call s:py_init()
    catch
      call s:init()
    endtry
  else
    call s:init()
  endif
endfunction

function! s:init()
  let l:topic_base = g:spacevim_dir."/layers"
  let l:topics_dir = split(globpath(l:topic_base, '*'), '\n')
  let l:topics_path = filter(l:topics_dir, 'isdirectory(v:val)')
  let l:tps = deepcopy(l:topics_path)

  let l:topic2layers = {}

  for l:topic in l:topics_path
    let l:t_k = fnamemodify(l:topic, ":t")
    let l:layers = split(globpath(l:topic, '*'), '\n')
    let l:lys = deepcopy(l:layers)
    let l:layer_name = map(l:lys, 'fnamemodify(v:val, ":t")')
    let l:topic2layers[l:t_k] = l:layer_name

    for l:layer in l:layers
      let l:l_k = fnamemodify(l:layer, ":t")
      let g:spacevim[l:l_k] = {'dir': l:layer}
    endfor
  endfor

  let g:topics = l:topic2layers

  let l:private_base = g:spacevim_dir."/private"
  let l:private_dir = split(globpath(l:private_base, '*'), '\n')
  let l:private_path = filter(l:private_dir, 'isdirectory(v:val)')

  let s:cache = g:spacevim_info_path
  call writefile([printf("let g:topics = %s", g:topics)], s:cache, "a")
  call writefile([printf("let g:spacevim = %s", g:spacevim)], s:cache, "a")
  if len(l:private_path)
    let g:private = map(l:private_path, 'fnamemodify(v:val, ":t")')
    call writefile([printf("let g:private = %s", g:private)], s:cache, "a")
  endif
endfunction

function! s:py_init()
execute s:py_exe "<< EOF"
import os
import vim

spacevim_dir = vim.eval('g:spacevim_dir')
topic_base = spacevim_dir + vim.eval('g:spacevim_layers_dir')
private_base = spacevim_dir + vim.eval('g:spacevim_private_layers_dir')

topics_path = [
    os.path.join(topic_base, f) for f in os.listdir(topic_base)
    if os.path.isdir(os.path.join(topic_base, f))
]
private = [
    f for f in os.listdir(private_base)
    if os.path.isdir(os.path.join(private_base, f))
]

topics = {}
spacevim = {}

for topic in topics_path:
    layers = [
        f for f in os.listdir(topic) if os.path.isdir(os.path.join(topic, f))
    ]
    topics[os.path.split(topic)[-1]] = layers
    for layer in layers:
        spacevim[layer] = {'dir': topic + '/' + layer}

vim.command("let g:topics = %s" % topics)
vim.command("let g:spacevim = %s" % spacevim)
if len(private):
    vim.command("let g:private = %s" % private)

f = open(vim.eval('g:spacevim_info_path'), 'w')
f.write("let g:topics = %s\n" % topics)
f.write("let g:spacevim = %s\n" % spacevim)
if len(private):
    f.write("let g:private = %s\n" % private)
f.close()

EOF
endfunction
