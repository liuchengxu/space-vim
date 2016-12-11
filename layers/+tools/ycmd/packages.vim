function! BuildYCM(info)
    " info is a dictionary with 3 fields
    " - name:   name of the plugin
    " - status: 'installed', 'updated', or 'unchanged'
    " - force:  set on PlugInstall! or PlugUpdate!
    if a:info.status == 'installed' || a:info.force
        !./install.py --clang-completer
    endif
endfunction

" Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

MP 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

