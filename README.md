# xm_skill

小满的 Codex skills：问题驱动的技术笔记、浅色技术网站，以及来源可追溯的学习与测验系统。

## 三个 Skill

| Skill | 用途 |
| --- | --- |
| [xm_learning](xm_learning/SKILL.md) | 将材料或指定主题构建为学习、测验与答案复习网站；自动组合另外两个 skill。 |
| [xm_note](xm_note/SKILL.md) | 用问题、直觉、公式、shape 和具体例子解释技术知识，保持准确、可检查的笔记风格。 |
| [xm_web](xm_web/SKILL.md) | 构建浅色博客与 Markdown 阅读界面，含代码高亮、数学公式、目录和源码复制；附带参考资料、截图与 Vue starter。 |

## 安装

克隆此仓库后，将根目录的 `xm_learning`、`xm_note`、`xm_web` 三个完整文件夹复制到你的 Codex skills 目录（通常为 `~/.codex/skills/`；自定义 `CODEX_HOME` 时使用对应的 `skills/` 目录）。保留每个文件夹中的 `agents/`、`references/`、`assets/` 和 `scripts/` 等实际存在的配套文件，不要只复制 `SKILL.md`。

三个文件夹应保持同级，供 `xm_learning` 加载 `xm_note` 和 `xm_web`。如果已安装同名 skill，先备份本地修改，再决定是否替换。

```text
~/.codex/skills/
├── xm_learning/
├── xm_note/
└── xm_web/
```

## 使用示例

```text
$xm_learning 请围绕 FlashAttention 构建学习、测验和答案复习网站。
$xm_note 请解释 Online Softmax，给出公式、shape 和可手算的例子。
$xm_web 请为我的技术笔记搭建浅色 Markdown 阅读网站。
```

`xm_learning` 要求测验配置提供可见的一键“全选章节”入口，支持学完整门内容后综合练习；保留手动选择、其他筛选与当前作答，不因全选自动开始测验或重置进度。

具体约束与验收要求以各 skill 的 `SKILL.md` 及其引用文件为准。`xm_web` 所附 starter 的依赖安装、构建与使用方式见其目录内说明。

## 内容边界

本仓库只包含这三个 skill 及其配套资源，不包含个人笔记库、生成的网站项目或账户凭据。参考来源及原实现提取记录保留在相关 skill 的 references 中；使用外部素材和衍生实现时请遵守适用的授权要求。
