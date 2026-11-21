# 阅读顺序

本文件是实现背景；用户本次完整精确要求优先见 [requirements.md](requirements.md)，当前缺项见 [implementation-status.md](implementation-status.md)。

# Markdown 渲染与阅读体验

## 分层与顺序

原站已经把文章与工具的完整解析统一到了 `src/utils/markdownDocument.ts`。复用这条管线，避免文章显示正确、工具预览却缺公式/目录的分叉。

```text
取得 Markdown 原文（与复制/统计共享）
  → renderMarkdownCore
      保护围栏代码、行内代码
      → 数学源码 UTF-8 安全占位
      → marked.parse（原站 breaks:true）
      → 骨架新增：首次 HTML 清洗，再进入任何临时 DOM
      → 代码高亮、复制按钮、Mermaid/[toc] 槽位
      → 恢复 KaTeX（data-src 保留带定界符源码）
  → 图片路径、lazy/async
  → 标题 ID 与 data-sec
  → 文中 TOC
  → 标题自动编号
  → DOMPurify 清洗
  → 按需 Mermaid（strict）
  → 括号装饰与公式复制按钮
  → 页面挂载 v-html
  → 根容器事件委托与侧栏导航
```

原站自动编号在 TOC 构造之后：TOC 保留原始标题，由 CSS counter 编号；标题 ID 在添加可见序号之前生成。这是现有实现的事实，不是所有新站必须使用的编号方案。

## 模块复用

`assets/starter/src/utils/` 保留原站的 11 个文件：核心、编排、公式规范化、目录、Mermaid、括号、公式复制、代码复制、剪贴板、稳定滚动、Markdown 取得。`source-manifest.json` 记录原文件与封装后文件 hash。

骨架对保留源码做了两项明确调整：核心 HTML 在第一次进入临时 DOM 前清洗，编排新增代码数学开关。

`markdownDocument.ts` 的调整：新增可选 `codeFormulas`，默认 true（本次明确要求）。原站传 true，会主动把代码内美元定界内容变成公式。本用户默认开启代码内数学；需要保留货币/shell 字面值时由用户显式选择 false，不能静默更改默认。

原包版本范围记录于骨架 `package.json`，来自被检查的项目，不代表当前最新或已经完成依赖漏洞审计。集成已有项目应使用兼容的现有依赖并运行其测试，不要盲目降级或宣称这些版本最安全。

## 公式

- 先保护代码，再处理 `$$...$$` 和 `$...$`，避免反斜线/下划线被 Markdown 吃掉。
- 原站占位负载用 `TextEncoder`/`TextDecoder` 处理 UTF-8，不给中文公式直接调用 `btoa`。
- `katex.renderToString` 设 `throwOnError:false`，显示失败不能阻断整篇文章。
- `data-src` 保存 `$...$` 或 `$$...$$`。复制按钮读这个属性，不能读 `.katex` 的 `textContent`，因为 KaTeX 含视觉 HTML 与无障碍 MathML，可能得到重复文本。
- 新解析器优先采用成熟的 token 级数学扩展；原站正则只覆盖常见围栏与单反引号行内代码，长围栏、混合反引号、转义美元和跨 HTML 上下文要补测试，不能声称完整 CommonMark 支持。
- 原站数学负载占位标签部分是固定模式，且 cleanFormulaSource 含项目特定容错。高要求系统应将 token 身份限定到本次解析的私有映射，明确支持语法，不扩大“自动修复”范围。

## 代码

使用 highlight.js 的 common 集合；陌生语言回退可读原文。代码复制读取 `pre > code` 克隆，先把 `.code-katex` 换回 `data-src`，不读 pre 整体以免带走按钮文字。保留字面 `$HOME`、`$100` 等。

生成 HTML 字符串期间只输出按钮结构。字符串序列化/`v-html` 会重建节点，给临时节点绑的 listener 会丢失；在稳定根容器统一委托 click/mouseover/mouseout。

