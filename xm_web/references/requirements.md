# xm_web 完整复现规范

本文件承接用户 2026-11-15 给出的逐项要求，是本 skill 文章阅读界面和 Markdown 行为的验收依据。默认忠实复现；不使用上个版本的“更可读变体”替换指定的色值、比例或字号。不需要暗色模式。

规范与实际已完成的实现分开：详细实现状态记录在 implementation-status.md；仅写入规范不表示当前骨架已经具备每一项交互。


## 一、基础 Markdown / GFM

使用 `marked`，显式保持 `gfm:true` 和 `breaks:true`。必须支持：

- h1–h6、段落、加粗、斜体、删除线、水平线。
- 有序/无序列表、嵌套列表、GFM 任务列表 `- [x]` / `- [ ]`；任务项输出只读 disabled checkbox，不做可编辑任务应用。
- GFM 表格与左右/居中对齐，表格宽于正文时只在表格局部滚动。
- 引用块：单层 `>` 淡黄底、无左线；嵌套 `>>` 才出现左线，精确样式见第十二节。
- 普通链接、图片、引用式链接、行内 HTML。DOMPurify 移除 script、on* 事件属性、危险链接；KaTeX 所需 `style` 显式保留。这里只额外放行 style，不是拒绝所有其它正常安全属性。
- 单个换行在段落内也生成 `<br>`，来自 `breaks:true`。

安全顺序：任何不可信 HTML 第一次进入自建临时 DOM 之前先清洗；完整装饰后再清洗一次；Mermaid 严格安全边界独立处理。不能恢复原站“到管线末尾才首次清洗”的时机漏洞。

## 二、公式（KaTeX）

### 文章正文

- 行内 `$...$`、独立/显示模式 `$$...$$`；只自动识别美元定界符。
- 代码块与行内代码中的公式也渲染，调用 `highlightCodeWithFormulas`；`codeFormulas` 在忠实复现模式默认 **true**。可保留显式 false 的可选参数，但不可让通用代码保护默认值覆盖本规范。
- 顺序：先保护代码整体，提取正文公式；代码内再抽取公式占位 → highlight.js 高亮 → 还原 KaTeX。复制代码必须用原始公式替代视觉节点。
- GPT/聊天转义清理由 `formulaNormalize.ts` 的 `cleanFormulaSource` 实现：修正 `J\_{GRPO}` 这类误转义下划线、聊天产生的双反斜线竖线、`\*` 等；保护 `\text{...}` 内合法的 `\_`，保留 TeX 有意义的命令和换行，不能全局删除反斜线。
- UTF-8 安全的占位载荷，支持公式中的中文；`throwOnError:false`，一条错误公式不能阻断文章。
- 渲染外层 `.katex-wrap[data-src]` 保留可复制的带定界符公式源码（经过约定的清理，不承诺字节级等同作者原文）；公式外观依赖 KaTeX CSS 与字体。
- 悬停公式时左上角显示“复制公式”按钮；按钮从 data-src 复制 `$...$` 或 `$$...$$`，不复制 MathML/HTML 重复文字。

### Markdown 解析器工具页

