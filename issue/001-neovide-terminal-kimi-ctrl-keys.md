# Neovide 内嵌终端中 kimi 的 Ctrl 组合键全部失灵

- **状态**：未解决，断点已锁定在 kimi 自身输入处理层——Windows 侧全部环节（字节、事件合成、libuv 交付）均已实测排除（记录日期：2026-09-24，最近更新：2026-10-12）
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
| Neovide 内嵌终端 → `tmux new` → kimi（2026-10-12 新增） | ✅ 正常 |

## 已排除的因素

- **toggleterm 插件**：内置 `:terminal` 同样失灵，与插件无关
- **nvim 核心的 terminal-mode 转发**：同样的 nvim（0.12.5）在 WT 的 TUI 下内嵌终端正常
- **ConPTY 按键事件合成层**（2026-10-12 排除）：ReadKey 嗅探显示合成事件逐字段正确（`Control|G|7`）
- **Node/libuv 事件→字节交付**（2026-10-12 排除）：node 字节嗅探显示 `0x07` 被正确送达进程
- **ConPTY 整体损坏**：Ctrl+C 能中断 `ping`，说明控制台事件层工作正常（但注意 0x03 在 ConPTY 有特殊处理通道，此条证据强度弱于上两条）
- **nvim 0.12 的 [#38630](https://github.com/neovim/neovim/issues/38630) 回归**（`:terminal` 中 Ctrl+C 无法中断进程）：在本机 0.12.5 上未复现

## 排查记录（2026-10-12）

### 证据 1：tmux 可以绕过故障

tmux 是在 Neovide 内嵌终端里直接运行的（流程：`neovide → :terminal → tmux new → kimi`），Ctrl 组合键全部恢复。机制：tmux 在嫌疑层的两侧各插入了一次"重新翻译"，Windows 控制台事件层被整段短路：

```
坏（直接跑 kimi）:
  nvim 写字节 → ConPTY#1 合成事件 →【断点层】→ Node 读事件

好（经 tmux 跑 kimi）:
  nvim 写字节 → ConPTY#1 合成事件 → tmux（事件→字节翻译，只认字符，对残缺事件鲁棒）
  → 字节 0x07 →（tmux 本地：ConPTY#2 重新合成新事件 / WSL·远端：Linux pty 纯字节）
  → kimi 读到的是字节或全新合成的事件
```

这一观察同时等价于完成了字节层判别：**字节确实被 nvim 写进了 ConPTY**（否则 tmux 无事件可读、pane 内 kimi 不会有反应），即通道层（Neovide → nvim_input → terminal 写字节）正常。

### 证据 2：ReadKey 嗅探——合成事件逐字段正确

在 Neovide 内嵌终端的 pwsh（不经过 tmux）里执行：

```powershell
1..10 | ForEach-Object { $k = [Console]::ReadKey($true); "{0} | {1} | {2}" -f $k.Modifiers, $k.Key, [int]$k.KeyChar }
```

实测输出（预期对照：`Control|G|7`）：

```
Control | G | 7    （按 Ctrl+G）
Control | G | 7    （按 Ctrl+G）
Control | O | 15   （按 Ctrl+O）
```

控制台输入缓冲区里的 KEY_EVENT 修饰键、键码、字符全部正确——**ConPTY 合成层排除**。

### 证据 3：node 字节嗅探——libuv 交付正常

在同一个 Neovide 内嵌终端 pwsh 里执行：

```powershell
node -e "process.stdin.setRawMode(1);process.stdin.resume();process.stdin.on('data',d=>console.log([...d].join(',')))"
```

实测输出：

```
97    （按 a）
7     （按 Ctrl+G）
```

Node/libuv 在 raw 模式下收到的字节完全正确——**libuv 事件→字节交付层排除**。

### 当前结论

断点锁定在 **kimi 自身的输入处理层**。完整链路逐层实测状态：

```
物理键盘 → Neovide(winit) → nvim_input(UI RPC) → nvim terminal-mode 写字节
→ ConPTY 合成事件 → 控制台输入缓冲区 → libuv 交付字节给进程
→【✅ 以上全部实测正常】→ kimi 未响应 Ctrl+G
```

剩余疑点：字节交付与 WT 对照组完全一致，kimi 却表现不同——说明 kimi 大概率依赖了某种**环境信息**做了不同决策（如环境变量 `WT_SESSION`/`TERM`/`TERM_PROGRAM`、控制台模式标志、TTY 能力探测等）。待对比数据确认。

## 下一步诊断

### 1. 环境变量对比（约 1 分钟）

分别在 **Neovide 内嵌终端** 与 **WT 里 TUI nvim 的内嵌终端**（对照组）的 pwsh 中执行，diff 两份输出，重点关注 `WT_SESSION`、`TERM`、`TERM_PROGRAM`、`COLORTERM`、`WT_*`：

```powershell
Get-ChildItem env: | Sort-Object Name | ForEach-Object { "{0}={1}" -f $_.Name, $_.Value }
```

### 2. 控制台模式对比（约 1 分钟）

同上两个环境分别执行，对比输入/输出句柄的 GetConsoleMode 标志：

```powershell
$sig = @'
using System;
using System.Runtime.InteropServices;
public class Con {
  [DllImport("kernel32.dll")] public static extern IntPtr GetStdHandle(int n);
  [DllImport("kernel32.dll")] public static extern bool GetConsoleMode(IntPtr h, out uint m);
}
'@
Add-Type -TypeDefinition $sig
$m = 0u
[void][Con]::GetConsoleMode([Con]::GetStdHandle(-10), [ref]$m)
"input  = 0x{0:X8}" -f $m
[void][Con]::GetConsoleMode([Con]::GetStdHandle(-11), [ref]$m)
"output = 0x{0:X8}" -f $m
```

参考值：输入标志 ENABLE_PROCESSED_INPUT=0x1 / LINE_INPUT=0x2 / ECHO_INPUT=0x4 / WINDOW_INPUT=0x8 / MOUSE_INPUT=0x10 / QUICK_EDIT=0x40 / EXTENDED_FLAGS=0x80 / VT_INPUT=0x200；输出标志 VT_PROCESSING=0x4。

### 3. 向 kimi 反馈

携带以上全部数据（尤其证据 2/3 证明 Windows 侧无问题）向 kimi 侧提 issue。kimi 侧可能的自查方向：对 `WT_SESSION` 等环境变量的分支逻辑、raw 模式 SetConsoleMode 的初始状态假设、按键解析对终端能力探测的依赖。

## 临时绕行方案

- **（新增，推荐）内嵌终端 → `tmux new` → kimi**：Ctrl 键保真，无需离开 Neovide，可配合 jump 跳板机与 `TermWork` 一键开终端的工作流长期使用。
- （旧方案，不推荐）从 nvim 用 `wt.exe -d <cwd> pwsh -Command kimi` 拉起 Windows Terminal 跑 kimi，按键保真。但多一层窗口切换操作，不符合「在 Neovide 中完成日常工作」的使用习惯，仅记录备查。
