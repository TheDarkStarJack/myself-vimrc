"十六进制显示文件 
nmap <leader>H :%!xxd<CR>
"二进制显示文件
nmap <leader>B :%!xxd -r<CR>

" insert date 定义插入模式下获取日期的缩写 插入模式下输入 xdate之后按空格，即可快速填充日期
iab xdate <c-r>=strftime("%Y.%m.%d")<cr>

" ============= markdown start
" 编辑 markdown 博客的时候自动插入头部的注释信息
" function! AddMarkdownHeader()
" 	if &filetype == 'markdown'
" 		" 获取当前文件名（不包含扩展名）
" 		let filename = expand('%:t:r')
" 		" 获取当前系统时间
" 		let current_time = strftime('%Y-%m-%d %H:%M:%S')
" 		" 构造文件头部内容
" 		let header = "---\n" "title: " . filename . "\n" "author: DarkStar\n" "date: " . current_time . "\n" "categories: [linux, Tutorial]\n" "tags: [linux]\n" "---\n"
" 		" 将文件头部内容插入到文件开头
" 		call setline(1, append(getline(1, 1), header))
" 	endif
" endfunction

function! AddMarkdownHeader()
    if &filetype == 'markdown'
        " 获取当前文件名（不包含扩展名）
        let filename = expand('%:t:r')
        " 获取当前系统时间
        let current_time = strftime('%Y-%m-%d %H:%M:%S')
        
        " 检查文件是否已经有头部
        if getline(1) == '---'
            echo "Header already exists."
            return
        endif
        
        " 构造文件头部内容
        let header = [
        \ '---',
        \ 'title: ' . filename,
        \ '#author: DarkStar',
        \ 'date: ' . current_time,
        \ 'categories: [Linux, Tutorial]',
        \ 'tags: [Linux]',
        \ 'summary: A brief summary of the document',
        \ 'keywords: [example, documentation, markdown]',
        \ '---',
        \ ''
        \ ]

        " 将文件头部内容插入到文件开头
        call append(0, header)
    endif
endfunction
" autocmd FileType markdown call AddMarkdownHeader()
nnoremap <C-m> :call AddMarkdownHeader()<CR>
" ============== markdown end
