-- 配置一些简写/宏指令/Documents and Settings

-- 设置插入模式下的快捷键映射
-- vim.keymap.set("i", "xdate", function()
--   return os.date("%Y.%m.%d") -- 使用 os.date 没有反应
-- end, { expr = true })
vim.keymap.set("i", "xdate", function()
  return vim.fn.strftime("%Y.%m.%d")
end, { expr = true })
