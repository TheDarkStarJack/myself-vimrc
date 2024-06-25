" Add Vim icon to window, where it is shown depends on platform, windowing
" system, X11 server depth, etc etc.
set guioptions+=i

" Automagically yank to windowing system clipboard on visual select.
" This makes gvim behave like a normal unix application.
set guioptions+=a

" 确定vim支持`+clipboard`后，如果想`y/p`直接和系统剪贴板打通，可以在`~/.vimrc`中加上以下配置）
set clipboard^=unnamed,unnamedplus

" 折叠
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" 'Config changed' autocmd hook
autocmd BufWritePost $MYGVIMRC let g:needrestart = 1

" Attempt to source .gvimrc.local for very machine-specific configurations that
" would benefit absolutely no one by being here. Mostly bug workarounds.
if filereadable(expand('~/.gvimrc.local'))
    source ~/.gvimrc.local
endif