在文章管线之外，工具额外调用 `normalizeFormulaDelimiters`：将 `\(...\)`、`\[...\]`、聊天工具多余反斜线包裹（用户记作 `\公式\`）以及判断为数学的独立 `[公式]` 规范为 `$` / `$$`。不要把普通数组、Markdown 链接/图片、代码里的方括号一律改成公式。明确区分工具输入规范化与文章正文美元解析。

## 三、代码块

- `highlight.js/lib/common` 常用语言集合；有语言标记按标记处理，无标记时自动检测；主题为 `highlight.js/styles/github.css`。
- 右上角复制代码按钮，内容只取 `pre code`，不含按钮、渲染公式的可视文字或双份 MathML。
- 代码内公式仍可正常高亮与复制；通过源码 data-src 还原。
- 未启用行号、行高亮等扩展；不要擅自加入这些视觉元素。
- 无效语言或格式异常时保留可读源码，不能丢内容。

## 四、Mermaid

- fenced `mermaid` 代码块替换为 SVG；仅遇到图表时动态 import。
- `startOnLoad:false`、`securityLevel:'strict'`、`theme:'default'`；不自定义 Mermaid 正常图表配色，不开放危险 click 回调或降低到 loose。
- 图类型由 Mermaid 自身支持的语法决定，如 flowchart、sequence、gantt、class、state；不把实现限制成只支持 flowchart。
- 每次渲染有唯一 ID，跨文章切换也不冲突。SVG 留下 data-idx 供选区还原。
- 失败显示原始图表代码（用 textContent），背景 `rgba(255,248,220,0.3)`；不能留白或删除用户内容。
- DOMPurify 与 Mermaid 严格模式分开负责安全。盲目对最终 SVG 套通用清洗可能删除 foreignObject 标签文字；不能通过放松安全来换显示。

## 五、目录、侧栏大纲与标题

- 独占一行的纯文本 `[toc]`，大小写不敏感，生成文档内可折叠目录；`` `[toc]` `` 行内代码不替换。
- 目录默认收起，整行标题是可访问 button，更新 aria-expanded；条目点击跳转。
- 目录编号用 CSS 计数器；h1 不编号，h2→h6 规则与色值见后文。
- 左侧大纲从最终渲染 h1–h6 提取，固定侧栏；不能生成与正文不同的锚点；点击使用稳定滚动。
- 标题自动有唯一 `id` 与 `data-sec` 序号，全局搜索用它们定位文章内标题。仅生成 data-sec 不等于已经实现全局搜索。
- 无编号标题补 `1.` / `1.1` / `1.1.1`；已有 `1.`、`1.1`、`一、`、`第一章`、`（一）` 等不重复加序号。h1–h6 均参与层级，需处理中文/英文标点。
- 标题 ID 在可见自动编号之前生成，目录与大纲引用同一结果；混合手动编号和自动编号、重复标题要单独验算。
- 原站源码：`OutlineGenerator.vue`、`markdownDocument.ts`；原行号 99–130 等仅是定位提示，不作为今后稳定 API。

## 六、彩虹括号与配对高亮

保留 `src/utils/bracketHighlight.ts` 的语义，不只画出彩色字符：

- 悬停任一括号，同时高亮同组另一括号；未配对时红色提示。
- 正文只配对高亮、不改字色。
- 代码块：嵌套两层及以上才加彩虹色，一层保持原色，4 色循环。
- 公式：一对保持原色；多对且无嵌套统一 `#66CCFF`；有嵌套由内向外红 → 青 → 藕 → 浅蓝 → 粉。
- 矩阵/分段环境自带定界符不染色；支持 `(a,b]`、`[a,b)` 区间；测试 KaTeX DOM 而非只查源码字符串。
- 支持半角括号及全角 `（）`、`⟨⟩`、`∣`、`‖`、`∥`、`|`；字符串、注释、正则按 hljs 标注跳过，不按纯字符误配。
- 配对范围限制在段落、列表项、表格单元格、标题等块内，不跨块错配。

## 七、图片、链接与滚动

- 相对 `assets/...` / `./assets/...` 根据 Markdown 来源目录或显式 assetBase 映射到发布路径，并拼接部署 base。
- 原站 `article/md/...` 对应 `public/article/assets/`；其他目录按相邻 assets 处理。不得在新项目里硬编码 G 盘。
- `http(s)`、`data:`、`//`、`/` 开头地址保持已有语义；安全协议清洗仍照常执行，不能为了“原样”保留 javascript:。
- 全部图片 `loading="lazy"` + `decoding="async"`。
- `#锚点` 使用平滑稳定滚动，限时 ResizeObserver 校正异步图片/图表造成的位移；wheel/touchmove 用户接管后停止；卸载与换页清理。
- `#/` 交 Vue Router，不当普通页内锚点拦截；保留 Ctrl/Meta/Shift/Alt 和非左键的浏览器默认行为。

## 八、复制能力

全部需要：代码复制、公式复制、右侧复制 Markdown 全文、正文选区 Ctrl+C 还原 Markdown。

