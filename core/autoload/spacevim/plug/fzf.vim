" Only suitable for space-vim-dark theme, other themes are not guaranteed.
let g:spacevim#plug#fzf#colors = {
            \ 'fg':      ['fg', 'StatusLineNC'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'String'],
            \ 'fg+':     ['fg', 'Number', 'Normal'],
            \ 'bg+':     ['bg', 'StatusLine', 'Normal'],
            \ 'hl+':     ['fg', 'Exception'],
            \ 'info':    ['fg', 'Special'],
            \ 'prompt':  ['fg', 'Function'],
            \ 'pointer': ['fg', 'Error'],
            \ 'marker':  ['fg', 'Error'],
            \ 'spinner': ['fg', 'Statement'],
            \ 'header':  ['fg', 'Number'],
            \   }

let g:fzf_layout = { 'down': '~40%'  }

" Steal from fzf.vim
" ------------------------------------------------------------------
" Common
" ------------------------------------------------------------------
let s:is_win = has('win32') || has('win64')
let s:layout_keys = ['window', 'up', 'down', 'left', 'right']
let s:TYPE = {'dict': type({}), 'funcref': type(function('call')), 'string': type(''), 'list': type([])}

let s:wide = 120

function! s:extend_opts(dict, eopts, prepend)
  if empty(a:eopts)
    return
  endif
  if has_key(a:dict, 'options')
    if type(a:dict.options) == s:TYPE.list && type(a:eopts) == s:TYPE.list
      if a:prepend
        let a:dict.options = extend(copy(a:eopts), a:dict.options)
      else
        call extend(a:dict.options, a:eopts)
      endif
    else
      let all_opts = a:prepend ? [a:eopts, a:dict.options] : [a:dict.options, a:eopts]
      let a:dict.options = join(map(all_opts, 'type(v:val) == s:TYPE.list ? join(map(copy(v:val), "fzf#shellescape(v:val)")) : v:val'))
    endif
  else
    let a:dict.options = a:eopts
  endif
endfunction

function! s:merge_opts(dict, eopts)
  return s:extend_opts(a:dict, a:eopts, 0)
endfunction

function! s:prepend_opts(dict, eopts)
  return s:extend_opts(a:dict, a:eopts, 1)
endfunction

function! s:wrap(name, opts, bang)
  " fzf#wrap does not append --expect if sink or sink* is found
  let opts = copy(a:opts)
  let options = ''
  if has_key(opts, 'options')
    let options = type(opts.options) == s:TYPE.list ? join(opts.options) : opts.options
  endif
  if options !~ '--expect' && has_key(opts, 'sink*')
    let Sink = remove(opts, 'sink*')
    let wrapped = fzf#wrap(a:name, opts, a:bang)
    let wrapped['sink*'] = Sink
  else
    let wrapped = fzf#wrap(a:name, opts, a:bang)
  endif
  return wrapped
endfunction

function! s:strip(str)
  return substitute(a:str, '^\s*\|\s*$', '', 'g')
endfunction

function! s:chomp(str)
  return substitute(a:str, '\n*$', '', 'g')
endfunction

function! s:escape(path)
  let path = fnameescape(a:path)
  return s:is_win ? escape(path, '$') : path
endfunction

if v:version >= 704
  function! s:function(name)
    return function(a:name)
  endfunction
else
  function! s:function(name)
    " By Ingo Karkat
    return function(substitute(a:name, '^s:', matchstr(expand('<sfile>'), '<SNR>\d\+_\zefunction$'), ''))
  endfunction
endif

function! s:get_color(attr, ...)
  let gui = has('termguicolors') && &termguicolors
  let fam = gui ? 'gui' : 'cterm'
  let pat = gui ? '^#[a-f0-9]\+' : '^[0-9]\+$'
  for group in a:000
    let code = synIDattr(synIDtrans(hlID(group)), a:attr, fam)
    if code =~? pat
      return code
    endif
  endfor
  return ''
endfunction

let s:ansi = {'black': 30, 'red': 31, 'green': 32, 'yellow': 33, 'blue': 34, 'magenta': 35, 'cyan': 36}

function! s:csi(color, fg)
  let prefix = a:fg ? '38;' : '48;'
  if a:color[0] == '#'
    return prefix.'2;'.join(map([a:color[1:2], a:color[3:4], a:color[5:6]], 'str2nr(v:val, 16)'), ';')
  endif
  return prefix.'5;'.a:color
