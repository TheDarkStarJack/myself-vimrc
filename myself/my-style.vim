vim9script
# 插入模式在状态栏下面显示 -- INSERT --，echodoc 插件 ./init/init-plugins.vim:409 关闭了改参数，默认为真
# set showmode
# 设置主题
set background=dark
# set background=light " for the light version
colorscheme one
# => 高亮组设置  --------------------------------------------------------- {{{1
# 高亮组设置
# 定义一个新的高亮组并设置其颜色和样式用于显示提示信息，搭配 echohl 使用。 
# help hi ; help echohl
hi MyEcho ctermfg=red guifg=#ff0000
# highlight CursorLine   cterm=NONE ctermbg=black ctermfg=green guibg=#008b8b  guifg=NONE
# highlight CursorColumn cterm=NONE ctermbg=black ctermfg=green guibg=#8b0000 guifg=NONE
highlight CursorLine ctermbg=DarkCyan guibg=#000000
# highlight CursorColumn ctermbg=DarkRed guibg=#8b0000

export def MyEcho(context: string)
	echohl MyEcho | echo a:context | echohl None
enddef

# => 帮助手册右侧显示 --------------------------------------------------------- {{{1
# 默认是水平分割上下两个窗口显示帮助手册，不太喜欢这种风格，修改为垂直分割在右
# 侧显示帮助手册信息
autocmd FileType help wincmd L

