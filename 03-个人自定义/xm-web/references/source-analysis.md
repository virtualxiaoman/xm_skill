# 历史提炼记录（本次规范已更新）

本记录描述旧版抽取背景；codeFormulas 当前改为 true，精确样式以 requirements.md 为准，旧截图不作本次验收。

# 原博客分析与可迁移结论

本分析来自 `G:/Projects/Blog/azusa_front` 的本地源码，提取日期 2026-11-15。引用路径为审阅证据，不是 skill 运行依赖。原项目未修改。

## 网站搭建方式

- Vue 3 + TypeScript + Vite，Vue Router 使用 hash history。`src/App.vue` 承载 router-view 与全局搜索。
- `src/views/HomePage/index.vue` 组合 ArticleNav、Welcome、MainPage；欢迎屏插画与第二屏入口把个人风格和内容入口分开。
- `src/components/HomeNav.vue` 管理首页入口；`ArticleNav.vue` 管理固定站点导航与搜索入口。文章、工具、专题并存，但不要求新站复制全部栏目。
- `src/components/BlogPage.vue` 是轻封装，把正文路径和文章 features 交给 `markdown/MarkdownDocumentPage.vue`，后者组合正文、大纲、复制、字数和返回顶部。样式与能力通过 variant/features 复用。
- `public/article/md` 存原始文档，`public/article/assets` 放静态资源。`scripts/generate-articles.mjs` 与 `generate-dynamics.mjs` 在 predev/prebuild 生成目录/索引；新站应先建立单一内容清单，再按规模引入生成器。
- `vite.config.ts` 区分开发 `/` 与生产 `/blog/`；构建插件排除原站专用的全息模型与 WASM 资源。通用博客不应引入这些模型依赖或这套特殊发布过滤逻辑。

## Markdown 的独到之处

`markdownRenderCore.ts` 与 `markdownDocument.ts` 把语法处理和整篇编排拆开。文章阅读器 `components/mdViewer.vue` 与 Markdown 工具共享完整解析行为，目录/代码/公式/Mermaid 不各写一份。

阅读体验不仅是换 Markdown CSS：公式有源码保真、代码与数学保护、图表懒加载与降级、标题唯一锚点、文中可折叠目录、侧栏大纲、复制源码、括号配对悬停、图片懒加载后的稳定滚动。正文用 GitHub Markdown 做基础，叠加浅色代码、淡引用和层级彩色标题。

## 抽取范围

保留 11 个工具模块和正文增强 CSS，提供新的轻量 Vue 示例。未打包原站文章、账号、头像、角色插画、字体、PDF、音视频、全息模型、构建产物、依赖目录、Git 历史、环境变量或部署脚本。演示文章为新写的虚构内容，不是用户博客内容。

这是普通可发现的个人 Codex skill，附源码骨架。原路径是普通 Vite 仓库，没有 Site 工程所需 `.openai/hosting.json`，因此不把它包装成受管理的 artifact-template 或宣称已创建 Sites 模板。

## 继承与改进边界

继承：色彩、布局分工、共享渲染架构、源码复制与阅读辅助。

骨架有意改进：首次临时 DOM 前新增清洗，修复测试中发现的 onerror 可提前触发路径；旧版普通代码不默认渲染数学（本次已按要求改为默认 true）；浅色 Markdown CSS 明确锁定以免系统暗色导致正文与白纸面冲突；手机提供可展开大纲；字号/对比度比忠实复刻更稳妥；reader 提供加载失败、过期请求忽略与卸载清理；不附原站版权素材。

应按项目决定：编号规则与稳定 slug、选区复制是否覆盖浏览器默认复制、深色主题、全文索引、PDF 输出、第三方 HTML 信任策略。它们不是“复制几个文件”就已完成的能力。

生成骨架的参考预览见 `previews/home.png`、`previews/reader.png`、`previews/mobile.png`。这些预览不包含原博客个人插画。
