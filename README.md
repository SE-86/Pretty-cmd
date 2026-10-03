# Pretty cmd

**给 Windows 命令行换一套现代外壳：真实执行命令，还能用「拖节点」的方式写批处理和 Python。**

![Platform](https://img.shields.io/badge/platform-Windows%2010%20%2F%2011-0078D6?logo=windows)
![Python](https://img.shields.io/badge/python-3.9+-3776AB?logo=python)
![UI](https://img.shields.io/badge/UI-CustomTkinter-2E7D32)
![Package](https://img.shields.io/badge/build-PyInstaller%20onefile-orange)
![License](https://img.shields.io/badge/license-not%20set-lightgrey)

它不是终端模拟器，而是套在 `cmd.exe` 之外的一层现代界面：你敲的每一条命令都真的交给系统执行，同时得到命令库、报错中文翻译、自动补全、以及一个**所见即所得的脚本编辑器**——批处理可以手写，也可以拖节点连成蓝图，Python 同样。

---

## 亮点

| | |
| --- | --- |
| **真执行，不模拟** | 走真实子进程，维护当前目录，`cd` 跨盘符、`pushd`/`popd` 目录栈、`~` 展开全部可用 |
| **双击即用的蓝图编程** | 类 UE5 蓝图的节点编辑器，左边点节点、右边连连线，点一下就生成可执行的批处理 / Python 源码 |
| **报错说人话** | 命令报错后一键翻译成中文原因 + 修复建议，还能选中报错文本就地翻译替换原文 |
| **两套脚本互不干扰** | CMD 与 Python 各有独立页面、独立代码框、独立蓝图，互不串味 |
| **命令随叫随到** | 100+ 内置命令 + 实时扫描系统 PATH 的全部可执行文件，支持自动补全、收藏、导入导出 |
| **纯离线** | 不需要账号、不联网、不上传任何内容，单文件 exe |

---

## 截图

> 待补充。建议放入 3~4 张：终端主页 / CMD 蓝图 / Python 蓝图 / 报错翻译。
>
> ```md
> ![终端](docs/screenshot-terminal.png)
> ![Python 蓝图](docs/screenshot-python-blueprint.png)
> ```

---

## 快速开始

### 直接用成品（推荐）

下载 Release 中的 `PrettyCmd.exe` 双击即可，**无需安装 Python**。

> 单文件版首次启动需解压运行库，约 2~5 秒，属正常现象。
>
> `sfc /scannow`、`taskkill` 系统进程、`mklink` 等需要提权的命令：右键 exe → **以管理员身份运行**。

### 从源码运行

```bash
pip install customtkinter darkdetect
python main.py
```

---

## 功能

### 1. 真实终端

直接调用系统子进程执行命令，维护当前目录（支持 `cd` 跨盘符、`pushd`/`popd` 目录栈、`~` 展开到用户目录）、命令排队、运行中可点「停止」强制结束、↑/↓ 翻历史、Enter 发送。历史会跨重启保留。

### 2. 快捷命令

左侧按分类预置 100+ 条常用命令（系统信息 / 网络 / 文件与目录 / 磁盘 / 进程 / 维护 / 环境 / 批处理）。点击任一条，弹出菜单选择：

- **直接发送**：立即在终端里执行
- **仅输入不发送**：只把命令填进输入框，自己决定何时回车
- **「我的命令」**：收藏自己的常用命令。在内置命令或「全部命令」页右键选「添加到我的命令」，或点侧边栏「＋ 管理我的命令…」弹窗增删改

命令历史（↑/↓ 翻）和窗口位置、大小都会自动保存，重启后仍在（设置存于 `%APPDATA%\PrettyCmd\settings.json`）。**支持导出/导入我的命令**（JSON 备份，跨设备迁移）。

### 3. 脚本编辑器（主页面 → CMD 脚本 / Python 脚本）

点开脚本编辑器先进**主页面**，两张入口卡片分别通向两个独立页面，CMD 与 Python 不再混在一起，各自拥有独立的代码框与蓝图。

- **CMD 脚本页**：页内顶部切换「**CMD 代码** / **CMD 蓝图**」。
  - **CMD 代码（`.pmd`）**：写多行批处理命令，点「运行脚本」整体以批处理方式执行（支持 `goto` / `for` / `if` 等）。`.pmd` 为纯文本，向前兼容。**「运行选中」**只运行选中行。
  - **CMD 蓝图**：类 UE5 蓝图的可视化节点开发。调色板带**过滤搜索框**；节点分类：流程控制 / 命令 / **Python** / 文件操作 / **系统** / 网络 / 程序。**Python 节点**通过 base64 内嵌 `python -c` 执行，彻底避免引号与编码问题。
- **Python 脚本页**：页内顶部切换「**Python 代码** / **Python 蓝图**」，专门服务于 Python。
  - **Python 代码（`.py`）**：直接编写并运行 Python 脚本，可使用任意 Python 标准库；保存为 `.py`（UTF-8 编码）；输出实时显示在终端。
  - **Python 蓝图（`.pmdp`）**：**Python 专用的一套节点**——流程控制 / 输入输出 / 数据与变量 / 文件操作 / 系统命令 / 网络 / 自定义代码。「生成代码」产出**带缩进的合法 Python 源码**：`if/else`、`while`、`for`、`try/except` 自动生成正确缩进；`break`/`continue` 若不在循环体内会直接报错拦截，避免生成跑不起来的代码。
- 两个页面都支持：拖节点、连线与吸附连线、框选/多选、Delete 删除连线、Ctrl+Z/Y 撤销重做、Ctrl+C/V 复制粘贴、自动排列。
- 蓝图文件区分：CMD 保存为 `.pmdb`，Python 保存为 `.pmdp`（同为 JSON，向前兼容）；「生成代码」把蓝图写回本页代码框并切到代码形态，「运行蓝图」直接编译执行。
- 随时点左上角「**← 主页面**」回到入口卡片；两个页面的内容与蓝图互不干扰。

### 4. 全部命令

内置命令库 + 真实扫描系统 PATH 中的全部可执行命令（`.exe/.com/.bat/.cmd`），支持搜索和分类筛选，每条都能一键发送或填入输入框；右键某一行可直接选 发送 / 仅输入 / 复制命令 / 添加到我的命令。列表分批渲染，切页、搜索、筛选都不卡。

### 5. 报错一键翻译

命令出错时终端内出现「翻译报错」按钮，一键把报错翻译成直白的中文原因 + 修复建议；选中终端里的报错文本右键 →「翻译选中报错并替换原文」可直接就地翻译替换，不用切页面。

终端右键菜单还带 复制选中 / 复制全部输出 / 导出全部输出到文件 / 粘贴到输入框 / 清屏（Ctrl+L）。

内置常见 CMD 报错规则库（命令不存在、权限不足、路径错误、文件占用、网络不通、磁盘坏道、错误码 5/53/64/87/123/740… 及常见 `0x8007xxxx`）。

### 6. 终端查找 / 自动补全 / 字体缩放

- **Ctrl+F**：在终端输出中搜索关键字，匹配项黄色高亮、当前匹配项蓝色高亮，支持上一个/下一个跳转。
- **自动补全**：输入时自动下拉匹配项（来自命令历史 + 内置命令 + PATH 命令），↑/↓ 选择、Tab 或回车确认、Esc 关闭。
- **字体缩放**：Ctrl+= 放大、Ctrl+- 缩小、Ctrl+0 重置。

---

## 快捷键

| 快捷键 | 作用 |
| --- | --- |
| `Enter` | 发送命令 |
| `↑` / `↓` | 翻阅命令历史 / 选择补全项 |
| `Tab` | 确认自动补全 |
| `Ctrl+F` | 在终端输出中查找 |
| `Ctrl+L` | 清屏 |
| `Ctrl+=` / `Ctrl+-` / `Ctrl+0` | 终端字体放大 / 缩小 / 重置 |
| `Delete` | 删除蓝图选中的节点或连线 |
| `Ctrl+Z` / `Ctrl+Y` | 蓝图画布撤销 / 重做 |
| `Ctrl+C` / `Ctrl+V` | 蓝图画布复制 / 粘贴 |
| `Ctrl+滚轮` | 蓝图画布缩放 |

终端内输入 `help` 可查看 CMD 全部命令，`cls` 清屏，`exit` 结束会话。

---

## 文件类型

| 扩展名 | 含义 | 编码 / 格式 |
| --- | --- | --- |
| `.pmd` | CMD 脚本文本 | 跟随终端编码，纯文本向前兼容 |
| `.py` | Python 脚本文本 | UTF-8 |
| `.pmdb` | CMD 蓝图（节点图） | JSON |
| `.pmdp` | Python 蓝图（节点图） | JSON |

---

## 目录结构

```
Pretty cmd\
├─ main.py           # 主程序（界面）
├─ terminal_core.py  # 终端执行引擎（真实子进程）
├─ commands_db.py    # 常用命令库 + PATH 扫描
├─ translator.py     # 报错翻译规则库
├─ blueprint.py      # CMD 蓝图：节点类型库 + 编译为批处理 + 自检
├─ pyblueprint.py    # Python 蓝图：节点类型库 + 编译为 Python 源码 + 自检
├─ bpcanvas.py       # 蓝图公共画布控件（拖拽 / 连线 / 缩放 / 撤销重做）
├─ smoke_bp.py       # 蓝图 GUI 冒烟测试（110 条用例）
├─ build_icon.py     # 图标生成脚本
├─ assets\app.ico    # 应用图标
├─ build.bat         # 一键重新打包
└─ dist\PrettyCmd.exe  # 成品（单文件）
```

`bpcanvas.py` 的节点库是通过构造参数注入的（`BlueprintCanvas(master, catalog=blueprint | pyblueprint)`），所以 CMD 蓝图与 Python 蓝图共用同一套画布交互，只是节点库不同。

---

## 从源码构建

一键打包：

```bat
build.bat
```

脚本会自动挑选装有 PyInstaller 的解释器。也可以手动执行：

```bash
python -m PyInstaller --noconfirm --clean --onefile --windowed \
  --name "PrettyCmd" --icon "assets\app.ico" \
  --collect-all customtkinter --distpath dist --workpath build main.py
```

> `--collect-all customtkinter` 不能省略，否则主题 JSON 与字体资源不会进包，运行时会崩溃。

产物输出到 `dist\PrettyCmd.exe`。

---

## 测试

```bash
python main.py --selftest        # 终端引擎 + 两套蓝图编译自检
python blueprint.py               # CMD 蓝图自检（含真实 cmd 执行）
python pyblueprint.py             # Python 蓝图自检（含 Python 语法校验）
python smoke_bp.py                # GUI 冒烟测试，110 条用例（需要 tkinter + customtkinter）
```

---

## 已知说明

- 终端输出编码跟随系统（中文 Windows 默认 GBK），个别程序切换 UTF-8 输出时可能显示乱码，属正常现象。
- `wmic` 在新版 Windows 已被弃用，可能不存在；报错翻译会给出提示。
- 仅支持 Windows（依赖 `cmd.exe` 与 Windows 控制台行为）。

---

## 许可

本项目尚未包含开源许可文件。如需开放源码再分发，请先添加 `LICENSE`（如 MIT / Apache-2.0）并在本节说明。
