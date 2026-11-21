# xm_skill

小满的 Codex Skills，涵盖问题驱动的技术笔记、浅色技术网站、来源可追溯的学习与测验系统，以及可编辑的论文图。

## 四个 Skill

| Skill | 用途 |
| --- | --- |
| [xm-learning](03-个人自定义/xm-learning/SKILL.md) | 将材料或指定主题构建为学习、测验与答案复习网站，组合 `xm-note` 和 `xm-web`，复杂示意图调用 `drawio`。 |
| [xm-note](03-个人自定义/xm-note/SKILL.md) | 用问题、直觉、公式、shape 和具体例子解释技术知识，保持准确、可检查的笔记风格。 |
| [xm-web](03-个人自定义/xm-web/SKILL.md) | 构建浅色博客与 Markdown 阅读界面，含代码高亮、数学公式、目录和源码复制，附带参考资料、截图与 Vue starter。 |
| [drawio](02-软件使用/绘图与内容制作/drawio/SKILL.md) | 使用 Windows 上的 draw.io 桌面版创建论文图，在项目的 `assets/drawio/` 保存可编辑源文件和透明 PNG。 |

## 安装

克隆此仓库后，将 `02-软件使用/` 和 `03-个人自定义/` 中的技能按下图复制到 Codex 技能目录。默认目录为 `~/.codex/skills/`，自定义 `CODEX_HOME` 时使用对应的 `skills/` 目录。保留各技能的完整目录和相对位置，`xm-learning` 会据此找到其余三个技能。

```text
~/.codex/skills/
├── 02-软件使用/
│   └── 绘图与内容制作/
│       └── drawio/
└── 03-个人自定义/
    ├── xm-learning/
    ├── xm-note/
    └── xm-web/
```

从旧版升级时，可将原有的四个技能目录移动到对应位置，再合并仓库更新，保留本地添加的参考资料。

## 使用示例

```text
$xm-learning 请围绕 FlashAttention 构建学习、测验和答案复习网站。
$xm-note 请解释 Online Softmax，给出公式、shape 和可手算的例子。
$xm-web 请为我的技术笔记搭建浅色 Markdown 阅读网站。
$drawio 请根据当前项目的方法章节绘制论文框架图，保留源文件并导出 PNG。
```

`xm-learning` 要求测验配置提供可见的一键“全选章节”入口，支持学完整门内容后综合练习；保留手动选择、其他筛选与当前作答，不因全选自动开始测验或重置进度。

具体约束与验收要求以各 Skill 的 `SKILL.md` 及其引用文件为准。`xm-web` 所附 starter 的依赖安装、构建与使用方式见其目录内说明。

## draw.io 与本地参考图

`drawio` 的导出脚本需要 Windows 和 draw.io 桌面版。请按本机安装位置为脚本传入 `-DrawioExe`。

`02-软件使用/绘图与内容制作/drawio/examples/` 用于存放本地参考图和参考表，由 `.gitignore` 排除。绘图规则和导出步骤见 [drawio/SKILL.md](02-软件使用/绘图与内容制作/drawio/SKILL.md)。

## 内容边界

本仓库发布上述四个 Skill 及其公开配套资源。参考来源及原实现提取记录保留在相关 Skill 的 references 中。
