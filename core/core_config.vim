" Environment {

    " Identify platform {
    silent function! OSX()
        return has('macunix')
    endfunction
    silent function! LINUX()
        return has('unix') && !has('macunix') && !has('win32unix')
    endfunction
    silent function! WINDOWS()
        return (has('win32') || has('win64'))
    endfunction
    " }

" }

let g:spacevim_base_dir = "~/.space-vim/"

" Setup tools {

    " Load the plugins of loaded layers via plugin manager {
    function! LoadLayersPackage(relative_path)
        let s:config_file = g:spacevim_base_dir . a:relative_path
        if filereadable(expand(s:config_file))
            execute "source " . fnameescape(s:config_file)
        else
            echom 'No layers loaded.'
            finish
        endif
    endfunction
    " }

    " Load config file for layers {
    function! LoadLayersConfig(layer_base_dir, relative_path)
        for [key, val] in items(g:default_layers)
            let s:config_file = g:spacevim_base_dir . a:layer_base_dir . key . '/' . a:relative_path
            if filereadable(expand(s:config_file))
                execute "source " . fnameescape(s:config_file)
            else
                echom "config.vim for layer " . key . " is not available, please check it."
            endif
        endfor
    endfunction
    " }

    " Load private config if available {
    function! LoadPrivateConfig(relative_path)
        let s:config_file = g:spacevim_base_dir . a:relative_path
        if filereadable(expand(s:config_file))
            execute "source " . fnameescape(s:config_file)
        endif
    endfunction
    " }

" }


