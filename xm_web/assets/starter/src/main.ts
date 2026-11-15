import { createApp } from 'vue';
import { createRouter, createWebHashHistory } from 'vue-router';
import App from './App.vue';
import Home from './Home.vue';
import Reader from './Reader.vue';
import 'github-markdown-css/github-markdown.css';
import 'highlight.js/styles/github.css';
import 'katex/dist/katex.min.css';
import './style.css';
const router = createRouter({
  history: createWebHashHistory(),
  routes: [{ path: '/', component: Home }, { path: '/article/:id', component: Reader }, { path: '/:pathMatch(.*)*', redirect: '/' }],
  scrollBehavior: () => ({ top: 0 }),
});
createApp(App).use(router).mount('#app');
