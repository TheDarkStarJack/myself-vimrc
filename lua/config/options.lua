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
  vim.o.fileencodings = "ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1"
end

-- 设置自动换行
vim.opt.wrap = true

-- 设置自动切换目录
vim.opt.autochdir = true
-- 处 正常和命令模式之外 禁用鼠标键位避免打字的时候误触碰触摸板，光标乱跑，可以使用滚轮用于翻页 help mouse
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
