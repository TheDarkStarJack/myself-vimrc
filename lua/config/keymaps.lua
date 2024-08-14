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
vim.keymap.set("n", "q", ":q<CR>", opts)
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
vim.keymap.set("n", "<A-9>", "$gt", opts)

vim.keymap.set("i", "<A-1>", "<Esc>1gt<CR>", opts)
vim.keymap.set("i", "<A-2>", "<Esc>2gt<CR>", opts)
vim.keymap.set("i", "<A-3>", "<Esc>3gt<CR>", opts)
vim.keymap.set("i", "<A-4>", "<Esc>4gt<CR>", opts)
vim.keymap.set("i", "<A-5>", "<Esc>5gt<CR>", opts)
vim.keymap.set("i", "<A-6>", "<Esc>6gt<CR>", opts)
vim.keymap.set("i", "<A-7>", "<Esc>7gt<CR>", opts)
vim.keymap.set("i", "<A-8>", "<Esc>8gt<CR>", opts)
vim.keymap.set("i", "<A-9>", "<Esc>$gt<CR>", opts)

vim.keymap.set("n", "<S-left>", ":tabp<CR>")
vim.keymap.set("n", "<S-right>", ":tabnext<CR>")

-- 新建标签页
vim.keymap.set("n", "<C-n>", ":tabnew<CR>", opts)
vim.keymap.set("i", "<C-n>", "<ESC>:tabnew<CR>", opts)

-- 快捷移动类操作
vim.keymap.set("i", "<C-a>", "<C-o>0", opts)
vim.keymap.set("i", "<C-e>", "<C-o>$", opts)

-- 删除
-- 插入模式向后删除一个单词
vim.keymap.set("i", "<C-d>", "<C-o>dw", opts)
-- 插入模式下向后删除至末尾
vim.keymap.set("i", "<C-k>", "<C-o>D", opts)

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

    header = {
      "---",
      "title: " .. filename,
      "#author: DarkStar",
      "date: " .. current_time .. "+0800",
      "categories: [, ]",
      "tags: []",
      "summary: A brief summary of the document",
      "keywords: [example, documentation, markdown]",
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
      "#      REVISION:  ---",
      "#===============================================================================",
      "",
      "set -o nounset                                  # Treat unset variables as an error",
      "",
    }
  end

  if next(header) ~= nil then
    vim.fn.append(0, header)
  else
    vim.api.nvim_echo(
      { { "Please add file header information, currently supports markdown and bash types.", "WarningMsg" } },
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

-- 加载本地配置内容
-- local function load_myself_local_config()
--   local local_path = vim.fn.stdpath("config")
--   for i = 1, 10, 1 do
--     f1 =
--   end
--   local conf = {
--
--   }
-- end
