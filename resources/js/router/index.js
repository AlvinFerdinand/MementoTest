import { createRouter, createWebHistory } from 'vue-router';
import Portfolio from '../views/Portofolio.vue';
import Menu from '../views/Menu.vue';
import Checkout from '../views/Checkout.vue';

const routes = [
  { path: '/', component: Portfolio },
  { path: '/menu', component: Menu },
  { path: '/checkout', component: Checkout }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
