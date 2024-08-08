" 十六进制显示文件 
nmap <leader>H :%!xxd<CR>
" 二进制显示文件
nmap <leader>B :%!xxd -r<CR>

" nsert date 定义插入模式下获取日期的缩写 插入模式下输入 xdate之后按空格，即可快速填充日期
iab xdate <c-r>=strftime("%Y.%m.%d")<cr>

" 加载当前的配置文件
" 在 vim9script 中，不能直接使用 def! 覆盖旧的函数，只能删除函数之后重新定义😂
if exists('*SourceCon')
	delfunction SourceCon
endif
function SourceCon()
	if &filetype == 'vim'
		execute 'w'
		source %
	endif
endfunction
command! SS call SourceCon()

