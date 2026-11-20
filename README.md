# xm_skill

小满的 Codex Skills，涵盖问题驱动的技术笔记、浅色技术网站、来源可追溯的学习与测验系统，以及可编辑的论文图。

## 四个 Skill

| Skill | 用途 |
| --- | --- |
| [xm-learning](xm-learning/SKILL.md) | 将材料或指定主题构建为学习、测验与答案复习网站，组合 `xm-note` 和 `xm-web`，复杂示意图调用 `drawio`。 |
| [xm-note](xm-note/SKILL.md) | 用问题、直觉、公式、shape 和具体例子解释技术知识，保持准确、可检查的笔记风格。 |
| [xm-web](xm-web/SKILL.md) | 构建浅色博客与 Markdown 阅读界面，含代码高亮、数学公式、目录和源码复制，附带参考资料、截图与 Vue starter。 |
| [drawio](drawio/SKILL.md) | 使用 Windows 上的 draw.io 桌面版创建论文图，在项目的 `assets/drawio/` 保存可编辑源文件和透明 PNG。 |

## 安装

克隆此仓库后，将根目录的 `xm-learning`、`xm-note`、`xm-web` 和 `drawio` 四个完整文件夹复制到你的 Codex skills 目录。默认目录为 `~/.codex/skills/`，自定义 `CODEX_HOME` 时使用对应的 `skills/` 目录。请一起复制各 Skill 的配套资源。

四个文件夹应保持同级，以便 `xm-learning` 找到其他 Skill。旧版的 `xm_learning`、`xm_note` 和 `xm_web` 已改为连字符命名。更新前请备份本地修改。

```text
~/.codex/skills/
├── drawio/
├── xm-learning/
├── xm-note/
└── xm-web/
```

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

`drawio/examples/` 保存作者的论文原图和本地参考表，整个目录由 `.gitignore` 排除。公开版无法访问这些参考资料，可以直接按 [drawio/SKILL.md](drawio/SKILL.md) 的绘图规则和导出步骤使用。

## 内容边界

本仓库发布上述四个 Skill 及其公开配套资源。参考来源及原实现提取记录保留在相关 Skill 的 references 中。