1. 全文直接复制所请求的 Markdown 原文件，不能从渲染 HTML 逆推。
2. 选区使用 Turndown + GFM；公式 → 带美元定界符源码；Mermaid SVG → 原 `mermaid` 围栏代码块；表格 → pipe table。
3. 仅在选区位于正文且确有文字时拦截，不影响其它输入区域。cloneContents 后移除按钮与装饰的影响；代码内 KaTeX 先替换为 data-src。
4. 转换器惰性创建复用，标题序号点转义按原约定恢复；剪贴板不可用时降级，失败不冒充成功。
5. 注意原组件对跨父容器选区、只有部分数学节点的选区、失败回退需验收，不以依赖已安装代替行为验证。

## 九、文章页阅读 features

`BlogPage.vue` 的文章模式开启：

- 左侧大纲。
- 右侧站点导航：首页 / 文章导航 / 工具箱级联菜单。分类与内容来自目标项目数据；不存在的功能不生成死链接。
- 回到顶部 + 环形阅读进度（44px 按钮，青绿进度环）。
- 复制 Markdown 全文。
- 字数：从源 Markdown 去标记后，汉字逐字 + 英文按词；不使用原始字符总数冒充。与原站一致时，代码、公式、表格等剥离规则采用 textStats.ts 并明确统计口径。
- 文章文件名大标题与正文 h1–h6 分开；正文 h1 红、h2 蓝、h3 青、h4 藕，h5/h6 主题默认。

用 feature flags 组合嵌入/文章页；完整文章默认全部打开，局部美化任务不强行增加全站导航。

## 十、CSS 基础与导入顺序（必须）

```ts
import 'github-markdown-css/github-markdown.css'; // 原站 auto 版
import 'highlight.js/styles/github.css';
import 'katex/dist/katex.min.css';
import './style.css'; // 站点自己的全部覆盖，必须最后导入
```

复现次序：**基础主题 → 代码高亮 → KaTeX → 自定义覆盖**。基础依赖样式不要藏进异步组件而让顺序随路由改变。自定义覆盖可在 style.css 内依序引入分文件。

用户不需要暗色模式：保留原站 auto 版来源说明，但最终站点用 `data-theme="light"` 与 `.markdown-body` 的浅色变量覆盖锁定浅色。仅写 `color-scheme:light` 不会阻止依赖的 prefers-color-scheme CSS。原暗色代码括号色仅作历史记录，不激活；不要开发主题切换。

### GitHub 浅色基线

| 项目 | 精确值 |
| --- | --- |
| 正文字色 | `#1f2328` |
| 辅助文字 | `#636c76` |
| 正文链接 | `#0969da` |
| 正文背景 | `#ffffff` |
| 弱背景（表格斑马纹、kbd） | `#f6f8fa` |
| 边框 | `#d0d7de` |
| muted 边框 | `#d0d7deb3` |
| mark 背景 | `#fff8c5` |
| 字体 | `-apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans", Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji"` |
| 正文字号 / 行高 | `16px / 1.5` |

以被锁定版本的 github-markdown CSS 为依据；若升级依赖改变默认值，要显式覆盖以上验收值。

### 站点核心色板

| 名称 | 色值 | 用途 |
| --- | --- | --- |
| 主蓝 / 天依蓝 | `#66CCFF` | 导航底、h2、平级公式括号、回顶箭头、复制图标 |
| 青绿 / 初音绿 | `#39C5BB` | h3、目录左边、进度环、成功态 |
| 青绿深 / 浅蓝深 | `#2EAAA0` / `#4BBDF5` | 分类 hover / 工具箱首页 hover |
| 淡蓝 | `#B2D8E8` | 列表项、页面渐变、公式浅色括号 |
| 链接蓝 | `#409EFF` | 文件名大标题、公式/代码复制按钮 |
| 页面浅蓝 | `#F2FBFF` | 白底按钮 hover |
| 深青字 | `#1C3A4A` | 淡蓝按钮文字 |
| 红 / 阿绫红 | `#EE0000` | h1、代码彩虹第二色 |
| 藕粉 | `#ECAD9E` | h4 |
| 紫 / 藕紫 | `#6B5AA8` / `#AA6680` | 代码彩虹第一色 / 公式第三色 |
| 粉 | `#FFC0CB` | 公式第五色 |

## 十一、文章页背景与精确布局

正文列纯白 `#fff`；**整个文章页外容器**铺三层渐变，不只给侧栏涂一个近似浅蓝背景：

