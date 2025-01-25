-- config BaiduSyncdisk path and other path
-- 先于 LazyVim 配置文件设置，LazyVim 的插件配置通常会在初始化过程中延迟加载。导致 vim.g.baiduyun 在插件使用时还没有被正确赋值。
local homebdy = "E:\\BaiduSyncdisk"
local workbdy = "D:\\BaiduSyncdisk"
local local_home = vim.fn.stdpath("data")
local mylocal_dir = "\\nvim\\mylocal"
local function set_baiduyun()
  if vim.fn.isdirectory(workbdy) > 0 then
    return workbdy
  elseif vim.fn.isdirectory(homebdy) > 0 then
    return homebdy
  else
    return local_home
  end
end
vim.g.baiduyun = set_baiduyun()

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

-- 加载本地个性化配置

local config_dir = vim.g.baiduyun .. mylocal_dir
-- vim.notify(vim.fn.isdirectory(homebdy))
-- vim.notify("Config directory: " .. config_dir)
-- 设置 vim-text-process

local function set_textproc_root()
  local text_dir = "\\nvim\\text"
  local text_dir2 = "~/.config/nvim/text"
  if vim.fn.isdirectory(vim.g.baiduyun .. text_dir) > 0 then
    return vim.g.baiduyun .. text_dir
  else
    return text_dir2
  end
end
vim.g.textproc_split = "auto"
vim.g.textproc_root = set_textproc_root()
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

-- 检查目录是否存在
local function directory_exists(path)
  local stat = vim.uv.fs_stat(path)
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
