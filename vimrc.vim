" => 基础设置 --------------------------------------------------------- {{{1
" global options  nocompatible 表示禁用与vi的兼容性，避免一些问题
set nocompatible hidden number
" 设置不换行
"set nowrap 
set wrap

set lazyredraw ttyfast wildmenu

set expandtab smarttab tabstop=4 softtabstop=4

set shiftwidth=4 shiftround

"set textwidth=80 cc=+1
set smartindent autochdir
"set autoindent list mousehide

set matchpairs+=<:>

" 设置 tags：当前文件所在目录往上向根目录搜索直到碰到 .tags 文件
" 或者 Vim 当前目录包含 .tags 文件
set tags=./.tags;,.tags

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m

" 合并两行中文时，不在中间加空格
set formatoptions+=B

" 文件换行符，默认使用 unix 换行符
set ffs=unix,dos,mac

set completeopt-=preview

" 自动保存时间
set updatetime=300
" 设置自动补全
set completeopt-=preview

" 打开 C/C++ 语言缩进优化
set cindent

" Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
set winaltkeys=no

" 设置 Backspace 键模式
set bs=eol,start,indent

" 搜索时忽略大小写
set ignorecase

" 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写字母
set smartcase

" 高亮搜索内容
set hlsearch

" 查找输入时动态增量显示查找结果
set incsearch

" 打开功能键超时检测（终端下功能键为一串 ESC 开头的字符串）
set ttimeout

" 功能键超时检测 50 毫秒
set ttimeoutlen=50

" 显示光标位置
set ruler

" 设置tab和空格样式
set list listchars=nbsp:%,tab:\|\ ,extends:»,precedes:«,trail:-

" Lines folding
set foldenable foldmethod=marker foldnestmax=1 " foldlevelstart=1

"Set backspace
set backspace=start,indent

"Set loaded file encodings
set fileencodings=ucs-bom,utf-8,enc-cn,cp936,default,latin1

" 有的低版本没有这两个参数，需要判断一下，懒得查版本了，直接判断是否存在变量
if has('shortmess')
  set shortmess+=c
endif

if has('signcolumn')
  if has("patch-8.1.1564")
    set signcolumn=number
  else
    set signcolumn=yes
  endif
endif

"----------------------------------------------------------------------
" 编码设置
"----------------------------------------------------------------------
if has('multi_byte')
  " 内部工作编码
  set encoding=utf-8

  " 文件默认编码
  set fileencoding=utf-8

  " 打开文件时自动尝试下面顺序的编码
  set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1
endif


"----------------------------------------------------------------------
" 允许 Vim 自带脚本根据文件类型自动设置缩进等
"----------------------------------------------------------------------
if has('autocmd')
  filetype plugin indent on
endif


"----------------------------------------------------------------------
" 语法高亮设置
"----------------------------------------------------------------------
if has('syntax')  
  syntax enable 
  syntax on 
endif


"----------------------------------------------------------------------
" 其他设置
"----------------------------------------------------------------------

" 显示匹配的括号
set showmatch

" 显示括号匹配的时间
set matchtime=2

" 显示最后一行
set display=lastline

" 允许下方显示目录
set wildmenu

" 延迟绘制（提升性能）
set lazyredraw

" 错误格式
set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m

" 设置分隔符可视
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<

" 确定vim支持`+clipboard`后，如果想`y/p`直接和系统剪贴板打通，可以在`~/.vimrc`中加上以下配置）
set clipboard^=unnamed,unnamedplus
" highlight CursorLine ctermbg=DarkCyan guibg=#000000
" 设置光标显示
" Highlight cursor line underneath the cursor horizontally. 水平光标
set cursorline
" Highlight cursor line underneath the cursor vertically. 垂直光标
" set cursorcolumn

" Disable compatibility with vi which can cause unexpected issues.
" set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
" filetype on

" Enable plugins and load plugin for the detected file type.
" filetype plugin on

" Load an indent file for the detected file type.
" filetype indent on
" filetype启用类型文件检测。 Vim 将能够尝试检测正在使用的文件类型。
filetype plugin indent on


set background=dark
colorscheme darkblue
syntax enable

"----------------------------------------------------------------------
" 设置代码折叠
"----------------------------------------------------------------------
if has('folding')
  " 允许代码折叠
  set foldenable

  " 代码折叠默认使用缩进
  set fdm=indent

  " 默认打开所有缩进
  set foldlevel=99
endif


