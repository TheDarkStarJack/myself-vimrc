-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- define common options
local opts = {
  noremap = true, -- non-recursive
  silent = true, -- do not show message
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

vim.keymap.set("i", "<A-1>", ":1gt<CR>", opts)
vim.keymap.set("i", "<A-2>", ":2gt<CR>", opts)
vim.keymap.set("i", "<A-3>", ":3gt<CR>", opts)
vim.keymap.set("i", "<A-4>", ":4gt<CR>", opts)
vim.keymap.set("i", "<A-5>", ":5gt<CR>", opts)
vim.keymap.set("i", "<A-6>", ":6gt<CR>", opts)
vim.keymap.set("i", "<A-7>", ":7gt<CR>", opts)
vim.keymap.set("i", "<A-8>", ":8gt<CR>", opts)
vim.keymap.set("i", "<A-9>", ":$gt<CR>", opts)

vim.keymap.set("n", "<S-left>", ":tabp<CR>")
vim.keymap.set("n", "<S-right>", ":tabnext<CR>")

-- 新建标签页
vim.keymap.set("n", "C-n", ":tabnew<CR>", opts)
vim.keymap.set("i", "C-n", "<ESC>:tabnew<CR>", opts)
