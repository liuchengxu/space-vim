" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'
let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_serverStderr = '/tmp/LanguageServer.log'

let g:LanguageClient_serverCommands = {
      \ 'c': ['ccls.debug'],
      \ 'cpp': ['ccls.debug'],
      \ 'objc': ['ccls.debug'],
      \ 'go': ['go-langserver', '-gocodecompletion', '-func-snippet-enabled', '-logfile=/tmp/gols.log'],
      \ 'python': ['pyls', '--log-file=/tmp/pyls.log'],
      \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
      \ 'sh': ['bash-language-server', 'start'],
      \ 'typescript': ['javascript-typescript-stdio'],
      \ 'javascript': ['javascript-typescript-stdio'],
      \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
      \ }

" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