```css
.is-article {
  background-image:
    radial-gradient(ellipse at -20% 140%, rgba(102,204,255,.2) 30%, rgba(178,216,232,.3) 50%),
    radial-gradient(ellipse at 60% 40%, rgba(57,197,187,.3) 10%, rgba(44,70,76,.1) 60%),
    linear-gradient(-45deg, rgba(102,204,255,.3) -10%, rgba(178,216,232,.4) 80%);
}
.is-article .markdown-main {
  width:72%; margin-left:14%; margin-right:14%; padding:0 3%; background:#fff;
}
.markdown-outline {
  position:fixed; width:14%; height:100%;
  padding-left:.6%; padding-right:1%;
}
@media (max-width:900px) {
  .is-article .markdown-main { width:100%; margin:0; padding:0 6%; }
  .markdown-outline { display:none; }
}
```

原站用 `-webkit-radial-gradient(-20% 140%, ellipse, ...)` 旧语法；新实现用上面的标准写法，不丢渐变层/位置/透明度。正文 box-sizing 应保持 border-box，宽内容设 min-width:0，不能意外把 72% 加上额外 padding。

compact 嵌入版独立：`width:min(100%,940px)`、`padding:clamp(20px,4vw,48px)`、`border:1px solid rgba(102,204,255,.24)`、`border-radius:18px`、`box-shadow:0 12px 30px rgba(44,70,76,.08)`。不可拿 compact 的 940px 作为文章 72% 布局的默认替代。

### 文件名大标题

```css
.markdown-title {
  color:#409eff; font-size:48px; font-weight:700;
  text-shadow:2px 2px 4px rgba(102,204,255,.5);
  margin:15px 0 30px; animation:fade-in 2s ease-in-out;
}
@keyframes fade-in { from { opacity:0; } to { opacity:1; } }
```

### 正文标题

| 级别 | 色值 | 字号 / 字重 | 下边线 |
| --- | --- | --- | --- |
| h1 | `#EE0000` | `2em / 600` | `1px solid #d0d7deb3` |
| h2 | `#66CCFF` | `1.5em / 600` | 同上 |
| h3 | `#39C5BB` | `1.25em / 600` | 无额外边线 |
| h4 | `#ECAD9E` | `1em / 600` | 无额外边线 |
| h5 | `#1F2328` | `.875em / 600` | 主题 |
| h6 | `#1F2328` | `.85em / 600` | 主题 |

## 十二、代码与引用精确样式

```css
.markdown-body pre {
  position:relative; font-size:.712em;
  background-color:rgba(178,216,232,.05); box-shadow:none;
}
.markdown-body code {
  color:#333; background-color:#fffafa; border:1px solid #ddd;
  border-radius:2px; padding:0 2px; margin:0 2px;
  font-family:Consolas,'Courier New',monospace; font-size:1em;
  box-shadow:none; box-sizing:border-box;
}
.markdown-body code .code-katex { color:#333; }
.markdown-body pre code .code-katex { font-size:1.4em; }
.markdown-body blockquote {
  font-style:normal; font-family:inherit; font-size:1em;
  padding-left:2em; padding-right:2em; margin-left:0;
  border-left:none; background-color:rgba(255,248,220,.2);
}
.markdown-body blockquote blockquote {
  font-style:normal; font-family:inherit; font-size:1em;
  border-left:4px solid hsl(60,40%,70%);
  padding-left:calc(2ch - 4px); padding-right:0;
  margin-left:-4px; border-radius:0;
}
```

代码块 16px × .712 ≈ 11.4px。该数值是用户指定的忠实复现值，不能静默换回旧骨架 .88em。半透明蓝在白底合成近 `#FBFDFE`，引用淡黄近 `#FFFEF8`，嵌套线近 `#D1D194`；保留 rgba/hsl 原始值而非只用近似合成色。

### highlight.js github.css 语法色

| Token | 色值 |
| --- | --- |
| 基础 | `#24292e` |
| 关键字 | `#d73a49` |
| 类/函数名 | `#6f42c1` |
| 数字/属性/变量/操作符 | `#005cc5` |
| 字符串/正则 | `#032f62` |
| 内置函数/符号 | `#e36209` |
| 注释 | `#6a737d` |
| 标签/选择器/引号 | `#22863a` |
| 主题高亮底色 | `#ffffff`，代码块最终由上面的半透明蓝覆盖 |

