if exists('b:did_spacevim_cs_ftplugin') || !spacevim#load('csharp')
  finish
endif
let b:did_spacevim_cs_ftplugin = 1

let b:ale_linters = ['OmniSharp']

compiler dotnet

if spacevim#load('lightline')
  "b:lightline didn't work, g:lightline does
  "Maybe direct to a function based on filetype?
  let g:lightline['component'] = {
  \	'sharpenup': sharpenup#statusline#Build()
  \}

  augroup setupOmniSharpLightlineIntegration
    autocmd!
    autocmd User OmniSharpProjectUpdated,OmniSharpReady call lightline#update()
  augroup END
endif

" [re]defines :Make command, with autocomplete to a csproj in the sln
command! -bang -nargs=* -bar -complete=custom,s:DotNetFileComplete Make AsyncRun -program=make @ <args>

" Find relevant .csproj files to populate autocomplete list
" See `:help command-completion-custom`
function! s:DotNetFileComplete(A,L,P)
  let searchdir = expand('%:.:h')
  let matches = ''
  " If we're not relative to the cwd (e.g. in :help), don't try to search
  if fnamemodify(searchdir,':p:h') !=? searchdir
    let host = OmniSharp#GetHost(bufnr('%'))
    let csprojs = deepcopy(host.job.projects)
    let csprojs_relative = map(csprojs, {index, value -> fnamemodify(value['path'], ':.')})
    if has_key(host, 'project')
      " Make the first project this file is in first in the sln list
      let project = fnamemodify(host['project']['MsBuildProject']['Path'], ':.')
      let i = index(csprojs_relative, project)
      call remove(csprojs_relative, i)
      let matches = join(insert(csprojs_relative, project), "\n")
    else
      let matches = join(csprojs_relative, "\n")
    endif
  endif
  return matches
endfunction

command! -buffer -bar OmniSharpBuildProject call s:OmniSharpBuildProject()
command! -buffer -bar OmniSharpBuildSolution call s:OmniSharpBuildSolution()
nnoremap <buffer> <Plug>(omnisharp_build_project) :OmniSharpBuildProject<CR>
nnoremap <buffer> <Plug>(omnisharp_build_solution) :OmniSharpBuildSolution<CR>

function! s:OmniSharpBuildProject() abort
  let host = OmniSharp#GetHost(bufnr('%'))
  let CsprojF = {->fnamemodify(host['project']['MsBuildProject']['Path'], ':.')}
  if has_key(host, 'project')
    call execute('Make '.CsprojF())
  else
    call OmniSharp#actions#project#Get(bufnr('%'), { -> execute('Make '.CsprojF()) })
  endif
endfunction

function! s:OmniSharpBuildSolution() abort
  let sln = OmniSharp#GetHost(bufnr('%')).sln_or_dir
  call execute('Make '.sln)
endfunction
