# Neovide 内嵌终端中 kimi 的 Ctrl 组合键全部失灵

- **状态**：未解决（记录日期：2026-09-24）
- **影响**：无法在本配置（Neovide 宿主）的内嵌终端里正常使用 kimi CLI 的任何 Ctrl 快捷键（Ctrl+G 打开外部编辑器等）

## 环境

- Windows（具体版本未记录）
- Neovide 0.16.2（scoop）
- nvim v0.12.5（scoop，`E:\Scoop\apps\neovim\current\bin\nvim.exe`）
- pwsh（内嵌终端 shell）
- kimi CLI（`/editor` 已配置 vim/nvim）

## 症状

在 Neovide 的内嵌终端（内置 `:terminal` 与 toggleterm 插件表现一致）里运行 `kimi`：

- 所有 Ctrl 组合键（Ctrl+G / Ctrl+T / Ctrl+O 等）毫无反应
- 普通字符输入、Enter、Esc、方向键均正常
- 按 Ctrl+C 能正常中断前台进程（如 `ping`）
- 同样的 kimi 在其他终端环境中 Ctrl 键全部正常

kimi 侧背景：[Ctrl-G = 在外部编辑器中编辑当前输入](https://www.kimi.com/code/docs/en/kimi-code-cli/reference/keyboard.html)，编辑器优先级 `/editor` > `$VISUAL` > `$EDITOR`，快捷键不可重绑定。kimi 是 Node 应用，Windows 上通过**控制台按键事件**（ReadConsoleInput）读取键盘。

## 证据矩阵

| 环境 | kimi 的 Ctrl 组合键 |
| --- | --- |
| Windows Terminal + pwsh | ✅ 正常 |
| WT + TUI nvim 的 `:terminal` + kimi | ✅ 正常 |
| gvim 内置 terminal + kimi | ✅ 正常 |
| **Neovide + nvim（`:terminal` 和 toggleterm 都试过）+ kimi** | ❌ 全部失灵 |

## 已排除的因素

- **toggleterm 插件**：内置 `:terminal` 同样失灵，与插件无关
- **nvim 核心的 terminal-mode 转发**：同样的 nvim（0.12.5）在 WT 的 TUI 下内嵌终端正常
- **kimi 本身**：在三种其他环境下正常
- **ConPTY 整体损坏**：Ctrl+C 能中断 `ping`，说明控制台事件层工作正常
- **nvim 0.12 的 [#38630](https://github.com/neovim/neovim/issues/38630) 回归**（`:terminal` 中 Ctrl+C 无法中断进程）：在本机 0.12.5 上未复现

## 当前收窄

差异只在「Neovide 托管的 nvim」这一条输入路径上：

```
物理键盘 → Neovide(winit) → nvim_input(UI RPC) → nvim terminal-mode → 写字节 → ConPTY → 合成按键事件 → pwsh → kimi
```

对照组（正常）中，TUI nvim 走的是 `conhost → nvim 自带 win32 输入层` 获取按键。怀疑断点在「字节 → **带 Ctrl 修饰的按键事件**」这一合成环节，且只在 GUI 宿主场景下触发（普通按键的事件合成是正常的，问题仅出在 Ctrl 组合键）。

## 下一步诊断（恢复排查时第一个做，约 30 秒）

判别断点位于 nvim 通道层之上还是之下：

1. Neovide 中 `:terminal pwsh`，启动 kimi 停在输入框
2. `<C-\><C-n>` 退出终端模式
3. 执行 `:lua vim.fn.chansend(vim.bo.channel, "\x07")`（直接向终端通道写入 BEL，即 Ctrl+G 字节）
4. 按 `i` 回到终端模式观察：
   - **编辑器弹出** → 通道层正常，问题在 Neovide → nvim_input 键事件路径（应向 [neovide](https://github.com/neovide/neovide/issues) 提 issue）
   - **无反应** → 问题在 ConPTY 的按键事件合成层（应向 [neovim](https://github.com/neovim/neovim/issues) 提 issue，附 `:terminal pwsh` + kimi 复现步骤）

若需进一步定位，可在内嵌终端 pwsh 里分层嗅探：

```powershell
# 控制台按键事件层（kimi 实际读取的层）
1..10 | ForEach-Object { $k = [Console]::ReadKey($true); "{0} | {1} | {2}" -f $k.Modifiers, $k.Key, [int]$k.KeyChar }
# 预期对照：a → 0|A|97，Ctrl+G → Control|G|7

# Node/libuv 字节层（kimi 的运行时）
node -e "process.stdin.setRawMode(1);process.stdin.resume();process.stdin.on('data',d=>console.log([...d].join(',')))"
# 预期：Ctrl+G 输出 7
```

## 临时绕行方案（已评估，未采用）

从 nvim 用 `wt.exe -d <cwd> pwsh -Command kimi` 拉起 Windows Terminal 跑 kimi，按键保真。但多一层窗口切换操作，不符合「在 Neovide 中完成日常工作」的使用习惯，故不采用，仅记录备查。
