" :h cscope
"
" USAGE :cs find {querytype} {name}
"
" 0 or s: Find this C symbol
" 1 or g: Find this definition
" 2 or d: Find functions called by this function
" 3 or c: Find functions calling this function
" 4 or t: Find this text string
" 6 or e: Find this egrep pattern
" 7 or f: Find this file
" 8 or i: Find files #including this file
" 9 or a: Find places where this symbol is assigned a value

"   's'   symbol:   find all references to the token under cursor
"   'g'   global:   find global definition(s) of the token under cursor
"   'c'   calls:    find all calls to the function name under cursor
"   't'   text:     find all instances of the text under cursor
"   'e'   egrep:    egrep search for the word under cursor
"   'f'   file:     open the filename under cursor
"   'i'   includes: find files that include the filename under cursor
"   'd'   called:   find functions that function under cursor calls

" cscope databases are searched first, followed by tag files if cscope did not return any matches.
set csto=0
" always search cscope database as well as tag files.
set cscopetag
set cscopequickfix=s-,c-,d-,i-,t-,e-,a-

nmap <leader>cs :call spacevim#vim#cscope#Find('symbol')<CR>
nmap <leader>cg :call spacevim#vim#cscope#Find('global')<CR>
nmap <leader>cc :call spacevim#vim#cscope#Find('calls')<CR>
nmap <leader>ct :call spacevim#vim#cscope#Find('text')<CR>
nmap <leader>ce :call spacevim#vim#cscope#Find('egrep')<CR>
nmap <leader>cf :call spacevim#vim#cscope#Find('file')<CR>
nmap <leader>ci :call spacevim#vim#cscope#Find('includes')<CR>
nmap <leader>cd :call spacevim#vim#cscope#Find('called')<CR>