精确 token 颜色要求高亮版本固定；升级不能只看 CSS 文件同名。代码行内与块内背景受主题选择器级联影响，必须看 computed style 和截图，不能仅搜索色值。

## 十三、文中目录精确样式

```css
.markdown-body .md-toc {
  width:100%; max-width:18cm; margin:1.5em auto 2em;
  padding:1.2em 1.5em 1.4em;
  border:1px solid rgba(102,204,255,.25); border-left:4px solid #39c5bb;
  border-radius:10px; background-color:#feffff;
  background-image:
    radial-gradient(ellipse at -20% 140%, rgba(102,204,255,.025) 30%, rgba(178,216,232,.045) 50%),
    radial-gradient(ellipse at 60% 40%, rgba(57,197,187,.035) 10%, rgba(44,70,76,.008) 60%),
    linear-gradient(-45deg, rgba(102,204,255,.045) -10%, rgba(178,216,232,.055) 80%);
  color:#17394e; font-size:9.5pt; line-height:1.8;
  box-shadow:0 4px 18px rgba(44,70,76,.05);
}
```

标题整行是折叠按钮：文字 `#174F73`，hover `#0F5F84`，下边线 `1px solid rgba(57,197,187,.3)`；字体 `'华文黑体','微软雅黑',sans-serif`，`1.55em/700`，letter-spacing `.12em`。

| 层级 | 文字色 | 编号色 | 字号 / 字重 | 格式 |
| --- | --- | --- | --- | --- |
| h1 | `#174F73` | 无编号 | `11pt / 700` | — |
| h2 | `#174F73` | `#087F78` | `10pt / 700` | 1、2（逐条数字，非中文顿号前缀） |
| h3 | `#087F78` | `#087F78` | `9.5pt / 400` | 1.1 |
| h4 | `#367781` | `#367781` | `9pt / 400` | 1.1.1 |
| h5 | `#38566B` | `#38566B` | `9pt / 400` | 1.1.1.1 |
| h6 | `#38566B` | `#38566B` | `9pt / 400` | 1.1.1.1.1 |

hover 下划线色 `rgba(23,79,115,.45)`，text-underline-offset `3px`；默认只显示标题行。打印完整展开目录、不输出复制按钮，目录结束后按原站 print 规则分页。

## 十四、括号色表与复制按钮

### 括号

```css
.md-bracket-color-1 { color:#6B5AA8; }
.md-bracket-color-2 { color:#EE0000; }
.md-bracket-color-3 { color:#174F73; }
.md-bracket-color-4 { color:#087F78; }
.md-bracket-formula-flat { color:#66CCFF; }
.md-bracket-formula-nested-1 { color:#EE0000; }
.md-bracket-formula-nested-2 { color:#39C5BB; }
.md-bracket-formula-nested-3 { color:#AA6680; }
.md-bracket-formula-nested-4 { color:#B2D8E8; }
.md-bracket-formula-nested-5 { color:#FFC0CB; }
```

成功配对 hover：背景 `rgba(255,214,102,.55)`，box-shadow `0 0 0 1px rgba(214,158,0,.55)`。未配对 hover：`rgba(255,120,120,.35)`，`0 0 0 1px rgba(220,80,80,.5)`。

原暗色历史值完整保留于记录：color-1 `#B39DDB`、color-2 `#D9534F`、color-3 `#66CCFF`、color-4 `#39C5BB`；配对 `rgba(227,179,65,.3)` + 描边 `rgba(227,179,65,.75)`；未配对 `rgba(248,81,73,.3)` + 描边 `rgba(248,81,73,.7)`；公式色不变。**本次明确不需要暗色，不启用这些替换。**

### 公式复制按钮

```css
.formula-copy-btn {
  position:absolute; top:-11px; left:-11px; width:20px; height:20px;
  border-radius:5px; border:1px solid rgba(102,204,255,.6);
  background:rgba(255,255,255,.95); color:#409eff;
  box-shadow:0 2px 6px rgba(44,70,76,.18); opacity:0;
}
.formula-copy-btn:hover { border-color:#66ccff; background:#eefaff; }
.formula-copy-btn.is-copied { border-color:#39c5bb; background:#39c5bb; color:#fff; }
```

