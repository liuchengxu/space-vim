function! spacevim#vim#plug#download(plug_path)
  echo '==> Downloading vim-plug ......'
  execute '!curl -fLo ' . a:plug_path . ' --create-dirs ' .
        \   'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endfunction
