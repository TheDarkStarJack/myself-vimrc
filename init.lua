-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 设置标签页的显示格式
local bufferline = require("bufferline")
bufferline.setup({
  options = {
    -- 设置仅显示标签页，默认会显示 buffers 显得太乱了，不方便切换
    mode = "tabs",
    -- 设置 buffers 格式 : help bufferline-number
    -- For 8|² -
    -- numbers = function(opts)
    --   return string.format("%s|%s", opts.id, opts.raise(opts.ordinal))
    -- end,
    -- 仅显示标签编号
    numbers = "ordinal",
  },
})

-- 加载个人本地配置
local local_file = vim.fn.stdpath("config") .. "/lua/config/mylocal.lua"
if vim.uv.fs_stat(local_file) then
  require("config.mylocal")
end

-- 设置 statusline
local myself_line = require("lualine")
local function PasteStatus()
  return vim.o.paste and "[PASTE]" or ""
  -- return "&paste?'PASTE':''"
end

myself_line.setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})

-- vim.opt.statusline = vim.opt.statusline .. "%{&paste?'PASTE':''}"

-- 设置 colorscheme
vim.cmd([[colorscheme tokyonight-night]])

-- 设置行高亮的属性
vim.api.nvim_set_hl(0, "CursorLine", { ctermbg = "DarkCyan", bg = "#000000" })
