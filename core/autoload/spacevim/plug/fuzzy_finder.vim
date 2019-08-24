let s:fuzzy_callback = {}

let g:spacevim#plug#fuzzy_finder#fzy = {}
let g:spacevim#plug#fuzzy_finder#skim = {}

function! s:on_selected_rg_files(selected) abort
  execute 'edit' a:selected
endfunction

function! s:on_selected_rg(selected) abort
  let items = matchlist(a:selected, '^\(\f\+\):\(\d\+\):\(\d\+\):')
  let fname = items[1]
  let lnum = items[2]
  let column = items[3]
  execute 'edit' fname
  call cursor(lnum, column)
endfunction

function! s:fuzzy_callback.on_exit(job_id, data, event) abort
  bdelete!
  call win_gotoid(self.window_id)
  try
    if filereadable(self.filename)
      try
        let selected = readfile(self.filename)[0]
        call s:fuzzy_callback.on_selected(selected)
      catch /E684/
      endtry
    endif
  finally
    silent! call delete(self.filename)
  endtry
endfunction

function! s:fuzzy_finder(term_cmd) abort
  let s:fuzzy_callback.window_id = win_getid()

  call spacevim#util#TryFloatingOr()

  silent call termopen(a:term_cmd, s:fuzzy_callback)
  setlocal nonumber norelativenumber
  startinsert
endfunction

function! spacevim#plug#fuzzy_finder#fzy.rg() abort
  let s:fuzzy_callback.filename = tempname()
  let s:fuzzy_callback.on_selected = function('s:on_selected_rg')

  " --color=always somehow disables the C-J/C-K
  "  TODO: use --color=always should take care of the escape code.
  let choice_cmd = 'rg --column --no-heading --smart-case --line-number ""'
  let l:term_cmd = choice_cmd . ' | fzy --lines=100 --prompt='.s:prompt("fzy> ").' > ' .  s:fuzzy_callback.filename

  call s:fuzzy_finder(l:term_cmd)

  syntax match SpaceLinNr /^.*:\zs\d\+\ze:\d\+:/hs=s+1,he=e-1
  syntax match SpaceColumn /:\d\+:\zs\d\+\ze:/ contains=SpaceLinNr
  syntax match SpaceLinNrColumn /\zs:\d\+:\d\+:\ze/ contains=SpaceLinNr,SpaceColumn
  syntax match SpaceFpath /^.*:\d\+:\d\+:/ contains=SpaceLinNrColumn

  highlight default link SpaceFpath       Keyword
  highlight default link SpaceLinNr       LineNr
  highlight default link SpaceColumn      Comment
  highlight default link SpaceLinNrColumn Type
endfunction

function! spacevim#plug#fuzzy_finder#fzy.rg_files() abort
  let s:fuzzy_callback.filename = tempname()
  let s:fuzzy_callback.on_selected = function('s:on_selected_rg_files')

  let choice_cmd = 'rg --no-heading --smart-case --files '.spacevim#util#RootDirectory()
  let term_cmd = choice_cmd . ' | fzy --lines=100 --prompt='.s:prompt("fzy> ").' > ' .  s:fuzzy_callback.filename

  call s:fuzzy_finder(term_cmd)
endfunction

function! s:prompt(default) abort
  let root_dir = spacevim#util#RootDirectory()
  return empty(root_dir) ? a:default : root_dir.spacevim#util#PathSep().' '
endfunction

function! spacevim#plug#fuzzy_finder#skim.rg() abort
  let s:fuzzy_callback.filename = tempname()
  let s:fuzzy_callback.on_selected = function('s:on_selected_rg')

  let prompt = s:prompt('sk> ')
  let sk_base_cmd = "sk --layout=reverse --cmd-prompt ".s:prompt('sk> ')." --ansi --interactive"
  let choice_cmd = sk_base_cmd." -c 'rg --smart-case --color=always --column --line-number \"{}\"'"
  let term_cmd = choice_cmd . ' > ' .  s:fuzzy_callback.filename

  call s:fuzzy_finder(term_cmd)
endfunction

function! spacevim#plug#fuzzy_finder#skim.rg_files() abort
  let s:fuzzy_callback.filename = tempname()
  let s:fuzzy_callback.on_selected = function('s:on_selected_rg_files')

  let sk_base_cmd = "sk --layout=reverse --cmd-prompt ".s:prompt('sk> ')." --ansi --interactive"
  let choice_cmd = sk_base_cmd." -c 'rg --smart-case --color=always --files ".spacevim#util#RootDirectory()." \"{}\"'"
  let term_cmd = choice_cmd . ' > ' .  s:fuzzy_callback.filename

  call s:fuzzy_finder(term_cmd)
endfunction
