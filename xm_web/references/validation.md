# 历史验证：更新前骨架

此页是旧版测试，不证明本次变更全部通过；尤其“代码美元字面值”是当时 false 默认，当前已改为 true。新验证见 validation-current.md。

# 验证记录（2026-11-15）

## 实际执行

- 读取原站源码，并以本地浏览器检查原首页与一篇 Markdown 阅读页。
- 官方 skill quick_validate.py 验证通过（UTF-8 模式）。
- 骨架 vue-tsc --noEmit 类型检查通过；Vite 生产构建通过。
- 骨架测试在隔离目录执行，借用原项目已安装的依赖；未联网安装，未复制 node_modules 到 skill。
- scaffold 用包含中文、引号、HTML 字符的站名实际运行，通过替换和转义验证；非空目标会拒绝，原文件不被覆盖。
- 原样抽取文件与修改文件均记录 hash；原博客对应源码 hash 未变。

### 浏览器行为

- Original homepage and Markdown reader render
- Starter homepage has three article entries
- Code, math, Mermaid and table render
- Repeated headings have different IDs
- All document TOC links target existing headings
- TOC toggle delegates after v-html insertion
- Code preserves dollar signs
- Code copy excludes button text
- Formula copy returns exact LaTeX delimiters
- Full copy matches raw Markdown byte-for-byte as text
- Light paper remains readable under system dark preference
- Mobile reader has no global horizontal overflow
- Mobile TOC stays available
- Adversarial fixture: unsafeTags
- Adversarial fixture: xss
- Adversarial fixture: badMermaid
- Adversarial fixture: inlineCode
- Adversarial fixture: manualAnchor
- Late old request cannot overwrite new article
- Subdirectory /notes/ loads article data
- No uncaught browser errors
- Production Vite build with /notes/ base
- 生产预览 `/notes/` 实际加载 KaTeX 字体成功，字体与资源请求无失败。
- 打印媒体模式下回到顶部等页面控件隐藏。
- 查看桌面首页、生产文章页和 390px 移动端截图，确认主要视觉层次与溢出控制。

## 发现与处理

1. 安全回归最初发现未清洗 HTML 进入临时 div 时，onerror 可能在最终清洗前运行。骨架把清洗提前到首次 DOM 之前，恶意输入复测通过。未修改原博客。
2. 开发 QA 借用跨盘 node_modules 时，KaTeX 字体加载出现测试环境路径问题；生产构建把字体打包进站点后，真实浏览器加载通过。未将开发模式字体诊断当成通过项。
3. 构建有压缩后大 chunk 提醒；这不是构建失败。当前已按需加载 Mermaid，但未承诺最佳体积/性能得分。

## 未覆盖

- 未从零联网安装依赖，因此没有验证新的锁文件或执行依赖漏洞审计；验证使用原项目当时已安装版本。
- 未上线外部托管服务；验证的是本地生产子路径预览。
- 未实现或验收选区还原 Markdown、全文搜索、PDF 导出、暗色主题和完整 CommonMark 边界。
- 安全样例不等于渗透测试；公开不可信投稿须按目标信任模型进一步限制 HTML/CSS/图表。
- 骨架附示例文章，不包含用户原有文章或授权媒体。