"----------------------------------------------------------------------
" 文件搜索和补全时忽略下面扩展名
"----------------------------------------------------------------------
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class

set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz    " MacOSX/Linux
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android

" => 鼠标设置 --------------------------------------------------------- {{{1
" 开启鼠标 支持vim配置中开启鼠标支持，.vimrc文件中加上
if has('mouse')
  set mouse-=a
endif


" => 色彩和风格 --------------------------------------------------------- {{{1
if &term =~ "xterm-256color" || &term =~ "screen-256color" || &term =~ "screen"
  " enable 256-color mode
  let &t_Co=256
  let &t_AF="\e[38;5;%dm"
  let &t_AB="\e[48;5;%dm"
  hi Normal ctermbg=none
endif

"set default guifont and swapfile
if has("win32") || has("win64")
  if !isdirectory($HOME . "\\.undodir")
    call mkdir($HOME . "\\.undodir")
  endif
  set dir=$HOME\\.undodir
  set gfn=Inconsolata:h15,Consolas:h14,Lucida_Console:h15,Terminal:h15
  set helplang=cn
  set columns=95
  set lines=10
  set guioptions=mr
  "模拟鼠标点击 alt+x，最大化gvim"
  au GUIEnter * simalt ~x
  if version >= 703
    set undofile undodir=$HOME\\.undodir
  endif
elseif has ("unix")
  if !isdirectory($HOME . "/.vim/.undodir")
    call mkdir($HOME . "/.vim/.undodir", "p")
  endif
  set dir=$HOME/.vim/.undodir
  set guioptions=mr
  set guifont=Meslo\ LG\ M\ DZ\ 16,DejaVu\ Sans\ Mono\ 16
  if version >= 703
    set undofile undodir=$HOME/.vim/.undodir
  endif
endif

if has("gui_running")
  " Add Vim icon to window, where it is shown depends on platform, windowing
  " system, X11 server depth, etc etc.
  set guioptions+=i

  " Automagically yank to windowing system clipboard on visual select.
  " This makes gvim behave like a normal unix application.
  set guioptions+=a
endif

" 配合mintty，在INSERT模式和NORMAL模式下显示不同的光标
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"


"在 Vim 窗口底部显示一个永久状态栏，可以显示文件名、行号和列号等内容：
set laststatus=2

"----------------------------------------------------------------------
" 状态栏设置
"----------------------------------------------------------------------
set statusline=                                 " 清空状态了
set statusline+=\ %F                            " 文件名
set statusline+=\ [%1*%M%*%n%R%H]               " buffer 编号和状态
set statusline+=%=                              " 向右对齐
set statusline+=\ %y                            " 文件类型

" 最右边显示文件编码和行号等信息，并且固定在一个 group 中，优先占位
set statusline+=\ %0(%{&fileformat}\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %v:%l/%L%)

" 设置了窗口顶部和底部的最小行数，这些行数在光标滚动时保持未被占用。当你的光标移动到这个区域内时，Vim 会自动滚动屏幕。 如果设置了 nowrap 则scrolloff没有效果
set scrolloff=20

let g:lightline = {'colorscheme': 'wombat'}
" 保存的时候自动格式化
let g:autofmt_autosave = 1
" 水平切割窗口时，默认在右边显示新窗口
set splitright

" 允许 256 色
set t_Co=256

" => 复制粘贴 --------------------------------------------------------- {{{1
"Set paste mode toggle key 设置粘贴模式切换键
" set pastetoggle=<leader>p
" 快速切换pastemode 粘贴模式
set pastetoggle=<C-_>

" 将 Ctrl+shit+v 映射为从系统剪贴板粘贴内容
"inoremap <C-V> <C-r>+

" nnoremap ' `
" nnoremap ` '
" nnoremap ,yw yiww
" nnoremap ,ow "_diwhp

" => 移动 --------------------------------------------------------- {{{1
"命令行模式下 快速跳转行尾行首 删除字符
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
"cnoremap <C-k> <C-U>
"插入模式下 快速跳转行尾行首 删除字符
inoremap <C-a> <Home>
inoremap <C-e> <End>

"inoremap <C-K> <C-U>
" vnoremap <C-y> "+y   "支持在Visual模式下，通过C-y复制到系统剪切板
" nnoremap <C-p> "*p   "支持在normal模式下，通过C-p粘贴系统剪切板
" vnoremap y "+y   "支持在Visual模式下，通过y复制到系统剪切板
" nnoremap p "*p   "支持在normal模式下，通过p粘贴系统剪切板
" vnoremap < <gv
" vnoremap > >gv


