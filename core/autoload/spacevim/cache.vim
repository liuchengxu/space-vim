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
  let l:topic_base = g:spacevim.base."/layers"
  let l:topics_dir = split(globpath(l:topic_base, '*'), '\n')
  let l:topics_path = filter(l:topics_dir, 'isdirectory(v:val)')
  let l:tps = deepcopy(l:topics_path)

  let l:topic2layers = {}
  let g:spacevim.manifest = {}
  for l:topic in l:topics_path
    let l:t_k = fnamemodify(l:topic, ":t")
    let l:layers = split(globpath(l:topic, '*'), '\n')
    let l:lys = deepcopy(l:layers)
    let l:layer_name = map(l:lys, 'fnamemodify(v:val, ":t")')
    let l:topic2layers[l:t_k] = l:layer_name

    for l:layer in l:layers
      let l:l_k = fnamemodify(l:layer, ":t")
      let g:spacevim.manifest[l:l_k] = {'dir': l:layer}
    endfor
  endfor

  let g:spacevim.topics = l:topic2layers

  let l:private_base = g:spacevim.base."/private"
  let l:private_dir = split(globpath(l:private_base, '*'), '\n')
  let l:private_path = filter(l:private_dir, 'isdirectory(v:val)')

  let s:cache = g:spacevim.info
  call writefile([printf("let g:spacevim.topics = %s", g:spacevim.topics)], s:cache)
  call writefile([printf("let g:spacevim.manifest = %s", g:spacevim.manifest)], s:cache, "a")
  if len(l:private_path)
    let g:spacevim.private = map(l:private_path, 'fnamemodify(v:val, ":t")')
    call writefile([printf("let g:spacevim.private = %s", g:spacevim.private)], s:cache, "a")
  endif
endfunction

function! s:py_init()
execute s:py_exe "<< EOF"
import os
import vim
from glob import glob

def glob_basename(path):
    return map(os.path.basename, glob(path + '/*'))

spacevim_base = vim.eval('g:spacevim.base')
topic_base = spacevim_base + vim.eval('g:spacevim.layers_base')
private_base = spacevim_base + vim.eval('g:spacevim.private_base')

topics_path = [
    os.path.join(topic_base, f) for f in glob_basename(topic_base)
    if os.path.isdir(os.path.join(topic_base, f))
]
private = [
    f for f in glob_basename(private_base)
    if os.path.isdir(os.path.join(private_base, f))
]

spacevim_topics = {}
spacevim_manifest = {}

for topic in topics_path:
    layers = [
        f for f in glob_basename(topic) if os.path.isdir(os.path.join(topic, f))
    ]
    spacevim_topics[os.path.split(topic)[-1]] = layers
    for layer in layers:
        spacevim_manifest[layer] = {'dir': topic + '/' + layer}

vim.command("let g:spacevim.topics = %s" % spacevim_topics)
vim.command("let g:spacevim.manifest = %s" % spacevim_manifest)
if len(private):
    vim.command("let g:spacevim.private = %s" % private)

f = open(vim.eval('g:spacevim.info'), 'w')
f.write("let g:spacevim.topics = %s\n" % spacevim_topics)
f.write("let g:spacevim.manifest = %s\n" % spacevim_manifest)
if len(private):
    f.write("let g:spacevim.private = %s\n" % private)
f.close()

EOF
endfunction
