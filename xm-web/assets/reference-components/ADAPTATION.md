# 原站阅读组件的接线说明

这份目录保存源码证据和迁移材料，不是另一个可以直接 npm run dev 的项目。参考组件未复制到 starter/src；不要把“文件存在”当成“功能已启用”。完整要求先读 ../../references/requirements.md。

## 一条可行的整合路径

1. 原 `BlogPage.vue` → `markdown/MarkdownDocumentPage.vue` → `mdViewer.vue`、OutlineGenerator、复制/字数/回顶控件。先决定替换骨架 Reader 还是移植其事件与功能，保留骨架已有的失败状态、代数竞态保护和卸载清理。
2. 工具函数使用 starter/src/utils 中的安全修正版本，尤其 markdownRenderCore 在首次自建 DOM 前清洗。不要拿原站无安全修正版本覆盖它。
3. mdViewer 的 import 路径依赖同层级 components/utils；若保持原目录层级，可重用已有函数。`markdownPreview.ts` 只是完整文档渲染的别名。
4. 需要安装 `turndown`、`turndown-plugin-gfm` 与 `@types/turndown`，并加入保留的类型声明。原站的参考范围为 ^7.2.4、^1.0.2、^5.0.6；不是最新版本声明，优先目标项目兼容版本。
5. 依赖主题从 main.ts 按唯一顺序导入；移植 mdViewer 时删除组件里的重复 CSS import；style.css 最后加载。原组件自带 style 可整理进覆盖层，保留规定精确值。
6. ArticleNav 需要目标项目 `articlesByCategory/categoryNames`、`toolCategoryNames/toolsByCategory` 数据适配。不要复制原站文章清单或生成死链接；主页、文章、工具路由与搜索入口要接实际存在页面。
7. 回顶使用原 BackToTopButton，阅读内容变化后更新 refreshKey；仅留一个实例。字数由 stripMarkdown + countHanzi + countWords 构成，正文、复制与统计应共享同份源请求。
8. 圆形全文复制/字数浮于右侧，不能仅挂在看不到的位置；监听、定时器、ResizeObserver 在换页/卸载时清理。复制成功只在剪贴板真实成功后反馈。

## 解析器规范化入口

```ts
import { normalizeFormulaDelimiters } from './utils/formulaNormalize';
import { renderMarkdownDocument } from './utils/markdownDocument';

// 只在 Markdown 工具页输入端调用，不自动改写文章源文件。
const normalized = normalizeFormulaDelimiters(editorText);
const rendered = await renderMarkdownDocument(normalized.text, { codeFormulas: true });
// 保留 normalized.text 用于工具的“复制规范化 Markdown”；原文章全文仍复制原文件。
```

工具预览也使用同一代码/公式/TOC/括号/选区事件委托，不另写缺功能的解析器；加入防抖、请求代数与失败状态。

## 搜索章节定位契约

搜索索引条目保存文章 key 与标题序号 sec；过滤/渲染标题的规则必须与文档编排一致。路由到目标文章后，等待当前那篇文章渲染完成，限定在正文根节点内查找：

```ts
const heading = articleRoot.querySelector(`[data-sec="${Number(hit.sec)}"]`);
if (heading) stopPreviousScroll = scrollToElementStable(heading);
```

Number 必须是校验过的正整数；等待应有截止时间并随路由变化取消。异步文档未渲染不能只 nextTick 一次就放弃。保留 hash 路由语义，不把 #/ 当正文锚点。这里不是现成全文搜索索引或搜索组件。

## 选区复制注意

原 mdViewer 使用 Turndown + GFM，data-src 还原公式、data-idx 还原 Mermaid，转换前 clone 并删除复制按钮。迁移时保留此行为，并优先使用 ClipboardEvent.clipboardData 的同步 setData('text/plain', markdown)，否则复用可靠 copyText 降级；不要裸调用可能不存在的 navigator.clipboard。选区只在正文内拦截，测试公式、图表、表格与代码混合选区。

源代码中针对特定应用的类名和 features 用法可调整，结果必须与规范一致。完整支持需要类型检查、构建、实际浏览器与样式验收。