原站代码复制 helper 会立即显示成功样式；更严格产品应像公式按钮一样等待 `copyText()` 返回成功再反馈。保留模块是可参考实现，不是已经穷尽错误路径的库。

## TOC 与锚点

`[toc]` 仅当独占纯文本段落时替换；行内 `` `[toc]` `` 保留字面值。标题先生成唯一 ID、记录 `data-sec`，目录与侧栏从最终标题节点读取。重复标题 ID 不同。

原站 ID 是“过滤标题 HTML 字符串 + 全文序号”，加前面章节会改变后续 ID，行内标签名也可能进入结果。新建长效公共文章链接时应改为 DOM `textContent` slug + 同名计数，并设计旧链接兼容；这项变更需要同步搜索章节定位，不能只改侧栏。

原站标题自动编号避免给已有 `1.1`、`一、` 等序号重复编号；混合“手写编号 + 自动编号”时应专门验算计数，必要时把编号设为可选。原始 HTML 带属性标题需额外验证，不能假定标题正则能覆盖所有结构。

懒加载图片与异步图表会推移落点。`stableScroll.ts` 用 ResizeObserver 限时校正；用户 wheel/touchmove 时停止。页面切换/卸载时调用它返回的清理函数。

## Mermaid 与安全

仅在存在图表时动态 import，避免主页加载大库。每次 render 使用全局唯一 ID。原站先清洗普通 HTML，再使用 Mermaid `securityLevel:'strict'` 渲染；渲染异常使用 `textContent` 展示图表源码。

不要为了“显示图形”开启 loose、危险 click 回调或任意 raw HTML。也不要不加区分地对最终 SVG 再做通用清洗：可能删除 foreignObject 内文字。对不可信投稿，应按目标库版本制定严格 SVG allowlist 或隔离策略，并用安全样例测试文字与事件处理两方面。

本次浏览器恶意输入测试证明：原站复制出的管线先将未清洗内容放进脱离文档的 div，再在后续清洗，图片 onerror 仍可能在末尾清洗之前触发。骨架已在 `marked.parse()` 之后、任何自建 DOM 之前增加 DOMPurify 清洗，并保留后续清洗层。原博客未修改。

DOMPurify 清洗不等于任意 HTML、CSS、第三方图表都可信。原站显式保留 style 以支持 KaTeX。公开投稿需按信任模型限制样式、链接、外部资源与 CSP；不要全局开放 script、事件属性、危险 URL。浏览器端 DOM 实现不能原封不动放进服务端渲染。

## 图片与部署 base

原站 `article/md/...` 的 `assets/...` 指向 `public/article/assets/`；其他文档默认取同目录 `assets/`，可用 `assetBase` 覆盖。骨架 `articles/*.md` 的图片默认指向 `public/articles/assets/`。只改相对 assets 路径；保留 https、data、根绝对路径等已有语义。

路由使用 hash 以适合普通静态托管；资源通过 `import.meta.env.BASE_URL`。换成 history 路由需服务器 fallback，不能只改路由构造函数。生产子目录可使用 `SITE_BASE=/notes/` 构建，并实际验证首页与正文 URL。

## 复制层级与可选增强

1. 必选：复制代码、公式、全文原 Markdown。骨架保留全部三项。
2. 完整复现必选：选区复制用 Turndown + GFM，把表格/公式/Mermaid 还原源码，先从克隆 DOM 删除按钮，再通过 data-src/data-idx 还原数学与图表。此功能必须接线 Turndown 依赖并测试；reference-components 已附原实现，starter 当前未接线。
3. 本次要求的全局搜索定位、进度环、去标记字数与解析器规范化必须在完整复现中补齐；PDF 仍按需。骨架提供原始字符数（明确含 Markdown 标记），不要当成“准确词数”。

取得层可用 `markdownSource.ts` Promise 缓存减少重复请求；失败需驱逐缓存。路由切换用代数序号 + AbortController 丢弃过期响应，异步公式/图表结束后也检查。保留 loading/error/empty 状态，不让旧文章短暂冒充新文章。