时序核对：用户说明注释中的“悬停 0.5 秒后出现”与源码不符；原 `style.css` 实际是**进入立即出现，离开后延迟 0.5 秒隐藏**，过渡约 .15s。忠实复现采用源码时序；键盘 focus-visible 也显示。不是用 visibility 永久挡住按钮。

### 代码复制按钮

top/right `8px`、padding `4px 8px`、border-radius `6px`、font-size `12px`。

| 状态 | 背景 | 文字 | opacity |
| --- | --- | --- | --- |
| 常态 | `rgba(102,204,255,.18)` | `#409EFF` | .6 |
| hover | `rgba(102,204,255,.32)` | `#409EFF` | 1 |
| 已复制 | `rgba(57,197,187,.25)` | `#2EAAA0` | 反馈态 |

## 十五、右侧导航与悬浮控件

### ArticleNav 级联菜单

| 部位 | 精确值 |
| --- | --- |
| 导航条 | `#66CCFF`；shadow `0 4px 14px rgba(102,204,255,.4)` |
| 图标 | `#FFFFFF` |
| 按钮 hover | `rgba(255,255,255,.2)` |
| 按钮激活 / 展开 | `rgba(255,255,255,.28)` / `rgba(255,255,255,.25)` |
| 菜单面板 | `#FFF`；shadow `0 6px 20px rgba(0,0,0,.15)`；radius `10px` |
| 分类菜单头 | `#39C5BB` 背景、白字 |
| 一级分类 | `#39C5BB`；hover `#2EAAA0` |
| 一级工具箱首页 | `#66CCFF`；hover `#4BBDF5` |
| 二级文章 | `#B2D8E8` 背景、字 `#1C3A4A`；hover `#9CC6DB` |
| 悬浮提示 | `rgba(0,0,0,.75)` 背景、白字 `12px` |

桌面层级展开到左侧避免越出右屏；键盘/点击可达，不仅依赖 hover。内容数据不能沿用原站不存在于目标项目的链接。

### 回到顶部与环形阅读进度

- `44×44px` 白底圆形；shadow `0 2px 10px rgba(0,0,0,.08)`；hover `#F2FBFF`。
- 箭头 `#66CCFF`；progress ring `#39C5BB`、stroke-width `3`。
- 根据文档或标记的实际滚动容器计算 0–1 进度；短文不可出现 NaN/除零；监听 scroll/resize，异步正文后刷新，卸载清理。

### 复制 Markdown 全文

`40×40px` 白底圆形，同回顶阴影；图标 `#66CCFF`；hover `#F2FBFF`；成功态背景 `#E6FBF8`、图标 `#39C5BB`。位置为右侧浮动控件，不只放正文顶部一颗文字按钮。

### 字数胶囊

文字 `#39C5BB`、`13px/600`；背景 `rgba(255,255,255,.92)`；shadow `0 2px 8px rgba(0,0,0,.06)`；radius `999px`。统计原文清理后的汉字+英文词，不含源码标记计数冒充。

## 十六、范围、复用与完成定义

- 个人博客首页仍保留插画开场、浅渐变、白色卡片等原主题；本次精确规则重点是文章阅读界面。没有授权插画就用渐变，不打包原作者的私人素材。
- 已有框架可沿用，必须移植相同结构、色值与交互结果；不强制换成 Vue。
- 完整复现需逐项验收上面一至十五节。`references/implementation-status.md` 记录当前资源实际状态，不能把“规范已写入”说成“所有交互已完成”。
- 代码/公式内数学开启是本用户明确要求，旧 skill 的默认关闭策略作废；精确字号/72% 布局和颜色优先于旧“可读变体”；全局搜索、解析器输入规范化、选区复制、级联导航、进度环与字数不得在完整文章交付中悄悄省去。
- 同时保持第一 DOM 前清洗、加载竞态保护、错误回退、资源 base 与本地敏感文件隔离。样式忠实不代表恢复安全缺陷。
- 每次交付运行真实构建、浏览器功能测试和 computed style 对照。未实现或未验证的能力必须明确列出。
