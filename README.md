# Pretty cmd

**给 Windows 命令行换一套现代外壳：真实执行命令，还能用「拖节点」的方式写批处理和 Python。**

![Platform](https://img.shields.io/badge/platform-Windows%2010%20%2F%2011-0078D6?logo=windows)
![Python](https://img.shields.io/badge/python-3.9+-3776AB?logo=python)
![UI](https://img.shields.io/badge/UI-HTML%20%28pywebview%20%2F%20WebView2%29-58A6FF)
![Package](https://img.shields.io/badge/build-PyInstaller%20onefile-orange)
![Release](https://img.shields.io/badge/version-3.0.1-blue)
![License](https://img.shields.io/badge/license-MIT-green)

它不是终端模拟器，而是套在 `cmd.exe` 之外的一层现代界面：你敲的每一条命令都真的交给系统执行，同时得到命令库、报错中文翻译、自动补全、以及一个**所见即所得的脚本编辑器**——批处理可以手写，也可以拖节点连成蓝图，Python 同样。

整个界面由 HTML 渲染（内置 WebView2/Chromium），单文件 exe，**纯离线、免安装 Python、不上传任何数据**。

---

## 亮点

| | |
| --- | --- |
| **真执行，不模拟** | 走真实子进程，维护当前目录，`cd` 跨盘符、`pushd`/`popd` 目录栈、`~` 展开全部可用 |
| **双击即用的蓝图编程** | 类 UE5 蓝图的节点编辑器，左边点节点、右边连连线，一键生成可执行的批处理 / Python 源码 |
| **报错说人话** | 命令报错后一键翻译成中文原因 + 修复建议，还能选中报错文本就地翻译替换原文 |
| **两套脚本互不干扰** | CMD 与 Python 各有独立页面、独立代码框、独立蓝图，互不串味 |
| **命令随叫随到** | 100+ 内置命令 + 实时扫描系统 PATH 的全部可执行文件，支持自动补全、收藏、导入导出 |
| **现代 HTML 界面** | v3.0.0 起界面由 HTML（WebView2/Chromium）渲染，完全替代旧 tkinter 界面；深色现代化外观、高 DPI 适配 |
| **大输出不卡** | v3.0.1 终端渲染深度优化：DOM 截断 + 合并滚动 + 批量挂载，`dir /s` 数万行输出界面依旧可响应、可随时停止 |
| **中英双语** | 设置页一键切换，整个界面（含蓝图节点名、命令说明、报错翻译）立即重建，脚本内容不受影响 |
| **纯离线** | 不需要账号、不联网、不上传任何内容，单文件 exe |

---

## 截图

> 待补充。建议放入 4~5 张：终端主页 / CMD 蓝图 / Python 蓝图 / 报错翻译 / 设置页（双语切换）。
>
> ```md
> ![终端](docs/screenshot-terminal.png)
> ![Python 蓝图](docs/screenshot-python-blueprint.png)
> ```

---

## 快速开始

### 直接用成品（推荐）

下载 [Releases](https://github.com/你的用户名/Pretty-cmd/releases) 中的 `PrettyCmdSetup.exe` 双击即可，**无需安装 Python、无需安装 WebView2**（安装包内置运行时引导），自动完成：

- 安装到 `%LOCALAPPDATA%\PrettyCmd`（用户级，无需管理员）
- 注册文件关联：双击 `.pmd / .pmdb / .pmdp` 直接用 Pretty cmd 打开
- 右键任意文件 → **用 Pretty cmd 打开**（一键唤醒）
- 右键文件夹空白 → **在此打开 Pretty cmd 终端**（直接进入该目录）
- 创建开始菜单快捷方式；控制面板 → **程序和功能** 可卸载（保留设置文件）

> 单文件版首次启动需解压运行库，约 2~5 秒，属正常现象。
>
> `sfc /scannow`、`taskkill` 系统进程、`mklink` 等需要提权的命令：右键 exe → **以管理员身份运行**。

### 从源码运行

```bash
pip install pywebview
python main_web.py
```

需要 **Microsoft Edge WebView2 运行时**（Win10/11 通常已内置；缺失时程序会弹窗引导下载）。终端自检：

```bash
python main.py --selftest    # 终端引擎 + 两套蓝图编译 + i18n 词典自检（无需界面）
```

---

## 功能

### 1. 真实终端

直接调用系统子进程执行命令，维护当前目录（支持 `cd` 跨盘符、`pushd`/`popd` 目录栈、`~` 展开到用户目录）、命令排队、运行中可点「停止」强制结束、↑/↓ 翻历史、Enter 发送。历史会跨重启保留。

v3.0.1 起渲染性能做了深度优化，`dir /s` 这类数万行输出不再卡死界面：

- **DOM 节点截断**：终端节点数恒定上限，内存不膨胀
- **合并滚动**：一帧只滚动一次，不再每行强制全量重排
- **批量渲染**：输出按帧批量挂载，UI 始终可响应、可停止

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

### 7. 插件系统

程序启动时自动加载安装目录 `plugins\` 下的插件：

- **命令集插件（`.json`）**：一个 JSON 数组批量注册快捷命令 `[{name, cmd, desc, cat}]`
- **功能插件（`.py`）**：提供 `register(ctx)` 函数，用 `ctx.add_command()` 注册命令、`ctx.submit()` 直接执行

插件命令出现在侧边栏分类与「全部命令」页；设置页可查看加载状态、一键打开插件目录。安装包每次安装都会把《插件开发指南.md》与示例插件放进安装目录，详见该文档。

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
├─ main_web.py        # 主程序入口：pywebview 桌面壳（HTML 界面，当前正式形态）
├─ main.py            # 遗留：v2.2.0 tkinter 界面（已被 HTML 版替代，仅保留自检与参考）
├─ webview2_check.py  # WebView2 运行时检测与安装引导
├─ backend.py         # HTML 版后端 bridge（pywebview js_api，含版本号）
├─ webui\             # HTML 前端资源
│  ├─ index.html
│  ├─ css\style.css
│  └─ js\  (i18n / api / app / terminal / sidebar / editor / blueprint / commands / translator / settings)
├─ terminal_core.py   # 终端执行引擎（真实子进程）
├─ commands_db.py     # 常用命令库 + PATH 扫描
├─ translator.py      # 报错翻译规则库
├─ blueprint.py       # CMD 蓝图：节点类型库 + 编译为批处理 + 自检
├─ pyblueprint.py     # Python 蓝图：节点类型库 + 编译为 Python 源码 + 自检
├─ bpcanvas.py        # 遗留：tkinter 版蓝图画布（HTML 版已用 Canvas 重写）
├─ i18n.py            # 国际化：词条字典 + tr() / is_opt()
├─ smoke_bp.py        # 遗留：tkinter 蓝图 GUI 冒烟测试（110 条用例）
├─ smoke_i18n.py      # 遗留：tkinter 语言切换冒烟测试（64 条用例）
├─ smoke_install.py   # 安装/卸载/命令页回归测试（16 条用例）
├─ build_icon.py      # 图标生成脚本
├─ 插件开发指南.md     # 插件开发文档（安装版会复制到安装目录）
├─ plugins\           # 插件目录（JSON 命令集 + Python 功能插件，示例已内置）
├─ installer\         # 安装器 / 卸载器源码与 spec
│  ├─ install_core.py      # 安装核心逻辑（文件关联/右键菜单/快捷方式/卸载信息）
│  ├─ main_installer.py    # 安装向导（HTML 界面 + pywebview）
│  ├─ installer_ui.html    # 安装向导前端
│  ├─ uninstall_main.py    # 卸载逻辑（清理注册表与文件、延迟自删）
│  ├─ PrettyCmdSetup.spec  # 安装包 PyInstaller 配置（内嵌主程序/卸载器/插件/文档）
│  └─ PrettyCmdUninstall.spec
├─ assets\app.ico     # 应用图标
├─ build_web.bat      # HTML 主程序一键打包
├─ build_installer.bat # 一键构建安装包（主程序 + 卸载器 + 安装器）
├─ build.bat          # 遗留：tkinter 版一键打包（不再用于正式产物）
├─ PrettyCmd.spec     # 遗留：tkinter 版 PyInstaller 配置
├─ PrettyCmdWeb.spec  # HTML 主程序 PyInstaller 配置
└─ dist\              # 成品目录
   ├─ PrettyCmd.exe      # HTML 主程序（单文件，正式产物）
   ├─ uninstall.exe      # 卸载器
   └─ PrettyCmdSetup.exe # 一键安装包（推荐分发，内嵌 HTML 主程序 + 向导）
```

---

## 从源码构建

### 一键安装包（推荐产物）

```bat
build_installer.bat
```

依次构建 `dist\PrettyCmd.exe` → `dist\uninstall.exe` → `dist\PrettyCmdSetup.exe`。

安装包内嵌 **HTML 界面主程序 `PrettyCmd.exe`** 与 HTML 安装向导，不依赖 tkinter。

### HTML 主程序

```bat
build_web.bat
```

等价命令：

```bash
python -m PyInstaller --noconfirm --clean --distpath dist --workpath build PrettyCmdWeb.spec
```

**运行依赖**：`pip install pywebview`，且系统需有 **Microsoft Edge WebView2 运行时**。

启动行为（已做防护）：

| 情况 | 表现 |
|---|---|
| WebView2 缺失 | 启动前拦截，弹窗说明原因 + 一键打开官方下载页，不再白屏 |
| 渲染层异常 / 窗口迟迟不就绪 | 25 秒超时后销毁窗口，给出可读诊断并退出，不再无限卡着 |
| 正常 | 打开 HTML 界面 |

### 安装包

```bash
python -m PyInstaller --noconfirm --clean --distpath dist --workpath build installer\PrettyCmdSetup.spec
```

---

## 测试

```bash
python main.py --selftest            # 终端引擎 + 两套蓝图编译 + i18n 词典自检
python blueprint.py                   # CMD 蓝图自检（含真实 cmd 执行）
python pyblueprint.py                 # Python 蓝图自检（含 Python 语法校验）
python main_web.py --autotest-term    # 终端大输出性能自检（12000 行输出，验证 DOM 截断）
python smoke_install.py               # 安装/卸载/命令页回归测试，16 条用例
```

> - `main.py --selftest` 不需要界面即可运行（引擎与编译器自检）。
> - `main_web.py --autotest-term` 启动窗口后自动注入 12000 行输出并计时，结果写 `_autotest_term.json`（v3.0.1 实测约 1.3s，DOM 节点恒 ≤2600）。
> - `smoke_install.py` 会在临时目录做一次真实的「安装 → 校验 → 卸载 → 确认目录已删」闭环，并写入/清理 `HKCU\...\Uninstall\PrettyCmd` 注册表项。跑完请确认该项已被删除。
> - `smoke_bp.py` / `smoke_i18n.py` 为 tkinter 时代遗留，仅在旧版环境可用。

---

## 已知说明

- 终端输出编码跟随系统（中文 Windows 默认 GBK），个别程序切换 UTF-8 输出时可能显示乱码，属正常现象。
- `wmic` 在新版 Windows 已被弃用，可能不存在；报错翻译会给出提示。
- 仅支持 Windows（依赖 `cmd.exe` 与 Windows 控制台行为）。

---

## 许可

本项目按 **MIT License** 发布（LICENSE 文件随首次 Release 添加）。若你更倾向 Apache-2.0 / GPL-3.0 或保留所有权利，在发布前改好 `LICENSE` 与上方 badge 即可。