endfunction

function! s:ansi(str, group, default, ...)
  let fg = s:get_color('fg', a:group)
  let bg = s:get_color('bg', a:group)
  let color = s:csi(empty(fg) ? s:ansi[a:default] : fg, 1) .
        \ (empty(bg) ? '' : s:csi(bg, 0))
  return printf("\x1b[%s%sm%s\x1b[m", color, a:0 ? ';1' : '', a:str)
endfunction

for s:color_name in keys(s:ansi)
  execute "function! s:".s:color_name."(str, ...)\n"
        \ "  return s:ansi(a:str, get(a:, 1, ''), '".s:color_name."')\n"
        \ "endfunction"
endfor

function! s:buflisted()
  return filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&filetype") != "qf"')
endfunction

function! s:fzf(name, opts, extra)
  let [extra, bang] = [{}, 0]
  if len(a:extra) <= 1
    let first = get(a:extra, 0, 0)
    if type(first) == s:TYPE.dict
      let extra = first
    else
      let bang = first
    endif
  elseif len(a:extra) == 2
    let [extra, bang] = a:extra
  else
    throw 'invalid number of arguments'
  endif

  let eopts  = has_key(extra, 'options') ? remove(extra, 'options') : ''
  let merged = extend(copy(a:opts), extra)
  call s:merge_opts(merged, eopts)
  return fzf#run(s:wrap(a:name, merged, bang))
endfunction

let s:default_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

function! s:action_for(key, ...)
  let default = a:0 ? a:1 : ''
  let Cmd = get(get(g:, 'fzf_action', s:default_action), a:key, default)
  return type(Cmd) == s:TYPE.string ? Cmd : default
endfunction

function! s:open(cmd, target)
  if stridx('edit', a:cmd) == 0 && fnamemodify(a:target, ':p') ==# expand('%:p')
    return
  endif
  execute a:cmd s:escape(a:target)
endfunction

function! s:align_lists(lists)
  let maxes = {}
  for list in a:lists
    let i = 0
    while i < len(list)
      let maxes[i] = max([get(maxes, i, 0), len(list[i])])
      let i += 1
    endwhile
  endfor
  for list in a:lists
    call map(list, "printf('%-'.maxes[v:key].'s', v:val)")
  endfor
  return a:lists
endfunction

command! -bang -nargs=* Ag
            \ call fzf#vim#ag(<q-args>,
            \                 <bang>0 ? fzf#vim#with_preview('up:80%')
            \                         : fzf#vim#with_preview('right:80%:hidden', '?'),
            \                 <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:70%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" }

function! spacevim#plug#fzf#Session()
  call fzf#run({
  \ 'source':  'ls -1 ~/.vim/session',
  \ 'sink':    'SLoad',
  \ 'options': '+m --prompt="Sessions> "',
  \ 'down':    '40%'
  \})
endfunction


" ------------------------------------------------------------------
" Configuration Files
" ------------------------------------------------------------------
function! spacevim#plug#fzf#Open()
  let l:open = [
        \ '~/.spacevim',
        \ '~/.space-vim/init.vim',
        \ '~/.bashrc',
        \ '~/.zshrc',
        \ '~/.tmux.conf'
        \ ]
  return s:fzf('open', {
        \ 'source': l:open,
        \ 'sink': 'e',
        \ 'options': '+m --prompt="Open> "',
        \ 'window': len(l:open)+2.'new'},
        \ a:000)
endfunction

" ------------------------------------------------------------------
" Runtimepath
" ------------------------------------------------------------------
function! spacevim#plug#fzf#Rtp()
  let l:rtps = split(&runtimepath, ',')
  let l:size = len(l:rtps)>20 ? 20 : len(l:rtps)
  return s:fzf('runtimepaths', {
        \ 'source': l:rtps,
        \ 'options': '+m --prompt="Rtp> "',
        \ 'window': l:size.'new'},
        \ a:000)
endfunction

" ------------------------------------------------------------------
" Oldfiles
" ------------------------------------------------------------------
function! spacevim#plug#fzf#Oldfiles()
  redir => out
  silent oldfiles
  redir END
  let l:olds = split(out, "\n")
  let l:size = len(l:olds)>20 ? 20 : len(l:olds)
  return s:fzf('oldfiles', {
        \ 'source': l:olds,
        \ 'sink': 'e',
        \ 'options': '+m --prompt="Oldfiles> "',
        \ 'window': l:size.'new'},
        \ a:000)
