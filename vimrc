" global options  nocompatible 表示禁用与vi的兼容性，避免一些问题
set nocompatible hidden number  ruler
" 设置不换行
"set nowrap 
set wrap
set lazyredraw ttyfast wildmenu
set ignorecase smartcase incsearch hlsearch
set expandtab smarttab tabstop=4 softtabstop=4
set shiftwidth=4 shiftround
"set textwidth=80 cc=+1
set smartindent autochdir
"set autoindent list mousehide
set matchpairs+=<:>
set tags=tags;
set completeopt-=preview
set updatetime=300
set shortmess+=c

" 开启鼠标 支持vim配置中开启鼠标支持，.vimrc文件中加上
if has('mouse')
    set mouse-=a
endif

" 设置tab和空格样式
set list listchars=nbsp:%,tab:\|\ ,extends:»,precedes:«,trail:-

" Lines folding
set foldenable foldmethod=marker foldnestmax=1 " foldlevelstart=1

"Set backspace
set backspace=start,indent

"Set loaded file encodings
set fileencodings=ucs-bom,utf-8,enc-cn,cp936,default,latin1

if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif


" Load an indent file for the detected file type.
" filetype indent on
" filetype启用类型文件检测。 Vim 将能够尝试检测正在使用的文件类型。
filetype plugin indent on


call plug#begin('~/.vim_plugged') " 括号内表示vim_plugged安装插件的目录
    " color theme
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'tlhr/anderson.vim'
    Plug 'morhetz/gruvbox'
    Plug 'nanotech/jellybeans.vim'
    Plug 'joshdick/onedark.vim'
    Plug 'rakr/vim-one'

    "Plug 'jlanzarotta/bufexplorer'
    Plug 'vim-scripts/matchit.zip'
    Plug 'scrooloose/nerdcommenter'
    Plug 'tpope/vim-surround'
    "Plug 'ctrlpvim/ctrlp.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'tpope/vim-repeat'
    Plug 'majutsushi/tagbar'
    Plug 'mbbill/fencview'
    Plug 'tpope/vim-abolish'
    " shell check
    Plug 'dense-analysis/ale'
    " buffer代码缩略图
    "Plug 'itchyny/thumbnail.vim'

    "Plug 'posva/vim-vue' , { 'for': 'vue' }
    "Plug 'chr4/nginx.vim', { 'for': 'nginx' }
    ""Plug 'fatih/vim-go', { 'for': 'go' }
    "Plug 'cespare/vim-toml', { 'for': 'toml' }
    "Plug 'rust-lang/rust.vim', { 'for': 'rust' }
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
    Plug 'junegunn/vim-easy-align'

    " Any valid git URL is allowed
    Plug 'https://github.com/junegunn/vim-github-dashboard.git'

    " Multiple Plug commands can be written in a single line using | separators
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

    " On-demand loading
    Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

    " Using a non-default branch
    Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

    " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
    Plug 'fatih/vim-go', { 'tag': '*' }

    " Plugin options
    "Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

    " Plugin outside ~/.vim/plugged with post-update hook
    Plug 'junegunn/fzf', { 'do': './install --all' }

    " Unmanaged plugin (manually installed and updated)
    Plug '~/my-prototype-plugin'
    " LeaderF 模糊查找插件
    Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
    " Initialize plugin system
    " - Automatically executes `filetype plugin indent on` and `syntax enable`.

    " 安装Airline，美化状态栏
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " 安装vim-gutentags
    Plug 'ludovicchabant/vim-gutentags'
    " 安装LeaderF
    " Plug 'Yggdroot/LeaderF'
    " 嵌套括号提示"
    Plug 'briangwaltney/paren-hint.nvim'
call plug#end()

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


" Gutentags : update tags database automatically
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 指定tag文件保存路径为~/.tags/
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_modules = []
if executable('gtags-cscope') && executable('gtags')
let g:gutentags_modules += ['gtags_cscope']
endif
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" Vim打开后自动连接cscope数据库。当同一Vim打开多个project时易发生冲突
let g:gutentags_auto_add_gtags_cscope = 1

" cscope快捷键
noremap <silent> <leader>s :cs f s <C-R><C-W><cr>
noremap <silent> <leader>g :cs f g <C-R><C-W><cr>
noremap <silent> <leader>c :cs f c <C-R><C-W><cr>

set background=dark
colorscheme PaperColor
"colorscheme gruvbox 开启语法高亮
syntax enable

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


"Set paste mode toggle key 设置粘贴模式切换键
set pastetoggle=<leader>p

nnoremap ' `
nnoremap ` '
nnoremap ,yw yiww
nnoremap ,ow "_diwhp

noremap <leader>fe :set fileencoding=utf-8
noremap <leader>s :set wrap!<CR>
noremap <leader>n :set number!<CR>
noremap <leader>ac :set autochdir!<CR>
nnoremap <leader>t :TagbarToggle<CR>
nnoremap <leader>z :b#<CR>
noremap <leader>/ :nohlsearch<CR>
nmap <leader>be :CocList buffers<CR>
nmap <leader><leader>m :CocList mru<CR>
nmap <leader><leader>x :%s/\s\+$//g<CR>
"命令行模式下 快速跳转行尾行首 删除字符
cnoremap <C-A> <Home>
cnoremap <C-e> <End>
cnoremap <C-K> <C-U>
"插入模式下 快速跳转行尾行首 删除字符
inoremap <C-A> <Home>
inoremap <C-e> <End>
" Ctrl+k 通常用于输入特殊字符或者是 digraphs（双字符组合） 考虑之后还是不做映射了
"inoremap <C-K> <C-U>
nmap <c-x><c-x> :q<CR>
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
" vnoremap <C-y> "+y   "支持在Visual模式下，通过C-y复制到系统剪切板
" nnoremap <C-p> "*p   "支持在normal模式下，通过C-p粘贴系统剪切板

" insert date 定义插入模式下获取日期的缩写 插入模式下输入 xdate之后按空格，即可快速填充日期
iab xdate <c-r>=strftime("%Y.%m.%d")<cr>

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

let g:lightline = {'colorscheme': 'wombat'}
let g:autofmt_autosave = 1


" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ s:check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" 设置光标显示
" Highlight cursor line underneath the cursor horizontally. 水平光标
" set cursorline
" Highlight cursor line underneath the cursor vertically. 垂直光标
" set cursorcolumn

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" 配合mintty，在INSERT模式和NORMAL模式下显示不同的光标
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

"十六进制显示文件 
nmap <leader>H :%!xxd<CR>
"二进制显示文件
nmap <leader>B :%!xxd -r<CR>

imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
"在 Vim 窗口底部显示一个永久状态栏，可以显示文件名、行号和列号等内容：
set laststatus=2
" 设置了窗口顶部和底部的最小行数，这些行数在光标滚动时保持未被占用。当你的光标移动到这个区域内时，Vim 会自动滚动屏幕。 如果设置了 nowrap 则scrolloff没有效果
"set scrolloff=3
