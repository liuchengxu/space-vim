execute 'source '.fnamemodify(expand('<sfile>'), ':h').'/native-dependency.vim'

let location = spacevim#vim#plug#LocateDependency('node')
if location[0] ==# 'none'
  call spacevim#util#warn('nodejs layer failure, try ":call dein#get('.
    \ '"node").hook_post_update()" to build as plugin, or set $NODE/'.
    \ '$PATH to existing build, or install system-wide with version >= '.
    \ join(g:spacevim#vim#plug#native_dependency['node'].v_req, '.').'.')
else
  " Don't install devDependencies on `npm install`
  let $NODE_ENV = 'production'
  let f = expand(g:spacevim.state_base.'/node_npm_configured_v'.location[1][0].'.'.location[1][1])
  if location[0] ==# 'plugin' && !filereadable(f)
    " npm install packages into {prefix}/lib/node_modules
    call system('npm config set location global')
    " node-gpy needs to know where headers are
    call system('npm config set nodedir '.fnamemodify(location[2], ':h'))
    call writefile([], f, 'S')
  endif
endif
