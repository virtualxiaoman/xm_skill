# 视觉系统入口

**完整精确值以 [requirements.md](requirements.md) 第十至十五节为准，实施之前必须阅读全文对应部分。**

本用户已把原站配色、字号和布局从“参考选项”改为默认复现要求。旧版可读性变体不再是默认：不把 #66CCFF 标题替换为深蓝，不把 .712em 代码字号改成 .88em，不用 max-width:940px 的 compact 方案替代文章 72% 正文列。

核心识别：天依蓝 #66CCFF / 初音绿 #39C5BB / 阿绫红 #EE0000，白纸正文，三层浅色渐变包围，彩色层级标题，Typora 风格折叠目录，右侧蓝色站点导航和白色圆形浮动控件。

- 原站首页插画 cover 开场、第二屏入口与个人信息、白色圆角卡片继续可复用。图片需授权，无图时用渐变。
- 文章严格使用 72% / 14% / 14% 配比与 900px 断点；compact 是另一显式模式。
- GitHub Markdown 浅色 16px / 1.5；按固定导入顺序加载，最后由 fidelity.css 实现规定覆盖。
- 不需要暗色：锁定 light variables，禁用系统暗色对括号的改色。规范中留的暗色色表仅是来源记录。
- 动效跟随原站标题淡入与轻 hover，尊重 reduced-motion 可访问性偏好；不加入行号、行高亮或侵入性装饰。

骨架 CSS 已同步主要精确值，缺少的级联/进度/字数控件在 reference-components 有源码供接线；查看 implementation-status.md，不能凭本页宣称完全完成。

旧 references/previews 的截图是之前可读变体的历史预览，不作为本次精确验收基准。更新后的视觉 QA 记录由 validation-current.md 说明。
