vim9script
# 主要是方便个人切换一些配置和路径的配置，主要是在 Windows 下方便和 WSl 做一些
# 交互

# 进入个人博客/笔记的目录
def CdBlogDir()
	const blogdir = '\\wsl.localhost\\Fedora39\\data\\myself-blog\\_posts'
	# 在 vim9script execute 命令中，不需要使用 . 连接操作符来连接 'cd' 和 blogdir。
	execute 'cd '  blogdir  
enddef

command! CdBlogDir call CdBlogDir()

def CdOneDrive()
	const OneDrive = 'D:\OneDrive\笔记'
	execute 'cd ' OneDrive
enddef

command! CdOneDrive call CdOneDrive()

def CdVimCon()
	var VimCon = '~/.vim/vim-init/'
	execute 'cd ' VimCon
enddef

command! CdVimCon call CdVimCon()
