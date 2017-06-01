" argument plugin is the vim plugin's name
function! spacevim#funcs#IsDir(plugin) abort
  return isdirectory(expand(g:my_plug_home.a:plugin)) ? 1 : 0
endfunction

function! spacevim#funcs#LayerLoaded(layer) abort
    return index(g:layers_loaded, a:layer) > -1 ? 1 : 0
endfunction
