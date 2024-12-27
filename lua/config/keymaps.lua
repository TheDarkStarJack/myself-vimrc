-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- define common options
local opts = {
  noremap = true, -- non-recursive
  silent = true, -- do not show message
}

local optn = {
  noremap = true, -- non-recursive
  silent = false,
}

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-----------------
-- Insert mode --
-----------------
-- 向上/下插入一行
vim.keymap.set("i", "<S-Enter>", "<Esc>O", opts)
vim.keymap.set("i", "<C-Enter>", "<Esc>o", opts)
-- 将光标后的内容移动至上/下一行
vim.keymap.set("i", "<S-Up>", "<Esc>DO<C-o>P", opts)
vim.keymap.set("i", "<S-Down>", "<Esc>Do<C-o>P", opts)

-- 映射为从系统剪贴板粘贴内容
vim.keymap.set("i", "<A-v>", "<C-r>+", opts)
vim.keymap.set("c", "<A-v>", "<C-r>+", optn)

-- 文件保存
vim.keymap.set("n", "<A-q>", ":x<CR>", opts)
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", opts)
vim.keymap.set("n", "<C-s>", ":w<CR>", opts)

-- 翻页
vim.keymap.set("n", "<Space>d", "<C-d>", opts)
vim.keymap.set("n", "<Space>f", "<C-f>", opts)
vim.keymap.set("n", "<Space>b", "<C-b>", opts)
vim.keymap.set("n", "<Space>u", "<C-u>", opts)

-- 切换标签页
vim.keymap.set("n", "<A-1>", "1gt", opts)
vim.keymap.set("n", "<A-2>", "2gt", opts)
vim.keymap.set("n", "<A-3>", "3gt", opts)
vim.keymap.set("n", "<A-4>", "4gt", opts)
vim.keymap.set("n", "<A-5>", "5gt", opts)
vim.keymap.set("n", "<A-6>", "6gt", opts)
vim.keymap.set("n", "<A-7>", "7gt", opts)
vim.keymap.set("n", "<A-8>", "8gt", opts)
vim.keymap.set("n", "<A-9>", ":tablast<CR>", opts)

vim.keymap.set("i", "<A-1>", "<Esc>1gt<CR>", opts)
vim.keymap.set("i", "<A-2>", "<Esc>2gt<CR>", opts)
vim.keymap.set("i", "<A-3>", "<Esc>3gt<CR>", opts)
vim.keymap.set("i", "<A-4>", "<Esc>4gt<CR>", opts)
vim.keymap.set("i", "<A-5>", "<Esc>5gt<CR>", opts)
vim.keymap.set("i", "<A-6>", "<Esc>6gt<CR>", opts)
vim.keymap.set("i", "<A-7>", "<Esc>7gt<CR>", opts)
vim.keymap.set("i", "<A-8>", "<Esc>8gt<CR>", opts)
vim.keymap.set("i", "<A-9>", "<Esc>:tablast<CR>", opts)

vim.keymap.set("n", "<S-left>", ":tabp<CR>")
vim.keymap.set("n", "<S-right>", ":tabnext<CR>")

-- 在最后一个标签页之后新建标签页，免得打乱原有的标签页顺序
vim.keymap.set("n", "<C-n>", ":$tabnew<CR>", opts)
vim.keymap.set("i", "<C-n>", "<ESC>:$tabnew<CR>", opts)

-- 快捷移动类操作
vim.keymap.set("i", "<C-a>", "<C-o>0", opts)
vim.keymap.set("i", "<C-e>", "<C-o>$", opts)

-- 删除
-- 插入模式向后删除一个单词
vim.keymap.set("i", "<C-d>", "<C-o>dw", opts)
-- 插入模式下向后删除至末尾
vim.keymap.set("i", "<C-k>", "<C-o>D", opts)

-----------------
-- terminal mode --
-----------------

-- 退出 terminal 模式

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

-----------------
-- command mode --
-----------------
--- Crtl+a/e 快速移动到行首行尾
--- 在命令行模式下，<Home> 和 <End> 并非通用快捷键（依赖于终端设置），而 <C-B>（移动到行首）和 <C-E>（移动到行尾）是内置行为，跨平台兼容性更好。
--- https://neovim.io/doc/user/cmdline.html
--- 不知道什么鬼 <Home> <C-b> <C-B> 都需要在按键之后在按下其他键才会移动行首/尾部 <Home><Left> 都不行，后续有时间在研究
-- vim.keymap.set("c", "<C-a>", "<Home>", opts)
-- vim.keymap.set("c", "<C-e>", "<End>", opts)
vim.keymap.set("c", "<C-a>", "<C-B>", opts)
vim.keymap.set("c", "<C-e>", "<C-E>", opts)

-- # 设置文件头 -------------------------- > {{{1
-- 获取文件名和时间的通用函数
local function get_filename_and_time()
  local filename = vim.fn.expand("%:t:r")
  local current_time = os.date("%Y-%m-%d %H:%M:%S")
  return filename, current_time
end

