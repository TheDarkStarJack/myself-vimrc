" 写笔记或者脚本的时候方便添加一些头部描述
" ============= blog markdown start
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

function! AddHeader()
	" 获取当前文件名（不包含扩展名）
	let g:filename = expand('%:t:r')
	" 获取当前系统时间
	let g:current_time = strftime('%Y-%m-%d %H:%M:%S')

	if &filetype == 'markdown'
		" 检查文件是否已经有头部
		if getline(1) == '---'
			echo "Header already exists."
			return
		endif

		" 构造文件头部内容
		" 关于日期需要指定 +0800 ，否则 jekyll 在编译的时候会提示
		" _posts/2024-07-19-vim-plug-异常处理.md has a future date
		" 而且编译之后网页显示的日期也不对
		" https://changwh.github.io/2019/03/17/timezone-issue-in-jekyll/
		let g:header = [
					\ '---',
					\ 'title: ' . g:filename,
					\ '#author: DarkStar',
					\ 'date: ' . g:current_time . '+0800',
					\ 'categories: [, ]',
					\ 'tags: []',
					\ 'summary: A brief summary of the document',
					\ 'keywords: [example, documentation, markdown]',
					\ '---',
					\ ''
					\ ]

	elseif &filetype == 'sh'
		" 检查文件是否已经有头部
		if getline(1) == '#!/bin/bash -'
			echo "Header already exists."
			return
		endif

		let g:header = [
					\ '#!/bin/bash -',
					\ '#===============================================================================',
					\ '#',
					\ '#          FILE: ' . g:filename,
					\ '#',
					\ '#         USAGE: ' . g:filename . ' [args1] [args2]',
					\ '#',
					\ '#   DESCRIPTION:.',
					\ '#',
					\ '#       OPTIONS: ---',
					\ '#  REQUIREMENTS: ---',
					\ '#          BUGS: ---',
					\ '#         NOTES: ---',
					\ '#        AUTHOR: wxj (DarkStar), 2403220952@qq.com',
					\ '#  ORGANIZATION:.',
					\ '#       CREATED: ' . g:current_time ,
					\ '#      REVISION:  ---',
					\ '#===============================================================================',
					\ '',
					\ 'set -o nounset                                  # Treat unset variables as an error',
					\ ''
					\]

	endif
	" 将文件头部内容插入到文件开头
	if exists('g:header') && !empty(g:header)
		call append(0, g:header)
	endif
endfunction
" autocmd FileType markdown call AddMarkdownHeader()
nnoremap <silent> <C-m> :call AddHeader()<CR>

" 文件名添加日期前缀 这样新创建文件的时候就不需要在键入日期了
function! SaveWithDate()
    " 获取当前日期
    let l:date = strftime("%Y-%m-%d")
    " 获取文件名（不含扩展名）
    " let l:filename = expand('%:t:r')
    " 获取文件名
    let l:filename = expand('%')
    " 构造新的文件名
    let l:new_filename = l:date . '-' . l:filename
    " 保存文件 使用 rename() 函数重命名文件，write会新建文件，相当于另存为，然
	" 后打开新的文件，再次之前先保存文件否则无法重命名该文件，为防止遗忘保存，
	" 此处先将buffer内的内容写入文件
	execute 'write'
	execute 'call rename(' . '"' . l:filename . '"' . ',' '"'. l:new_filename . '")'
	execute 'e ' . l:new_filename
endfunction
" command 不覆盖已存在的同名命令，会抛出错误，command! 则会覆盖已存在的命令
command SaveWithDate call SaveWithDate()
" ============== blog markdown end
