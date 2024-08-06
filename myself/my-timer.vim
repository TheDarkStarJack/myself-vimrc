vim9script
# 定时器
if exists('*MyTimer')
	delfunction MyTimer
endif
def MyTimer(timer: number)
	# var now_time = strftime("%Y.%m.%d %H-%M-%S")
	var drink_tea = strftime("%H%M%S")
	# sleep 5
	if drink_tea == "150000" 
		# echohl MyEcho | echo "三点几咧，饮茶先啦" | echohl None
		call MyEcho("三点几咧，饮茶先啦")
	else
		call MyEcho("你已经持续工作了30分钟了，请起来走动一下，狗命重要")
	endif
enddef
# 在 vim9script 中函数和变量都不能直接覆盖定义，只能先取消或者采用另一个变量名，
# 否则会提示 E1168: 参数已经在脚本中声明：timer
# repeat 表示循环的次数，如果想无线循环可以取值 -1
var ReminderTime = timer_start(600000, 'MyTimer',
			\ {'repeat': -1})