-- 插入头部的函数
local function add_header()
  local filename, current_time = get_filename_and_time()

  local filetype = vim.bo.filetype
  local header = {}

  if filetype == "markdown" then
    if vim.fn.getline(1) == "---" then
      print("Header already exists.")
      return
    end
    --[[
    ---参考：https://noahnyy.github.io/posts/write-a-new-post/
    ---固定帖子:
    ---可以将一个或多个帖子固定到主页顶部，固定帖子将根据其发布日期按相反顺序排序。启用方式
    ---pin: true
    ---出于网站性能原因，默认情况下不会加载数学功能。但可以通过以下方式启用它：math: true
    ---如果要将图像添加到文章内容的顶部，请通过以下方式指定图像的 URL: image: /path/to/image-file
    ---
    ---修改时间：
    ----
    ---  filename: getting-started             # the post filename without date and extension
    ---  lastmod: 2020-04-13 00:38:56 +0800    # the post last modified date
    ---    -
    --]]
    header = {
      "---",
      "title: " .. filename,
      "#author: DarkStar",
      "date: " .. current_time .. "+0800",
      "lastmod: " .. current_time .. "+0800",
      "categories: [, ]",
      "tags: []",
      "#pin: true",
      "#summary: A brief summary of the document",
      "#keywords: [example, documentation, markdown]",
      "#comments: false",
      "#math: true",
      "#image: ",
      "---",
      "",
    }
  elseif filetype == "sh" then
    if vim.fn.getline(1) == "#!/bin/bash -" then
      print("Header already exists.")
      return
    end

    header = {
      "#!/bin/bash -",
      "#===============================================================================",
      "#",
      "#          FILE: " .. filename,
      "#",
      "#         USAGE: " .. filename .. " [args1] [args2]",
      "#",
      "#   DESCRIPTION:.",
      "#",
      "#       OPTIONS: ---",
      "#  REQUIREMENTS: ---",
      "#          BUGS: ---",
      "#         NOTES: ---",
      "#        AUTHOR: wxj (DarkStar), 2403220952@qq.com",
      "#  ORGANIZATION:.",
      "#       CREATED: " .. current_time,
      "#       LASTMOD: ",
      "#      REVISION:  ---",
      "#===============================================================================",
      "",
      "set -o nounset                                  # Treat unset variables as an error",
      "",
    }
  elseif filetype == "sql" then
    if vim.fn.getline(1) == "--SQL" then
      print("Header already exists.")
      return
    end

    header = {
      "--SQL",
      "--",
      "--       FILE:" .. filename,
      "--      USAGE: ",
      "--",
      "--     AUTHOR:",
      "--      wxj (DarkStar), 2403220952@qq.com",
      "--    CREATED: " .. current_time,
      "--    LASTMOD:" .. current_time,
      "--    CATEGORIES:",
      "--      categories: [, ]",
      "--      tags: []",
      "--    NAME",
      "--      " .. filename .. " - <>",
      "--",
      "--    DESCRIPTION:",
      "--      <>",
      "--",
      "--    NOTES:",
      "--      <>",
      "--",
      "--    MODIFIED:",
      "--    author: DarkStar  " .. current_time,
      "--",
    }
  end

  if next(header) ~= nil then
    vim.fn.append(0, header)
  else
    vim.api.nvim_echo(
      { { "Please add file header information, currently supports markdown and bash 、sql types.", "WarningMsg" } },
      false,
      {}
    )
  end
end

-- 将 add_header 函数绑定到命令 AddHeader
vim.api.nvim_create_user_command("AddHeader", add_header, {})
vim.keymap.set("i", "<C-m>", "<ESC>:AddHeade<CR>", opts)
vim.keymap.set("n", "<C-m>", ":AddHeader<CR>", opts)

-- 保存文件并添加日期前缀的函数
local function save_with_date()
  local date = os.date("%Y-%m-%d")
  local filename = vim.fn.expand("%")
  local new_filename = date .. "-" .. filename

  -- 保存当前 buffer 内容
  vim.cmd("write")

  -- 重命名文件
  os.rename(filename, new_filename)

  -- 重新打开新文件
  vim.cmd("edit " .. new_filename)
end

-- 将 save_with_date 函数绑定到命令 SaveWithDate
vim.api.nvim_create_user_command("SaveWithDate", save_with_date, {})
--
-- -- 设置 neovide 透明度
-- local function set_neovide_transparency(rang)
--   if vim.g.neovide then
--     -- Setting g:neovide_transparency to a value between 0.0 and 1.0 will set the opacity of the window to that value.
--     vim.g.neovide_transparency = rang
--   end
-- end
--
-- vim.api.nvim_create_user_command("Tran", set_neovide_transparency(0.8), optn)
-- vim.api.nvim_create_user_command("TranReset", set_neovide_transparency(1.0), optn)
-- 设置 neovide 透明度
local function set_neovide_transparency(range)
  if vim.g.neovide then
    -- 设置透明度（值在 0.0 到 1.0 之间）
    vim.g.neovide_transparency = range
    vim.notify("Neovide Transparency set to " .. range, vim.log.levels.INFO)
  else
    vim.notify("Neovide is not enabled!", vim.log.levels.WARN)
  end
end

-- 创建用户命令 Tran，用于动态设置透明度
vim.api.nvim_create_user_command("Tran", function(opts)
  local range = tonumber(opts.args) or 1.0 -- 默认透明度为 1.0
  if range >= 0.0 and range <= 1.0 then
    set_neovide_transparency(range)
  else
    vim.notify("Invalid transparency value! Please provide a number between 0.0 and 1.0.", vim.log.levels.ERROR)
  end
end, {
  nargs = 1, -- 需要一个参数
  desc = "Set Neovide transparency (0.0 - 1.0)",
})

-- 创建用户命令 TranReset，恢复透明度为 1.0
vim.api.nvim_create_user_command("TranReset", function()
  set_neovide_transparency(1.0)
end, {
  desc = "Reset Neovide transparency to 1.0",
})

--
-- 定义透明度切换的快捷键
vim.keymap.set({ "n", "i" }, "<A-t>", function()
  set_neovide_transparency(0.8)
end, { desc = "Set Neovide transparency to 0.8" })

vim.keymap.set({ "n", "i" }, "<A-r>", function()
  set_neovide_transparency(1.0)
end, { desc = "Reset Neovide transparency to 1.0" })
