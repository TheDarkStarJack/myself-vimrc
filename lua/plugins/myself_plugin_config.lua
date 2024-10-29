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
    keys = function()
      return {
        {
          "ga",
          "<Plug>(EasyAlign)",
          mode = { "x" },
          desc = "Start interactive EasyAlign in visual mode (e.g. vipga)",
        },
        {
          "ga",
          "<Plug>(EasyAlign)",
          mode = { "n" },
          desc = "Start interactive EasyAlign for a motion/text object (e.g. gaip)",
        },
      }
    end,
  },

  -- add vim-text-process
  {
    "skywind3000/vim-text-process",
    opts = {
      textproc_root = "~/.vim/text",
      textproc_split = "auto",
      textproc_runner = {
        py = "python",
        sh = "bash",
        awk = "gawk -f",
      },
    },
  },
}
