
 " 在修改vimrc文件之后自动加载配置
 autocmd BufWritePost $MYGVIMRC let g:needrestart = 1

 " 加载存在特定环境的本地vimrc配置文件
 if filereadable(expand('~/.gvimrc.local'))
     source ~/.gvimrc.local
 endif
