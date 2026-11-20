# 完整复现验收

先读 requirements.md，再按 implementation-status.md 补齐未接线项。不得只用构建通过代替以下行为核验。

## 基础语法

- h1–h6、段落、粗/斜/删除、水平线；ordered/unordered/nested/task lists。
- task checkbox disabled；表格 left/center/right；引用式链接；合法内联 HTML；单换行生成 br。
- 一层 blockquote 无线淡黄，嵌套 4px 线，检查 computed style。
- script/onerror/javascript: 在首次临时 DOM 前拦截，正文/图表仍可读。

## 数学与代码

- 行内/块公式，Unicode，聊天转义清理且 text 下划线不误伤；畸形数学不让整篇失败。
- 默认 codeFormulas true：代码块与行内公式可视化；代码原文复制依旧保留美元定界。
- 显式 false 保留 shell/货币字面内容。不要把这条可选分支当默认。
- 原文不自动扩展其它定界符；工具预处理测试 \(\)、\[\]、双反斜线、数学方括号，同时保留数组、链接与围栏。
- common 高亮、有/无语言、GitHub token 色，代码按钮不混额外文字，无行号/行高亮。
- 公式 data-src、20px 复制按钮位置、进入显示/离开延迟 0.5s、成功色与真实复制结果。

## 图表、标题与配对

- flowchart/sequence/gantt/class/state 各至少一个；strict；重复进出唯一 SVG ID；错误回退原文。
- TOC 大小写/行内代码边界、初始 collapsed、button aria-expanded、全层级 CSS 编号。
- 大纲从最终 h1–h6 取；重复标题唯一 ID、data-sec 连续、自动/手写中文编号不重复；混合编号按结构核对。
- 搜索实际路由到正确文章，等待完成后定位指定 data-sec；仅产生属性不算完成搜索。
- 正文配对不染色；代码单层/嵌套四循环；字符串/注释/正则跳过；公式单对/平级/嵌套五色、矩阵/cases 不染定界符、半开区间、全角与竖线、跨块不配对；配对与未配对 hover 色。

## 图片、复制、阅读控件

- assets/、assetBase、部署子路径、中文文件名；绝对/protocol-relative/data 地址保留；所有图 lazy+async。
- 图片和图表异步撑高后锚点仍到位；用户滚动取消校正，#/ 不拦截；组件卸载无遗留监听。
- 代码复制/公式复制/原文件全文复制/正文 Ctrl+C 转 Markdown 四项实测：数学、图表、表格、混合选区；失败反馈真实。
- 右侧主页/文章/工具箱级联可用，分类列表正确，无原站死链接。
- 环形进度随滚动 0–1，短文/容器滚动无 NaN；圆形全文按钮与字数胶囊到位。
- 字数来源清理后的 Markdown：汉字逐字+英文词，与文字样例对照，不以源字符数冒充。

## 视觉与构建

- CSS 顺序基础→高亮→KaTeX→自定义；操作系统 dark 下仍是完全浅色（包括括号）。
- 文章三层渐变精确色位，72%/14%/14% + padding 3%，900px 以下 100% + padding 6%；compact 单独验证。
- 文件名标题 48px/#409EFF/阴影/2s 淡入，正文各级颜色尺寸、代码 .712em/半透明底、引用全部参数。
- TOC 18cm 宽/色/编号，四/五级彩虹色、hover 描边、复制按钮尺寸、导航与胶囊阴影：按 requirements.md 逐表核对。
- 1440px 与 390px 截图 + computed styles，无整页横溢；局部表格/代码/公式横滚。
- 字体资源实际加载、类型检查、生产构建、子目录生产预览；浏览器无 uncaught error。
- 所有尚未实施/未跑项如实报告；不把原站实现、参考组件和新站实际功能混为一谈。
