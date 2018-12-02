let g:fzf_layout = get(g:, 'fzf_layout', {'down': '~40%'})

function! s:fzf(name, opts, extra)
  call spacevim#plug#fzf_base#Run(a:name, a:opts, a:extra)
endfunction

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
function! spacevim#plug#fzf#Open(...)
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
  exe ':FZF '.spacevim#util#RootDirectory()
endfunction

" ------------------------------------------------------------------
"  ag related
" ------------------------------------------------------------------
function! s:ag(query)
  echo "\r"
  call fzf#vim#ag(a:query,{
        \ 'dir': spacevim#util#RootDirectory(),
        \ 'options': '--ansi --delimiter : --nth 4..,.. --prompt "?'.a:query.'> " '.
        \            '--color hl:68,hl+:110 --multi '.
        \            '--bind=ctrl-d:page-down,ctrl-u:page-up ',
        \ })
endfunction

" Rag utilizes ag in the root directory of project
function! spacevim#plug#fzf#AgInProject(query)
  " Clear command
  echo "\r"
  call fzf#vim#ag(a:query, extend({
      \ 'dir': spacevim#util#RootDirectory(),
      \ 'options': '--prompt="'.spacevim#util#RootDirectory().'> "'},
      \ g:fzf_layout))
endfunction

" Search word under cursor
function! spacevim#plug#fzf#SearchCword()
  call s:ag(expand('<cword>'))
endfunction

" Search visually selected
function! spacevim#plug#fzf#Vsearch()
  call s:ag(spacevim#util#VisualSelection())
endfunction

function! spacevim#plug#fzf#Rg(query, bang)
  if !executable('rg')
    return spacevim#util#warn('rg is not found')
  endif
  echo "\r"
  call fzf#vim#grep(
        \ 'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(a:query), 1,
        \ a:bang ? fzf#vim#with_preview('up:60%')
        \        : fzf#vim#with_preview('right:50%:hidden', '?'),
        \ a:bang
        \ )
endfunction

function! spacevim#plug#fzf#RgVisual()
  let l:query = spacevim#util#VisualSelection()
  call fzf#vim#grep(
        \ 'rg --column --line-number --no-heading --color=always --smart-case '.l:query, 1,
        \ )
endfunction

" Search word under cursor in current buffer
function! spacevim#plug#fzf#SearchBcword()
  call fzf#vim#buffer_lines(expand('<cword>'),{'options': '--prompt "?'.expand('<cword>').'> "'})
endfunction

" ------------------------------------------------------------------
" Jumps incompleted, sink is wrong
" ------------------------------------------------------------------
function! s:format_jump(line)
  return substitute(a:line, '\S', '\=s:yellow(submatch(0))', '')
endfunction

function! s:jump_sink(lines)
  if len(a:lines) < 2
    return
  endif
  let cmd = s:action_for(a:lines[0])
  if !empty(cmd)
    execute 'silent' cmd
  endif
  echom "a:lines[1]: ".a:lines[1]
  echom "jumps normal: ".matchstr(a:lines[1], '\d\s')
  execute 'normal! `'.matchstr(a:lines[1], '\S').'zz'
endfunction

function! spacevim#plug#fzf#Jumps(...)
  redir => cout
  silent jumps
  redir END
  let list = split(cout, "\n")
  return s:fzf('jumps', {
  \ 'source':  extend(list[0:0], map(list[1:-2], 's:format_jump(v:val)')),
  \ 'sink*':   s:function('s:jump_sink'),
  \ 'options': '+m -x --ansi --tiebreak=index --header-lines 1 --tiebreak=begin --prompt "Jumps> "'}, a:000)
endfunction
