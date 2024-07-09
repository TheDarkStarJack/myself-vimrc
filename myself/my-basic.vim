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

"----------------------------------------------------------------------
" 设置 swapfile  自动全屏
"----------------------------------------------------------------------
if has("win32") || has("win64")
    let g:undopath=$HOME . "\\.vim" . "\\undodir"
    if !isdirectory(g:undopath)
        call mkdir(g:undopath, "p")
    endif
        set dir=g:undopath
        set gfn=Inconsolata:h15,Consolas:h14,Lucida_Console:h15,Terminal:h15
        set helplang=cn
        set columns=95
        set lines=10
        set guioptions=mr
        "模拟鼠标点击 alt+x，最大化gvim"
        au GUIEnter * simalt ~x
        if version >= 703
                set undofile undodir=g:undopath
        endif
elseif has ("unix")
    let g:undopath=$$HOME . "/.vim/.undodir"
    if !isdirectory(g:undopath)
        call mkdir(g:undopath, "p")
    endif
        set dir=g:undopath
    set guioptions=mr
        set guifont=Meslo\ LG\ M\ DZ\ 16,DejaVu\ Sans\ Mono\ 16
        if version >= 703
                set undofile undodir=g:undopath
        endif
endif


"----------------------------------------------------------------------
" 设置 gtags环境变量
"----------------------------------------------------------------------
let $GTAGSLABEL = 'native-pygments'
" 实现gtags的多语言支持，必须是绝对路径 https://zhuanlan.zhihu.com/p/36279445
" 下载Windows二进制文件之后，需要将bin所在的目录添加进path中，或者将bin目录移动至系统目录中。
if has("win32") || has("win64")
  let $GTAGSCONF = 'D:\software\Vim\gtags-glo669wb\share\gtags\gtags.conf'
elseif has ("unix")
  " debain
  if exists("/usr/local/share/gtags/gtags.conf")
    let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
   " fedora
  elseif exists("/etc/gtags.conf")
    let $GTAGSCONF = '/etc/gtags.conf'
  endif
endif
