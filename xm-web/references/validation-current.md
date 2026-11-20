# 本次更新验证（2026-11-15）

本次任务更新完整需求契约，并同步部分骨架默认与精确样式；没有把未接线功能报告为已经实现。

## 已执行

- Vue/TypeScript 类型检查通过；生产 Vite 构建通过。
- 在隔离副本借用原站本地 node_modules，没有联网安装依赖，没有改原博客。
- 本地生产 `/notes/` 预览，1440px 桌面与 390px 窄屏，Chrome computed style 及浏览器功能检查。
- 以下检查真实通过：

- production build
- 72 percent article width
- 16px / 1.5 body
- exact h1-h5 colors
- 0.712em code and transparent blue background
- single quotation no border, nested 4px border
- GFM read-only task checkboxes
- GFM table alignments
- single newline produces br
- h1 through h6
- formulas in fenced and inline code enabled by default
- safe first DOM sanitization
- relative image, lazy, async
- 48px document title
- three-layer page gradient
- code copy restores formula source
- OS dark does not change light paper or bracket palette
- 900px breakpoint full-width mobile
- mobile no global horizontal overflow
- tool math delimiters and protected text underscore
- no uncaught browser error

## 实测关键值

- 1440px 下正文宽 1036.796875px（72% 的子像素结果）；900px 以下正文满宽。
- 正文 16px / 24px line-height；代码块 11.392px = 16 × .712。
- h1/h2/h3/h4 为 #EE0000/#66CCFF/#39C5BB/#ECAD9E；文件名标题 48px。
- 三层渐变的色值、透明度与位置；代码背景 rgba(178,216,232,.05)。
- 单层引用左边线 0，嵌套 4px；GFM 表格三种对齐、disabled 任务列表与单换行 br。
- 代码块与行内公式默认渲染；代码复制还原 $x^2$；转义清理保留 text 内合法下划线。
- 系统 dark 偏好下仍固定浅色正文/括号；脚本/onerror 未触发；无未捕获浏览器错误。

## 明确未宣称完成

- 选区复制、完整级联导航、环形进度、汉字+英文词胶囊、全局搜索 UI 与索引、解析器工具 UI：已补需求与源码/接线参考，starter 未整合。implementation-status.md 逐项列出。
- 未穷举 Mermaid 所有图型、KaTeX 所有括号环境、复杂混合编号、跨组件选区、部署平台或所有浏览器。
- 构建有部分大 chunk 提醒；未做依赖更新或漏洞审计，不声称最佳体积。
- 原历史预览不作精确验收，新增 previews/reader-faithful.png 与 mobile-faithful.png 是本次隔离样例的截图，右侧仍是明确列出的简化控件。

## Skill 名称兼容检查

旧版下划线名称未通过当时的命名校验。现用 `xm-web` 作为目录名和 Skill 名称，已通过官方 `quick_validate` 校验。
