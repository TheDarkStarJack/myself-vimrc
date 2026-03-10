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
  --
  -- vim 的数据库界面
  -- {
  --   "kristijanhusak/vim-dadbod-ui",
  --   dependencies = {
  --     { "tpope/vim-dadbod", lazy = true },
  --     { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  --   },
  --   cmd = {
  --     "DBUI",
  --     "DBUIToggle",
  --     "DBUIAddConnection",
  --     "DBUIFindBuffer",
  --   },
  --   init = function()
  --     -- Your DBUI configuration
  --     vim.g.db_ui_use_nerd_fonts = 1
  --   end,
  -- },

  -- add bpftrace.vim
  {
    "mmarchini/bpftrace.vim",
  },

  -- add aperezdc/vim-template
  {
    "aperezdc/vim-template",
  },

  -- 翻译插件
  -- 需要提供 api key
  -- "uga-rosa/translate.nvim",
  {
    --
    "JuanZoran/Trans.nvim",
    -- Windows下无法正常使用install，需要手动安装 ecdict https://github.com/skywind3000/ECDICT-ultimate/releases
    -- build = function()
    --   require("Trans").install()
    -- end,
    keys = {
      -- 可以换成其他你想映射的键
      { "mm", mode = { "n", "x" }, "<Cmd>Translate<CR>", desc = "󰊿 Translate" },
      { "mk", mode = { "n", "x" }, "<Cmd>TransPlay<CR>", desc = " Auto Play" },
      -- 目前这个功能的视窗还没有做好，可以在配置里将view.i改成hover
      { "mi", "<Cmd>TranslateInput<CR>", desc = "󰊿 Translate From Input" },
    },
    dependencies = {
      "kkharji/sqlite.lua",
      init = function()
        -- 设置全局变量 sqlite_clib_path
        vim.g.sqlite_clib_path = vim.g.baiduyun .. "\\software\\sqlite3\\sqlite-dll-win-x64-3470200\\sqlite3.dll"
      end,
    },
    opts = {
      dir = vim.g.baiduyun .. "\\software\\ecdict-ultimate-sqlite",
    },
  },
  {
    -- 支持交互式翻译，多种翻译引擎，需要梯子
    "potamides/pantran.nvim",
  },

  -- markdown 编辑和预览
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_port = 8091
    end,
    ft = { "markdown" },
  },

  {
    -- 扩展的语法高亮、匹配规则和映射。支持表格对齐、列表缩进、标题折叠等功能等功能
    "preservim/vim-markdown",
    ft = { "markdown", "md" },
    dependencies = {
      "godlygeek/tabular",
    },
  },

  -- whitestarrain/md-section-number.nvim markdown 章节编号
  {
    "whitestarrain/md-section-number.nvim",
    ft = { "markdown", "md" },
  },

  -- 中英文自动空格
  {
    "hotoo/pangu.vim",
    ft = { "markdown", "md", "txt", "text", "vimwiki", "wiki" },
    -- 设置一个全局变量，用于控制是否启用日期格式化
    init = function()
      vim.g.pangu_spacing = 1
    end,
  },

  -- java 开发插件
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      require("jdtls").start_or_attach({
        cmd = { "jdtls" },
        root_dir = require("jdtls.setup").find_root({ ".git", "pom.xml" }),
      })
    end,
  },

  -- 项目管理
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup()
    end,
  },

  -- add github/copilot.vim ai 代码补全
  {
    "github/copilot.vim",
    -- enabled = false,
  },

  -- nvim avante.nvim 利用 ai 接口提高代码效率
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  --   opts = {
  --     -- add any opts here
  --     -- for example
  --     -- provider = "openai",
  --     -- openai = {
  --     --   endpoint = "https://api.openai.com/v1",
  --     --   model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
  --     --   timeout = 30000, -- timeout in milliseconds
  --     --   temperature = 0, -- adjust if needed
  --     --   max_tokens = 4096,
  --     --   -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
  --     -- },
  --     provider = "copilot",
  --     copilot = {
  --       endpoint = "https://api.githubcopilot.com",
  --       model = "gpt-4o-2024-08-06",
  --       proxy = nil, -- [protocol://]host[:port] Use this proxy
  --       allow_insecure = false, -- Allow insecure server connections
  --       timeout = 30000, -- Timeout in milliseconds
  --       temperature = 0,
  --       max_tokens = 20480,
  --     },
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   -- build = "make",
  --   build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false", -- for windows
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "echasnovski/mini.pick", -- for file_selector provider mini.pick
  --     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  --     "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --     "ibhagwan/fzf-lua", -- for file_selector provider fzf
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     "zbirenbaum/copilot.lua", -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },

  -- 添加 terminal 终端支持
  {
    "akinsho/nvim-toggleterm.lua",
    init = function()
      if vim.fn.has("win32") == 1 then
        local powershell_options = {
          -- 需要从 Windows Terminal 或者 pwsh 中启动，直接通过 neovide icon或者Windows快捷启动，环境变量会有问题，无法正确加载pwsh，只能找到powershell
          -- 找到相同的issue ： https://github.com/neovide/neovide/issues/2362
          shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
          -- shelltemp 是否使用临时文件来传递命令，默认为 true，设置为 false 后会使用管道传递命令
          shelltemp = false,
          -- shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
          -- shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
          shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()';",
          -- shellcmdflag = " -NoLogo -NoProfile -ExecutionPolicy RemoteSigned ",
          -- shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
          shellpipe = "2>&1 | Out-String -Stream",
          -- shellpipe = "2>&1 | Out-String -NoNewline; exit $LastExitCode",
          -- shellpipe = "> %s 2>&1",
          shellquote = "",
          shellxquote = "",
        }

        for option, value in pairs(powershell_options) do
          vim.opt[option] = value
        end
      end
    end,
    config = function()
      require("toggleterm").setup({
        trim_spaces = false,
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = "3", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true, -- close the terminal window when the process exits
        shell = vim.o.shell, -- change the default shell
        float_opts = {
          border = "single",
          width = 200,
          height = 50,
          winblend = 3,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
    end,
  },

  -- 添加 powershell 格式化支持
  {
    "JayDoubleu/vim-pwsh-formatter",
    ft = { "ps1" },
  },
}
