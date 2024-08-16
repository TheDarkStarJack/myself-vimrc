-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- require("config.autocmds")
-- require("config.keymaps")
-- require("config.options")
-- require("config.mylocal")
-- require("config.macro")

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
    numbers = "both",
  },
})
