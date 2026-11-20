---
name: drawio
description: 使用本机 draw.io 创建或修改论文流程图、方法框架图和实验设计图，在当前项目的 assets/drawio 目录保留可编辑的 .drawio 源文件并导出 .png。也用于将现有 .drawio 按指定页码或倍率导出为 PNG。
---

# 用 draw.io 绘图和导出

导出使用 Windows 上的 draw.io 桌面版，已验证版本为 29.3.6。通过 `-DrawioExe` 指定本机可执行文件路径。

## 保存到当前项目

- 使用当前聊天关联的项目根目录，或用户明确指定的目标项目根目录。从项目子目录执行时，先定位项目根目录。若当前聊天没有关联项目，也没有指定目标项目，先确认项目位置。
- 在该项目根目录下创建 `assets/drawio`，将 `.drawio` 源文件和对应的 `.png` 都保存到这个目录。处理目录外的已有源文件时，将源文件复制到这里再处理，保留原文件。
- 如项目目录受工作区权限限制，先在可写位置制作和验证，再通过当前环境的权限机制写入项目的 `assets/drawio`。

## 制作可编辑的图

- 修改已有图时使用原有的页面、节点和连线。新图可以直接编写 UTF-8 的未压缩 draw.io XML，页面结构为 `mxfile → diagram → mxGraphModel → root`。
- `root` 中先放置 `<mxCell id="0"/>` 和 `<mxCell id="1" parent="0"/>`。节点使用唯一 ID、`vertex="1"`、`parent="1"` 和带坐标、宽高的 `mxGeometry as="geometry"`。连线使用 `edge="1"`、`source`、`target` 和 `mxGeometry relative="1" as="geometry"`。转义标签中的 XML 特殊字符。复杂结构参考 [draw.io 文件格式](https://github.com/jgraph/drawio/wiki/File-Format)。
- 如果本地提供了 `examples/reference.md`，按图的用途查找可参考的布局、分组和标注。论文图先确定主路径和阶段接口，局部图展开关键模块，在张量尺寸或数据类型发生变化的位置标注。按论文的语言和版面统一字体，中文可用 Microsoft YaHei。

## 数学公式

- 手动编辑时，在 draw.io 的 **Extras → Mathematical Typesetting（数学排版）** 启用 MathJax，将公式写进文本框、形状或连线标签。
- 独立公式用 `$$...$$`，例如 `$$F_{out}=\alpha F_1+(1-\alpha)F_2$$`。文字或张量尺寸标签中的行内公式用 `\(...\)`，例如 `输出 \(B\times C\times H\times W\)`。
- 生成 XML 时，在含公式的页面的 `<mxGraphModel>` 上写 `math="1"`，把 LaTeX 原文放进标签的 `value`，保留反斜杠并转义 XML 特殊字符。矩阵或对齐环境里的列分隔符 `&` 在 XML 属性里写为 `&amp;`。本机 29.3.6 已实测 PNG 可导出分式、求和、行内公式和矩阵。
- 公式显示为源码时，检查该页是否启用了数学排版、定界符是否配对，以及标签中是否插入了格式化 HTML。导出后检查分式、上下标和矩阵是否完整，必要时按渲染后的宽高加大文本框。[draw.io 数学排版文档](https://www.drawio.com/docs/manual/text/math-typesetting/)

## 默认配色和箭头

新图的节点从 draw.io 样式面板的这六组浅色预设中选色。同类节点使用同一组填充和描边。

| 颜色 | 填充 `fillColor` | 描边 `strokeColor` |
| --- | --- | --- |
| 蓝色 | `#DAE8FC` | `#6C8EBF` |
| 绿色 | `#D5E8D4` | `#82B366` |
| 橙色 | `#FFE6CC` | `#D79B00` |
| 黄色 | `#FFF2CC` | `#D6B656` |
| 红色 | `#F8CECC` | `#B85450` |
| 紫色 | `#E1D5E7` | `#9673A6` |

新建箭头默认使用 **2 pt、`#66CCFF`**，在连线的样式中写入 `strokeWidth=2;strokeColor=#66CCFF;`。这些默认值适用于新建元素，按用户要求调整已有图的样式。

## 导出 PNG

从项目根目录运行以下命令。先创建图件目录并将源文件保存为其中的 `figure01.drawio`，再用 [scripts/export-png.ps1](scripts/export-png.ps1) 导出。

```powershell
$drawioDir = Join-Path (Get-Location) 'assets\drawio'
$null = [System.IO.Directory]::CreateDirectory($drawioDir)
$drawioScript = Join-Path $HOME '.codex\skills\drawio\scripts\export-png.ps1'
$drawioExe = 'C:\Program Files\draw.io\draw.io.exe' # 改为本机安装路径
# 将源文件保存到 $drawioDir 下，再运行导出命令。
& $drawioScript -SourcePath (Join-Path $drawioDir 'figure01.drawio') -DrawioExe $drawioExe
```

默认导出第一页，使用 3 倍倍率和透明背景，成品 PNG 的四边各留 5 个透明像素。新建图的 `mxGraphModel` 可以用 `background="none"`。脚本在导出时处理已有图的画布底色，保留源文件。

PNG 写到源文件旁边。用 `-Page` 指定从 1 开始的页码，`-Scale` 修改倍率，`-Border` 修改成品留白的像素数。多页分别导出时，用 `-OutputPath` 为每页指定 `assets/drawio` 下的不同文件名。用 `-DrawioExe` 指定其他安装路径。重新导出并更新已有 PNG 时传入 `-Overwrite`。脚本校验 PNG 并报告尺寸。
