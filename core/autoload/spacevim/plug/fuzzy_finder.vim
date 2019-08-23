let s:fuzzy_callback = {}

function! s:fuzzy_callback.on_exit(job_id, data, event) abort
    bdelete!
    call win_gotoid(self.window_id)
    if filereadable(self.filename)
        try
            let l:selected_filename = readfile(self.filename)[0]
            exec self.vim_cmd . l:selected_filename
        catch /E684/
        endtry
    endif
    call delete(self.filename)
endfunction

function! spacevim#plug#fuzzy_finder#fzy(choice_cmd, vim_cmd) abort
  let s:fuzzy_callback.window_id = win_getid()
  let s:fuzzy_callback.filename = tempname()
  let s:fuzzy_callback.vim_cmd = a:vim_cmd

  call spacevim#util#TryFloatingOr()

  let l:term_cmd = a:choice_cmd . ' | fzy > ' .  s:fuzzy_callback.filename
  silent call termopen(l:term_cmd, s:fuzzy_callback)
  setlocal nonumber norelativenumber
  startinsert
endfunction

function! spacevim#plug#fuzzy_finder#skim(choice_cmd, vim_cmd) abort
  let s:fuzzy_callback.window_id = win_getid()
  let s:fuzzy_callback.filename = tempname()
  let s:fuzzy_callback.vim_cmd = a:vim_cmd

  call spacevim#util#TryFloatingOr()

  let l:term_cmd = a:choice_cmd . ' | fzy > ' .  s:fuzzy_callback.filename
  silent call termopen(l:term_cmd, s:fuzzy_callback)
  setlocal nonumber norelativenumber
  startinsert
endfunction
