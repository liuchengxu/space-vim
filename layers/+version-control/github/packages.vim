MP 'junegunn/vim-github-dashboard', { 'on_cmd': ['GHDashboard', 'GHActivity'] }
MP 'mattn/webapi-vim',              { 'lazy': 1 }
MP 'mattn/gist-vim',                { 'on_cmd': 'Gist',
  \ 'hook_post_source': 'call dein#source(\"webapi-vim\")' }
