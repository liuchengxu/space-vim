" Commands:
" p, pick <commit> = use commit
" r, reword <commit> = use commit, but edit the commit message
" e, edit <commit> = use commit, but stop for amending
" s, squash <commit> = use commit, but meld into previous commit
" f, fixup <commit> = like "squash", but discard this commit's log message
" x, exec <command> = run command (the rest of the line) using shell
" d, drop <commit> = remove commit
" l, label <label> = label current HEAD with a name
" t, reset <label> = reset HEAD to a label
" m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
" .       create a merge commit using the original merge commit's
" .       message (or the oneline, if no original merge commit was
" .       specified). Use -c <commit> to reword the commit message.
"
" These lines can be re-ordered; they are executed from top to bottom.
"
" If you remove a line here THAT COMMIT WILL BE LOST.
"
"	However, if you remove everything, the rebase will be aborted.
"
"
" Note that empty commits are commented out

if !get(b:, 'spacevim_enable_map', 0)
  finish
endif

function! s:rebase_action(cmd) abort
  let cur_line = split(getline('.'))
  let cur_line[0] = a:cmd
  let cur_line = join(cur_line)
  call setline(line('.'), cur_line)
endfunction

let s:commands = {
      \ 'p': 'pick',
      \ 'r': 'reword',
      \ 'e': 'edit',
      \ 's': 'squash',
      \ 'f': 'fixup',
      \ 'x': 'exec',
      \ 'd': 'drop',
      \ 'l': 'label',
      \ 't': 'reset'
      \ }

for [k, cmd] in items(s:commands)
  execute 'nnoremap <silent> <buffer>' k ':call <SID>rebase_action("'.cmd.'")<CR>'
endfor