endfunction

let s:nbs = nr2char(0x2007)

function! s:format_cmd(line)
  return substitute(a:line, '\C \([A-Z]\S*\) ',
        \ '\=s:nbs.s:yellow(submatch(1), "Function").s:nbs', '')
endfunction

function! s:command_sink(lines)
  if len(a:lines) < 2
    return
  endif
  let cmd = matchstr(a:lines[1], s:nbs.'\zs\S*\ze'.s:nbs)
  if empty(a:lines[0])
    call feedkeys(':'.cmd.(a:lines[1][0] == '!' ? '' : ' ')."\<CR>")
  else
    execute cmd
  endif
endfunction

function! s:format_excmd(ex)
  let match = matchlist(a:ex, '^|:\(\S\+\)|\s*\S*\(.*\)')
  return printf('   '.s:blue('%-38s', 'Statement').'%s', s:nbs.match[1].s:nbs, s:strip(match[2]))
endfunction

function! s:excmds()
  let help = globpath($VIMRUNTIME, 'doc/index.txt')
  if empty(help)
    return []
  endif

  let commands = []
  let command = ''
  for line in readfile(help)
    if line =~ '^|:[^|]'
      if !empty(command)
        call add(commands, s:format_excmd(command))
      endif
      let command = line
    elseif line =~ '^\s\+\S' && !empty(command)
      let command .= substitute(line, '^\s*', ' ', '')
    elseif !empty(commands) && line =~ '^\s*$'
      break
    endif
  endfor
  if !empty(command)
    call add(commands, s:format_excmd(command))
  endif
  return commands
endfunction

" ------------------------------------------------------------------
" FZF commands
" ------------------------------------------------------------------
function! spacevim#plug#fzf#FZFCmd()
  redir => cout
  silent command
  redir END
  let list = split(cout, "\n")
  let line0 = list[0]
  let list = filter(list, 'stridx(v:val, "fzf#vim") > -1')
  call insert(list, line0)
  return s:fzf('commands', {
  \ 'source':  extend(list[0:0], map(list[1:], 's:format_cmd(v:val)')),
  \ 'sink*':   s:function('s:command_sink'),
  \ 'options': '--ansi --expect '.get(g:, 'fzf_commands_expect', 'ctrl-x').
  \            ' --tiebreak=index --header-lines 1 -x --prompt "FZF Cmd> " -n2,3,2..3 -d'.s:nbs},
  \ a:000)
endfunction

" ------------------------------------------------------------------
" spacevim related functions
" ------------------------------------------------------------------
function! spacevim#plug#fzf#Func()
  redir => fout
  silent function
  redir END
  let list = split(fout, "\n")
  let list = filter(list, 'stridx(v:val, "spacevim#") > -1')
  return s:fzf('functions', {
        \ 'source': l:list,
        \ 'sink': 'call',
        \ 'options': '+m --prompt="Func> "',
        \ 'window': len(l:list)+2.'new'},
        \ a:000)
endfunction

" ------------------------------------------------------------------
" FZF find file
" ------------------------------------------------------------------
function! spacevim#plug#fzf#FindFileInProject()
  exe ':FZF ' . FindRootDirectory()
endfunction

" ------------------------------------------------------------------
" Rag utilizes ag in the root directory of project
" ------------------------------------------------------------------
command! -nargs=* Rag
  \ call fzf#vim#ag(<q-args>, extend({'dir':FindRootDirectory(), 'options': '--prompt="'.FindRootDirectory().'> "'}, g:fzf_layout))
function! spacevim#plug#fzf#SearchInProject()
  exe ':Rag'
endfunction

" ------------------------------------------------------------------
" Search word under cursor with ag
" ------------------------------------------------------------------
function! spacevim#plug#fzf#SearchCword()
  call fzf#vim#ag(
        \ expand('<cword>'),
        \ {
        \ 'sink': 'edit',
        \ 'options': '--ansi --delimiter : --nth 4..,.. --prompt "Ag?> " '.
        \            '--color hl:68,hl+:110 --multi '.
        \            '--bind=ctrl-d:page-down,ctrl-u:page-up ',
        \ })
endfunction
