vim9script
# 十六进制显示文件 
nmap <leader>H :%!xxd<CR>
# 二进制显示文件
nmap <leader>B :%!xxd -r<CR>

# nsert date 定义插入模式下获取日期的缩写 插入模式下输入 xdate之后按空格，即可快速填充日期
iab xdate <c-r>=strftime("%Y.%m.%d")<cr>

# 加载当前的配置文件
# 在 vim9script 中，不能直接使用 def! 覆盖旧的函数，只能删除函数之后重新定义😂
# if exists('*SourceCon')
# 	delfunction SourceCon 
# endif
def SourceCon()
	if &filetype == 'vim'
		execute 'w'
		source %
	endif
enddef

command! SS call SourceCon()

# 定时器
if exists('*MyTimer')
	delfunction MyTimer
endif
def MyTimer(timer: number)
	echo strftime("%Y.%m.%d %H-%M-%S")
enddef
# 在 vim9script 中函数和变量都不能直接覆盖定义，只能先取消或者采用另一个变量名，
# 否则会提示 E1168: 参数已经在脚本中声明：timer
# repeat 表示循环的次数，如果想无线循环可以取值 -1
var ttimer = timer_start(1001, 'MyTimer',
			\ {'repeat': 10})
