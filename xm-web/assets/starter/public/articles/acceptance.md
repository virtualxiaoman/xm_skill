[toc]

# Markdown 验收文档

## 重复标题

中文和 Unicode 公式：$\text{损失} = \alpha + \beta$。

## 重复标题

`[toc]` 和 `$HOME` 应为代码。

```js
const price = '$100 and $200';
console.log(price);
```

~~~txt
$HOME and $PATH
~~~

## 坏图表应显示源码

```mermaid
this is intentionally invalid mermaid
```

## 安全输入

<script>window.__mdXss = true</script>
<img src="missing-image" onerror="window.__mdXss=true">
<a href="javascript:window.__mdXss=true">不应执行</a>

## 明确的锚点

<a id="manual-target"></a>手动锚点应保留。[跳转](#manual-target)
