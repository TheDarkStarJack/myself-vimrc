"----------------------------------------------------------------------
" crtl+数字键 切换tab
"----------------------------------------------------------------------
" noremap <silent><c-1> 1gt<cr>
" noremap <silent><c-2> 2gt<cr>
" noremap <silent><c-3> 3gt<cr>
" noremap <silent><c-4> 4gt<cr>
" noremap <silent><c-5> 5gt<cr>
" noremap <silent><c-6> 6gt<cr>
" noremap <silent><c-7> 7gt<cr>
" noremap <silent><c-8> 8gt<cr>
" " 跳转最后一个标签页
inoremap <silent><m-9> <Esc>:$tabn<cr>
nnoremap <silent><m-9> $tabn<cr>

" 映射标签页tab跳转 shift + left/right
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>

"----------------------------------------------------------------------
" crtl+n 新建tab
"----------------------------------------------------------------------
inoremap <silent><C-n> <Esc>:tabnew<CR>
nnoremap <silent><C-n> :tabnew<CR>

"----------------------------------------------------------------------
" 注释
"----------------------------------------------------------------------
" 注释当前行
inoremap <C-l> <Esc>0i## <Esc>j$a 

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
inoremap <M-c> <Esc>:call CopyWordToClipboard()<CR>
" 映射为从系统剪贴板粘贴内容
inoremap <M-v> <C-r>+
" 支持在Visual模式下，复制到系统剪切板
vnoremap <M-c> "+y 
" 支持在normal模式下，通过alt+v粘贴系统剪切板
nnoremap <M-v> "+p
" 映射命令行模式下的 ALT+V 为粘贴系统剪贴板内容
cnoremap <M-v> <C-r>+

"----------------------------------------------------------------------
" 插入/删除
"----------------------------------------------------------------------
" 向后删除一个单词
nnoremap <C-Del> dw 
" 插入模式下删除当前或后一个单词
inoremap <C-d>  <Esc>dawa
" 向前删除一个单词 （不包括光标位置的字符）
nnoremap <C-w> dB   
" 向后删除至末尾
inoremap <C-x> <C-o>D
"----------------------------------------------------------------------
" 文件退出/保存
"----------------------------------------------------------------------
" 退出
noremap q :q<CR>
" 保存文件
nnoremap <C-s> <Esc>:w<CR>
inoremap <C-s> <Esc>:w<CR>

"----------------------------------------------------------------------
" 翻页
"----------------------------------------------------------------------
" 将翻页crtl+d/f/b组合键修改为 空格 Space+d/f/b
nnoremap <Space>d <C-d> 
nnoremap <Space>f <C-f>
nnoremap <Space>b <C-b>
