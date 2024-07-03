"十六进制显示文件 
nmap <leader>H :%!xxd<CR>
"二进制显示文件
nmap <leader>B :%!xxd -r<CR>

" insert date 定义插入模式下获取日期的缩写 插入模式下输入 xdate之后按空格，即可快速填充日期
iab xdate <c-r>=strftime("%Y.%m.%d")<cr>
