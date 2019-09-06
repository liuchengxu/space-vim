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

function! s:fuzzy_callback.on_exit_impl() abort
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

function! s:fuzzy_callback.on_exit(_job_id, _data, _event) abort
  call s:fuzzy_callback.on_exit_impl()
endfunction

function! s:fuzzy_callback.exit_cb(_job, _status) abort
  call s:fuzzy_callback.on_exit_impl()
endfunction

function! s:fuzzy_finder(term_cmd) abort
  let s:fuzzy_callback.window_id = win_getid()

  call spacevim#util#TryFloatingOr()

  if exists('*term_start')
    let opts = {
          \ 'curwin': 1,
          \ 'exit_cb': s:fuzzy_callback.exit_cb,
          \ }
    call term_start([&shell, &shellcmdflag, a:term_cmd], opts)
  elseif exists('*termopen')
    call termopen(a:term_cmd, s:fuzzy_callback)
  endif

  setlocal nospell bufhidden=wipe nobuflisted nonumber norelativenumber
  startinsert
endfunction

function! spacevim#plug#fuzzy_finder#fzy.rg() abort
  let s:fuzzy_callback.filename = tempname()
  let s:fuzzy_callback.on_selected = function('s:on_selected_rg')

  let root_dir = spacevim#util#RootDirectory()
  let cd = empty(root_dir) ? '' : 'cd '.root_dir

  " --color=always somehow disables the C-J/C-K
  "  TODO: use --color=always should take care of the escape code.
  let choice_cmd = cd.' && rg --column --no-heading --smart-case --line-number ""'
  let prompt = s:prompt("fzy> ")
  let term_cmd = choice_cmd . ' | fzy --lines=100 --prompt='.prompt.' > ' .  s:fuzzy_callback.filename

  call s:fuzzy_finder(term_cmd)

  if has('nvim')
    syntax match SpaceLinNr /^.*:\zs\d\+\ze:\d\+:/hs=s+1,he=e-1
    syntax match SpaceColumn /:\d\+:\zs\d\+\ze:/ contains=SpaceLinNr
    syntax match SpaceLinNrColumn /\zs:\d\+:\d\+:\ze/ contains=SpaceLinNr,SpaceColumn
    syntax match SpaceFpath /^.*:\d\+:\d\+:/ contains=SpaceLinNrColumn

    highlight default link SpaceFpath       Keyword
    highlight default link SpaceLinNr       LineNr
    highlight default link SpaceColumn      Comment
    highlight default link SpaceLinNrColumn Type
  endif
endfunction

function! spacevim#plug#fuzzy_finder#fzy.rg_files() abort
  let s:fuzzy_callback.filename = tempname()
  let s:fuzzy_callback.on_selected = function('s:on_selected_rg_files')

  let root_dir = spacevim#util#RootDirectory()
  let cd = empty(root_dir) ? '' : 'cd '.root_dir

  let choice_cmd = cd.' && rg --no-heading --smart-case --files '
  let prompt = s:prompt("fzy> ")
  let term_cmd = choice_cmd . ' | fzy --lines=100 --prompt='.prompt.' > ' .  s:fuzzy_callback.filename

  call s:fuzzy_finder(term_cmd)
endfunction

function! s:prompt(default) abort
  let root_dir = spacevim#util#RootDirectory()
  return empty(root_dir) ? a:default : root_dir.spacevim#util#PathSep().' '
endfunction

function! spacevim#plug#fuzzy_finder#skim.rg() abort
  let s:fuzzy_callback.filename = tempname()
  let s:fuzzy_callback.on_selected = function('s:on_selected_rg')

  let root_dir = spacevim#util#RootDirectory()
  let cd = empty(root_dir) ? '' : 'cd '.root_dir

  let prompt = s:prompt('sk> ')
  let sk_base_cmd = cd." && sk --layout=reverse --cmd-prompt ".prompt." --ansi --interactive"
  let choice_cmd = sk_base_cmd." -c 'rg --smart-case --color=always --column --line-number \"{}\"'"
  let term_cmd = choice_cmd . ' > ' .  s:fuzzy_callback.filename

  call s:fuzzy_finder(term_cmd)
endfunction

function! spacevim#plug#fuzzy_finder#skim.rg_files() abort
  let s:fuzzy_callback.filename = tempname()
  let s:fuzzy_callback.on_selected = function('s:on_selected_rg_files')

  let root_dir = spacevim#util#RootDirectory()
  let cd = empty(root_dir) ? '' : 'cd '.root_dir

  let prompt = s:prompt('sk> ')
  let sk_base_cmd = cd." && sk --layout=reverse --cmd-prompt ".prompt." --ansi --interactive"
  let choice_cmd = sk_base_cmd." -c 'rg --smart-case --color=always --files ".spacevim#util#RootDirectory()." \"{}\"'"
  let term_cmd = choice_cmd . ' > ' .  s:fuzzy_callback.filename

  call s:fuzzy_finder(term_cmd)
endfunction
