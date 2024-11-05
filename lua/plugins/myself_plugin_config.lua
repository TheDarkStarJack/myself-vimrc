-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add vim-easy-align
  {
    "junegunn/vim-easy-align",
    -- keymap = vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", {}),
    keymaps = {
      vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", {}),
      vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", {}),
    },
  },

  -- add vim-text-process
  {
    "skywind3000/vim-text-process",
  },

  -- 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
  {
    "kshenoy/vim-signature",
  },

  -- 用于在侧边符号栏显示 git/svn 的 diff
  {
    "mhinz/vim-signify",
  },

  -- 给不同语言提供字典补全，插入模式下 c-x c-k 触发
  {
    "skywind3000/vim-dict",
  },

  -- UI 增强，查看一些常用的键位
  -- {
  --   "skywind3000/vim-quickui",
  --   opts = {
  --     vim_dict_config = "'html':'html,javascript,css', 'markdown':'text'",
  --   },
  -- },
}
