<template>
  <main>
    <section class="hero" :style="site.heroImage ? { backgroundImage: `linear-gradient(110deg,rgba(14,52,67,.40),rgba(57,197,187,.08)),url(${base}${site.heroImage})` } : {}">
      <span class="eyebrow">PERSONAL NOTES / TECH & LIFE</span>
      <h1>{{ site.title }}</h1><p>{{ site.subtitle }}</p>
      <a class="scroll-hint" href="#content" aria-label="浏览文章">向下探索 <span aria-hidden="true">↓</span></a>
    </section>
    <section id="content" class="home-section">
      <div class="home-grid"><div>
        <p class="eyebrow">A LITTLE COLLECTION</p><h2>把想法留下来</h2>
        <p class="muted">从一段笔记开始，让知识慢慢连成线。</p>
        <div class="card-grid"><RouterLink v-for="(article,index) in articles" :key="article.id" class="entry-card" :to="`/article/${article.id}`">
          <span class="card-number">0{{ index + 1 }}</span><span class="tag">{{ article.category }}</span>
          <h3>{{ article.title }}</h3><p>{{ article.summary }}</p><span class="card-link">开始阅读 ↗</span>
        </RouterLink></div>
      </div><aside class="profile-card"><span class="avatar-mark" aria-hidden="true">青</span><h2>你好，欢迎来访。</h2><p>{{ site.description }}</p><hr><p class="muted">轻量的界面，认真写下的内容。</p><span class="tag">这里是演示骨架</span></aside></div>
    </section>
  </main>
</template>
<script setup lang="ts">
import { site, articles } from './site';
const base = import.meta.env.BASE_URL;
</script>
