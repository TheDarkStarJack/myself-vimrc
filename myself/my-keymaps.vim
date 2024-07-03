"----------------------------------------------------------------------
" crtl+数字键 切换tab
"----------------------------------------------------------------------
noremap <silent><c-1> 1gt<cr>
noremap <silent><c-2> 2gt<cr>
noremap <silent><c-3> 3gt<cr>
noremap <silent><c-4> 4gt<cr>
noremap <silent><c-5> 5gt<cr>
noremap <silent><c-6> 6gt<cr>
noremap <silent><c-7> 7gt<cr>
noremap <silent><c-8> 8gt<cr>
noremap <silent><c-9> 9gt<cr>
noremap <silent><c-0> 10gt<cr>

" 映射标签页tab跳转 shift + left/right
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>


"----------------------------------------------------------------------
" 注释
"----------------------------------------------------------------------
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

"----------------------------------------------------------------------
" 复制粘贴
"----------------------------------------------------------------------
" 插入模式向后复制一个单词到系统粘贴板
function! CopyWordToClipboard()
  execute "normal! \<Esc>"
  execute "normal! \"+yiw"
  execute "startinsert"
endfunction
inoremap <C-y> <Esc>:call CopyWordToClipboard()<CR>
inoremap <C-p> <C-r>+ " 将 Ctrl+p 映射为从系统剪贴板粘贴内容
vnoremap <C-y> "+y    " 支持在Visual模式下，通过C-y复制到系统剪切板
nnoremap <C-p> "*p    " 支持在normal模式下，通过C-p粘贴系统剪切板


"----------------------------------------------------------------------
" 插入/删除
"----------------------------------------------------------------------
nnoremap <C-Del> dw  " 向后删除一个单词
nnoremap <C-W> dB    " 向前删除一个单词 （不包括光标位置的字符）

"----------------------------------------------------------------------
" 退出
"----------------------------------------------------------------------
nmap <c-x><c-x> :q<CR>

"----------------------------------------------------------------------
" 翻页
"----------------------------------------------------------------------
nnoremap <Space>d <C-d> " 将翻页crtl+d/f/b组合键修改为 空格 Space+d/f/b
nnoremap <Space>f <C-f>
nnoremap <Space>b <C-b>