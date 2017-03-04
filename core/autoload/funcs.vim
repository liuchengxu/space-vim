" argument plugin is the vim plugin's name
function! funcs#IsDir(plugin) abort
    if isdirectory(expand(g:my_plug_home.a:plugin))
        return 1
    else
        return 0
    endif
endfunction

function! funcs#LayerLoaded(layer) abort
    if index(g:layers_loaded, a:layer) > -1
        return 1
    else
        return 0
    endif
endfunction


