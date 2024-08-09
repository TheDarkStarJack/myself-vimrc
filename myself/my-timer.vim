vim9script
# 定时器
# 定义一个新的高亮组并设置其颜色和样式用于显示提示信息，搭配 echohl 使用。 
# help hi ; help echohl
hi MyEcho ctermfg=red guifg=#ff0000
def EchoRed(context: string)
		echohl MyEcho | echo context | echohl None
enddef

if exists('*MyTimer')
	delfunction MyTimer
endif
def g:MyTimer(timer: number)
	# var now_time = strftime("%Y.%m.%d %H-%M-%S")
	var drink_tea = strftime("%H%M")
	# sleep 5
	if drink_tea >= "1500" && drink_tea <= "1530"
		# echohl MyEcho | echo "三点几咧，饮茶先啦" | echohl None
		# call EchoRed("三点几咧，饮茶先啦")
		# execute ':sleep 1'
		execute ':10echowindow' "'三点几咧，饮茶先啦!!!! 请起来走动一下，狗命要紧'"
	else
		# call EchoRed("你已经持续工作了20分钟了，请起来走动一下，狗命重要")
		# execute ':sleep 1'
		execute ':10echowindow' "'请起来走动一下，狗命要紧'"
	endif
enddef
# 在 vim9script 中函数和变量都不能直接覆盖定义，只能先取消或者采用另一个变量名，
# 否则会提示 E1168: 参数已经在脚本中声明：timer
# repeat 表示循环的次数，如果想无线循环可以取值 -1
var ReminderTime = timer_start(600000, 'g:MyTimer',
			\ {'repeat': -1})
