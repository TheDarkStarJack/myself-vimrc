" => 基础设置 --------------------------------------------------------- {{{1
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

" 开启自动换行
set wrap

" 设置当前行/列高亮
set cursorline
set cursorcolumn

" 处 正常和命令模式之外 禁用鼠标键位避免打字的时候误触碰触摸板，光标乱跑，可以使用滚轮用于翻页
" help mouse
set mouse=nc

" 设置光标距离屏幕边缘的最小行数，在不满足设置的距离时该值无效果
set scrolloff=20
" 折叠
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" 'Config changed' autocmd hook
" autocmd BufWritePost $MYGVIMRC let g:needrestart = 1

" 快速切换pastemode 粘贴模式
set pastetoggle=<C-_>

" 自动显示相对行号, norelativenumber 关闭显示相对行号
autocmd BufRead,BufNewFile * set relativenumber

" 如果有本地gvim配置则加载
if filereadable(expand('~/.vim/.gvimrc.local'))
    source ~/.vim/.gvimrc.local
endif

" 在修改vimrc文件之后自动加载配置
autocmd BufWritePost $MYVIMRC let g:needrestart = 1

" 加载存在特定环境的本地vimrc配置文件
if filereadable(expand('~/.vim/.vimrc.local'))
    source ~/.vim/.vimrc.local
endif

" 自动切换当前目录为文件所在目录
autocmd BufEnter * cd %:p:h


" => 设置 swapfile 和 gvim 打开 自动全屏  --------------------------------------------------------- {{{1
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
	let g:undopath=$HOME . "/.vim/.undodir"
	if !isdirectory(g:undopath)
		call mkdir(g:undopath, "p")
	endif
	set dir=g:undopath
	set guioptions=mr
	" set guifont=Meslo\ LG\ M\ DZ\ 16,DejaVu\ Sans\ Mono\ 16
	if version >= 703
		set undofile undodir=g:undopath
	endif
endif

" => 配置 gtags --------------------------------------------------------- {{{1
"----------------------------------------------------------------------
" 设置 gtags环境变量
"----------------------------------------------------------------------
" Windows 下使用 scoop 安装 gtags 就行，Linux 中直接安装之后就行，只需要指定
" GTAGSLABEL 就行
let $GTAGSLABEL = 'native-pygments'
" " 实现gtags的多语言支持，必须是绝对路径 https://zhuanlan.zhihu.com/p/36279445
" " 下载Windows二进制文件之后，需要将bin所在的目录添加进path中，或者将bin目录移动至系统目录中。
" if has("win32") || has("win64")
"   let $GTAGSCONF = 'D:\software\Vim\gtags-glo669wb\share\gtags\gtags.conf'
" elseif has ("unix")
"   " debain
"   if exists("/usr/local/share/gtags/gtags.conf")
"     let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
"    " fedora
"   elseif exists("/etc/gtags.conf")
"     let $GTAGSCONF = '/etc/gtags.conf'
"   endif
" endif

" => 设置外部终端  --------------------------------------------------------- {{{1
"----------------------------------------------------------------------
" 设置默认调用的外部终端，主要是Windows下默认使用cmd，修改为pwsh。
" Linux下默认都是bash一般不需要修改，有需要在指定。Windows下vim-plugin默认
" 使用的是cmd.exe，如果修改了默认 shell 为 pwsh ，无法正常使用vim-plugin
"----------------------------------------------------------------------
" if has("win32") || has("win64")
" 	set shell=pwsh.exe
" endif

