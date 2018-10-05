" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'
let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_serverStderr = '/tmp/LanguageServer.log'
let g:LanguageClient_settingsPath = expand('~/.space-vim/layers/+tools/lsp/settings.json')

let g:LanguageClient_serverCommands = {
      \ 'c': ['ccls', '--log-file=/tmp/cq.log'],
      \ 'cpp': ['ccls', '--log-file=/tmp/cq.log'],
      \ 'objc': ['ccls'],
      \ 'go': ['go-langserver', '-gocodecompletion', '-func-snippet-enabled', '-logfile=/tmp/gols.log'],
      \ 'python': ['pyls', '--log-file=/tmp/pyls.log'],
      \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
      \ 'sh': ['bash-language-server', 'start'],
      \ 'typescript': ['javascript-typescript-stdio'],
      \ 'javascript': ['javascript-typescript-stdio'],
      \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
      \ 'haskell': ['hie-wrapper', '--lsp', '-r', spacevim#util#RootDirectory()],
      \ }

let g:LanguageClient_rootMarkers = {
       \ 'haskell': ['*.cabal', 'stack.yaml']
       \ }

let g:LanguageClient_diagnosticsDisplay =
\    {
\        1: {
\            "name": "Error",
\            "texthl": "Error",
\            "signText": "✖",
\            "signTexthl": "ErrorMsg",
\        },
\        2: {
\            "name": "Warning",
\            "texthl": "Warning",
\            "signText": "⚠",
\            "signTexthl": "WarningMsg",
\        },
\        3: {
\            "name": "Information",
\            "texthl": "Type",
\            "signText": "ℹ",
\            "signTexthl": "Type",
\        },
\        4: {
\            "name": "Hint",
\            "texthl": "String",
\            "signText": "➤",
\            "signTexthl": "String",
\        },
\    }

" Or map each action separately
nnoremap <silent> gd :call spacevim#lang#util#GotoDefinition()<CR>
