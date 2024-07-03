set completeopt-=preview
" 自动保存时间
set updatetime=300

set shortmess+=c

" 在窗口中添加 Vim 图标，显示位置取决于平台、窗口系统、X11 服务器深度等。
set guioptions+=i

" 在可视化选择时自动拖动到窗口系统剪贴板。这将使 gvim 的行为与普通 unix 应用程序无异。
set guioptions+=a

" 确定vim支持`+clipboard`后，如果想`y/p`直接和系统剪贴板打通，可以在`~/.vimrc`中加上以下配置）
set clipboard^=unnamed,unnamedplus

" 折叠
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" 'Config changed' autocmd hook
" autocmd BufWritePost $MYGVIMRC let g:needrestart = 1

" 如果有本地gvim配置则加载
if filereadable(expand('~/.gvimrc.local'))
    source ~/.gvimrc.local
endif

" 在修改vimrc文件之后自动加载配置
autocmd BufWritePost $MYVIMRC let g:needrestart = 1

" 加载存在特定环境的本地vimrc配置文件
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

" 自动切换当前目录为文件所在目录
autocmd BufEnter * cd %:p:h

