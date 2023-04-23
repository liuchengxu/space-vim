MP 'rdnetto/YCM-Generator',  {
  \ 'on_cmd': ['YcmGenerateConfig', 'CCGenerateConfig'],
  \ 'rev': 'stable' }

MP 'ycm-core/YouCompleteMe', {
  \ 'hook_post_update': function('spacevim#plug#youcompleteme#build'),
  \ 'on_event': ['CursorHold', 'CursorHoldI', 'InsertEnter'], 'lazy': 1,
  \ 'hook_source': function('spacevim#autocmd#youcompleteme#Init') }
