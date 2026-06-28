-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- ----------------------------------------------------------------------
-- 编码设置
-- ----------------------------------------------------------------------

if vim.fn.has("multi_byte") == 1 then
  -- 内部工作编码
  vim.o.encoding = "utf-8"

  -- 文件默认编码
  vim.o.fileencoding = "utf-8"

  -- 打开文件时自动尝试下面顺序的编码
  vim.o.fileencodings = "utf-8,ucs-bom,gbk,gb18030,big5,euc-jp,latin1"
end

-- 设置自动换行
vim.opt.wrap = true

-- 设置自动切换目录
vim.opt.autochdir = true
-- 除正常和命令模式之外 禁用鼠标键位避免打字的时候误触碰触摸板，光标乱跑，可以使用滚轮用于翻页 help mouse
vim.opt.mouse = "nc"
-- 设置光标距离屏幕边缘的最小行数，在不满足设置的距离时该值无效果
vim.opt.scrolloff = 20
-- 直接和系统剪贴板打通
vim.opt.clipboard = "unnamed,unnamedplus"

-- 需要将配置写在 init.lua 文件中，不然会被 lazyvim 中的定义覆盖，为了减少修改的地方，直接通过 cmd 执行命令。也可以设置 g:colorscheme 和 lualine
-- 设置 colorscheme
-- vim.cmd([[colorscheme tokyonight-night]])
--
-- 设置行高亮的属性
-- vim.api.nvim_set_hl(0, "CursorLine", { ctermbg = "DarkCyan", bg = "#000000" })

-- -- 设置 shell terminal
-- if jit.os == "Windows" then
--   vim.opt.shell = "powershell.exe"
-- else
--   vim.opt.shell = "bash.exe"
-- end
--
-- 设置 netrw 本地缓存路径，远程编辑的时候正确加载远程文件内容
vim.g.netrw_localrmdir = vim.fn.stdpath("data") .. "/netrw_cache"
-- 设置全局sqlite本地环境变量
-- vim.g.sqlite_clib_path = vim.g.baiduyun .. "\\software\\sqlite3\\sqlite-dll-win-x64-3470200\\sqlite3.dll"
