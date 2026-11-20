<template>
  <div class="reading-layout is-article">
    <aside class="reader-outline markdown-outline"><nav aria-label="文章大纲"><p class="eyebrow">ON THIS PAGE</p>
      <a v-for="h in headings" :key="h.id" :href="`#${h.id}`" :style="{ paddingInlineStart: `${(h.level - 1) * 12 + 8}px` }" @click.prevent="jump(h.id)">{{ h.text }}</a>
    </nav></aside>
    <main class="reading-paper markdown-main">
      <RouterLink class="back-link" to="/">← 所有文章</RouterLink>
      <p class="eyebrow">{{ article?.category || '阅读' }}</p><h1 class="article-title markdown-title">{{ article?.title || '文章不存在' }}</h1>
      <div class="article-meta"><span>{{ raw.length.toLocaleString() }} 字符（含标记）</span><button type="button" @click="copyAll" :disabled="loading || !raw">{{ copyLabel }}</button></div>
      <p v-if="loading" role="status">正在整理这篇文章…</p>
      <p v-else-if="error" role="alert">{{ error }}</p>
      <details v-if="headings.length && !hasInlineToc" class="mobile-outline"><summary>文章大纲</summary><nav aria-label="移动端文章大纲"><a v-for="h in headings" :key="h.id" :href="`#${h.id}`" @click.prevent="jump(h.id)">{{ h.text }}</a></nav></details>
      <article ref="body" class="markdown-body" data-theme="light" :aria-busy="loading" v-html="html" @click="onClick" @mouseover="onOver" @mouseout="onOut"></article>
    </main>
    <aside class="site-rail"><RouterLink to="/">首页</RouterLink><RouterLink v-for="a in articles" :key="a.id" :to="`/article/${a.id}`">{{ a.category }}</RouterLink></aside>
    <button type="button" class="back-top" aria-label="回到顶部" @click="toTop">↑</button>
    <span class="sr-only" aria-live="polite">{{ copyLabel }}</span>
  </div>
</template>
<script setup lang="ts">
import { computed, onBeforeUnmount, ref, watch } from 'vue';
import { useRoute } from 'vue-router';
import { articles } from './site';
import { renderMarkdownDocument } from './utils/markdownDocument';
import { handleCodeCopyClick } from './utils/codeCopy';
import { handleFormulaCopyClick } from './utils/formulaCopy';
import { handleTocToggle } from './utils/markdownToc';
import { clearBracketHighlight, highlightBracketPair } from './utils/bracketHighlight';
import { copyText } from './utils/clipboard';
import { scrollToElementStable } from './utils/stableScroll';
const route = useRoute();
const article = computed(() => articles.find(a => a.id === route.params.id));
const raw = ref(''), html = ref(''), error = ref(''), loading = ref(false), copyLabel = ref('复制 Markdown');
const body = ref<HTMLElement | null>(null);
let generation = 0, controller: AbortController | undefined, stopScroll: (() => void) | undefined;
let feedbackTimer: ReturnType<typeof setTimeout> | undefined;
const hasInlineToc = computed(() => html.value.includes('class="md-toc '));
const headings = computed(() => {
  const doc = new DOMParser().parseFromString(html.value, 'text/html');
  return Array.from(doc.querySelectorAll('h1,h2,h3,h4,h5,h6')).map(h => ({ id: h.id, text: h.textContent || '', level: Number(h.tagName[1]) }));
});
watch(() => article.value?.source, async source => {
  const id = ++generation; controller?.abort(); stopScroll?.();
  html.value = ''; raw.value = ''; error.value = ''; loading.value = false;
  if (!source) { error.value = '没有找到这篇文章，请返回首页。'; return; }
  controller = new AbortController(); loading.value = true;
  try {
    const response = await fetch(import.meta.env.BASE_URL + source, { signal: controller.signal });
    if (!response.ok) throw new Error(`HTTP ${response.status}`);
    const sourceText = await response.text();
    const rendered = await renderMarkdownDocument(sourceText, { source });
    if (id !== generation) return;
    raw.value = sourceText; html.value = rendered.html;
  } catch (e) {
    if (id === generation && !(e instanceof DOMException && e.name === 'AbortError')) error.value = '文章暂时无法加载，请稍后重试。';
  } finally { if (id === generation) loading.value = false; }
}, { immediate: true });
function jump(id: string) {
  const target = body.value && Array.from(body.value.querySelectorAll('[id]')).find(el => el.id === id);
  if (!target) return;
  stopScroll?.(); stopScroll = scrollToElementStable(target, { behavior: matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth' });
}
function onClick(event: MouseEvent) {
  if (event.button !== 0 || event.metaKey || event.ctrlKey || event.shiftKey || event.altKey) return;
  const target = event.target as Element | null;
  if (handleFormulaCopyClick(target) || handleCodeCopyClick(target) || handleTocToggle(target)) { event.preventDefault(); return; }
  const anchor = target?.closest('a[href^="#"]');
  const href = anchor?.getAttribute('href');
  if (href && !href.startsWith('#/')) {
    let id: string; try { id = decodeURIComponent(href.slice(1)); } catch { return; }
    if (id && body.value && Array.from(body.value.querySelectorAll('[id]')).some(el => el.id === id)) { event.preventDefault(); jump(id); }
  }
}
function onOver(event: MouseEvent) { highlightBracketPair(event.currentTarget as HTMLElement, event.target); }
function onOut(event: MouseEvent) { clearBracketHighlight(event.currentTarget as HTMLElement, event.target); }
async function copyAll() {
  const ok = await copyText(raw.value); copyLabel.value = ok ? '已复制源码' : '复制失败，请手动选择';
  clearTimeout(feedbackTimer); feedbackTimer = setTimeout(() => { copyLabel.value = '复制 Markdown'; }, 1600);
}
function toTop() { window.scrollTo({ top: 0, behavior: matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth' }); }
onBeforeUnmount(() => { ++generation; controller?.abort(); stopScroll?.(); clearTimeout(feedbackTimer); });
</script>