" => 其他键位映射 --------------------------------------------------------- {{{1

nnoremap q :q<CR>
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
nnoremap <Space>d <C-d> " 将翻页crtl+d/f/b组合键修改为 空格 Space+d/f/b
nnoremap <Space>f <C-f>
nnoremap <Space>b <C-b>
nnoremap <Space>u <C-u>
" Ctrl+s 保存文件
nnoremap <C-s> :w<CR>


" 自动补全 单引号、双引号、括号 。在没有插件的时候可以开启设置
inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
" Ctrl+s 保存文件
inoremap <C-s> <Esc>:w<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" 注释
inoremap <C-l> <Esc>0i## <Esc>j$a " 注释当前行
function! CommentLines()
  let commentString = '## '
  let line = getline('.')
  if strpart(line, 0, strlen(commentString)) == commentString
    execute 's/^' . commentString . '//'
  else
    execute 's/^/' . commentString . '/'
  endif
endfunction

vnoremap <C-l> :call CommentLines()<CR> " 调用注释
nnoremap <C-l> :call CommentLines()<CR> " 调用注释


" => 宏定义/快捷操作 --------------------------------------------------------- {{{1

" insert date 定义插入模式下获取日期的缩写 插入模式下输入 xdate之后按空格，即可快速填充日期
iab xdate <c-r>=strftime("%Y.%m.%d")<cr>
"十六进制显示文件 
nmap <leader>H :%!xxd<CR>
"二进制显示文件
nmap <leader>B :%!xxd -r<CR>

" => autocmd --------------------------------------------------------- {{{1
" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif


" 折叠
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 在修改vimrc文件之后自动加载配置
autocmd BufWritePost $MYVIMRC let g:needrestart = 1

" 加载存在特定环境的本地vimrc配置文件
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" Change work dir to current dir
autocmd BufEnter * cd %:p:h

" 自动显示相对行号, norelativenumber 关闭显示相对行号
autocmd BufRead,BufNewFile * set relativenumber

" 帮助手册右侧显示
autocmd FileType help wincmd L

" 自动切换当前目录为文件所在目录
autocmd BufEnter * cd %:p:h

" => 标签设置 --------------------------------------------------------- {{{1

set tabline=%!MyTabLine()

function! MyTabLine()
  let s = ''
  for i in range(1, tabpagenr('$'))
    " 获取每个标签页的名字
    let buflist = tabpagebuflist(i)
    let winnr = tabpagewinnr(i)
    let bufname = bufname(buflist[winnr - 1])
    let filename = fnamemodify(bufname, ':t')
    
    " 如果文件名为空，显示 "Untitled"
    if empty(filename)
      let filename = 'Untitled'
    endif

    " 拼接标签页的编号和文件名
    let s .= '%' . i . 'T' " Tab 页跳转
    let s .= (i == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    " 显示标签页编号
    let s .= ' ' . i . ':'
    let s .= filename
    let s .= ' %T'
  endfor
  let s .= '%#TabLineFill#'
  return s
endfunction

" 映射标签页跳转 shift + left/right
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>

" crtl+数字键 切换tab， 有的终端不能正确解析 Ctrl 或者解析发送的 assic
" 不同导致不能正确解析 CTRL 组合键切换标签页。
" 或者是键位已经被使用的终端工具占用导致无法切换标签页，可以使用上面配置的
" shit 切换标签页
nnoremap <silent><C-1> 1gt<CR>
nnoremap <silent><C-2> 2gt<CR>
nnoremap <silent><C-3> 3gt<CR>
nnoremap <silent><C-4> 4gt<CR>
nnoremap <silent><C-5> 5gt<CR>
nnoremap <silent><C-6> 6gt<CR>
nnoremap <silent><C-7> 7gt<CR>
nnoremap <silent><C-8> 8gt<CR>
nnoremap <silent><C-9> :tablast<CR>

" ctrl + n 新建标签页
inoremap <silent><C-n> <Esc>:tabnew<CR>
nnoremap <silent><C-n> :tabnew<CR>

" => 窗口 window 设置 --------------------------------------------------------- {{{1
nnoremap <M-h> <C-w>h
nnoremap <M-l> <C-w>l
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
inoremap <M-h> <esc><C-w>h
inoremap <M-l> <esc><C-w>l
inoremap <M-j> <esc><C-w>j
inoremap <M-k> <esc><C-w>k

" => 设置结束 --------------------------------------------------------- {{{1
