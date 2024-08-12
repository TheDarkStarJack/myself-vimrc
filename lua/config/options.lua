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
vim.autochdir = true
