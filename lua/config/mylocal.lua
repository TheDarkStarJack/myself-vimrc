-- 主要是记录一些个人配置和路径，主要是在 Windows 下方便和 WSL 做一些交互

-- 进入个人博客/笔记的目录
local function cd_blog_dir()
  local blogdir = "\\\\wsl.localhost\\Fedora39\\data\\myself-blog\\_posts"
  vim.cmd("cd " .. blogdir)
end

-- 创建 CdBlogDir 命令
vim.api.nvim_create_user_command("CdBlogDir", cd_blog_dir, {})

-- 进入 OneDrive 的目录
local function cd_onedrive()
  local onedrive = "D:\\OneDrive\\笔记"
  vim.cmd("cd " .. onedrive)
end

-- 创建 CdOneDrive 命令
vim.api.nvim_create_user_command("CdOneDrive", cd_onedrive, {})

-- 进入 Vim 配置目录
local function cd_vim_con()
  -- local vim_con = "~/.vim/vim-init/"
  local vim_con = vim.fn.stdpath("config")
  vim.cmd("cd " .. vim_con)
end

-- 创建 CdVimCon 命令
vim.api.nvim_create_user_command("CdVimCon", cd_vim_con, {})
