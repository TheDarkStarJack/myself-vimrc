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
-- local function PasteStatus()
--   return vim.o.paste and "[PASTE]" or ""
--   -- return "&paste?'PASTE':''"
-- end

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

-- 设置 vim-text-process

vim.g.textproc_root = "~/.config/nvim/text"
vim.g.textproc_split = "auto"

vim.g.textproc_runner = {
  py = "python",
  sh = "bash",
  awk = "gawk -f",
}

-- local vimdict = require("vim-dict")
-- vimdict.setup = {
--   opts = {
--     -- 设定需要生效的文件类型，如果是 "*" 的话，代表所有类型
--     apc_enable_ft = "'text':1, 'markdown':1, 'php':1",
--   },
-- }
--
-- 加载本地个性化配置

-- 使用 HOME 目录下的路径
local config_dir = vim.fn.expand("~") .. "/.config/nvim/mylocal"
-- 或者可以使用 vim.env.HOME：
-- local config_dir = vim.env.HOME .. "/.config/nvim/my-config"

-- 检查目录是否存在
local function directory_exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "directory"
end

-- 加载配置目录下的所有文件
local function load_config_files()
  for _, file in ipairs(vim.fn.readdir(config_dir)) do
    local file_path = config_dir .. "/" .. file
    if file:match("%.lua$") then
      dofile(file_path) -- 加载 Lua 配置文件
    end
  end
end

-- 在启动时检查并加载配置
if directory_exists(config_dir) then
  load_config_files()
end
