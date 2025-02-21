<template>
  <div class="app">
   
    <div class="promo-slider">
      <div class="slides" :style="{ transform: `translateX(-${currentPromoIndex * 100}%)` }">
        <div v-for="(banner, index) in promoBanners" :key="index" class="slide">
          <img :src="banner.image" :alt="banner.title" class="promo-image" />
        </div>
      </div>
     
      <div class="dots">
        <span
          v-for="(banner, index) in promoBanners"
          :key="index"
          :class="{ active: currentPromoIndex === index }"
          class="dot"
        ></span>
      </div>
    </div>

  
    <div class="menu-carousel">
      <button @click="prevMenu" class="nav-button">⬅</button>
      <div class="carousel-window">
        <div class="carousel-wrapper" :style="{ transform: `translateX(-${currentMenuIndex * (100 / itemsPerView)}%)` }">
          <div v-for="(menu, index) in menus" :key="menu.id" class="carousel-item">
            <img :src="menu.image" :alt="menu.name" class="menu-image" />
            <h2 class="menu-title">{{ menu.name }}</h2>
            <p class="menu-description">{{ menu.description }}</p>
            <p class="menu-price">Harga: {{ menu.price }}</p>
            <button class="buy-button" @click="buyMenu(menu)">Tambah</button>
          </div>
        </div>
      </div>
      <button @click="nextMenu" class="nav-button">➡</button>
    </div>

   
    <div class="cart">
      <h3 class="cart-title">Cart</h3>
      <div v-if="cart.length > 0">
        <div v-for="(item, index) in cart" :key="index" class="cart-item">
          <div class="item-info">
            <span class="item-name">{{ item.name }}</span>
            <span class="item-price"> {{ item.quantity }} x {{ formatCurrency(item.price) }} = {{ formatCurrency(item.price * item.quantity) }}</span>
          </div>
          <div class="item-actions">
            <button class="quantity-btn" @click="decreaseQuantity(index)">➖</button>
            <span class="item-quantity">{{ item.quantity }}</span>
            <button class="quantity-btn" @click="increaseQuantity(index)">➕</button>
          </div>
        </div>
        <div class="cart-total">Total: {{ formatCurrency(totalCart) }}</div>
        <button class="clear-cart" @click="confirmClearCart">
          🗑 Clear Cart
        </button>
        <button class="buy-cart" @click="goToCheckout">
          🛒 Buy
        </button>
      </div>
      <div v-else>
        <p class="empty-cart">Your cart is empty</p>
      </div>
    </div>

    
    <div v-if="showConfirm" class="modal-overlay">
      <div class="modal">
        <p>Ingin menghapus semua menu di dalam cart?</p>
        <button class="confirm-btn" @click="clearCart">Yes</button>
        <button class="cancel-btn" @click="showConfirm = false">No</button>
      </div>
    </div>

    
  </div>
  <!-- Footer -->
  <footer class="footer">
      <div class="footer-content">
        <p>&copy; 2025 Restoran Lezat. All Rights Reserved.</p>
        <ul class="footer-links">
          <li><a href="#">Tentang Kami</a></li>
          <li><a href="#">Kontak</a></li>
        </ul>
      </div>
    </footer>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';

const router = useRouter();
const menus = ref([]);
const cart = ref([]);
const showConfirm = ref(false);
const promoBanners = ref([
  { image: '/images/promo1.jpg', title: 'Promo 1' },
  { image: '/images/promo2.jpg', title: 'Promo 2' },
  { image: '/images/promo3.jpg', title: 'Promo 3' },
  { image: '/images/promo4.jpg', title: 'Promo 4' }
]);
const currentPromoIndex = ref(0);
const currentMenuIndex = ref(0);
const itemsPerView = 3;

const fetchMenus = async () => {
  try {
    const response = await axios.get('/api/menus');
    menus.value = response.data;
  } catch (error) {
    console.error("Error fetching menus", error);
  }
};

onMounted(() => {
  fetchMenus();
  startPromoSlider();
  const storedCart = localStorage.getItem('cart');
  if (storedCart) {
    cart.value = JSON.parse(storedCart);
  }
});

const startPromoSlider = () => {
  setInterval(() => {
    currentPromoIndex.value = (currentPromoIndex.value + 1) % promoBanners.value.length;
  }, 3000);
};

const nextMenu = () => {
  if (currentMenuIndex.value < menus.value.length - itemsPerView) {
    currentMenuIndex.value++;
  }
};

const prevMenu = () => {
  if (currentMenuIndex.value > 0) {
    currentMenuIndex.value--;
  }
};
const formatCurrency = (value) => {
  return new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
  }).format(value);
};
const saveCart = () => {
  localStorage.setItem('cart', JSON.stringify(cart.value));
};
const buyMenu = (menu) => {
  const existingItem = cart.value.find(item => item.id === menu.id);
  if (existingItem) {
    existingItem.quantity++;
  } else {
    cart.value.push({ ...menu, quantity: 1 });
  }
  saveCart();
};

const increaseQuantity = (index) => {
  cart.value[index].quantity++;
};

const decreaseQuantity = (index) => {
  if (cart.value[index].quantity > 1) {
    cart.value[index].quantity--;
  } else {
    cart.value.splice(index, 1);
  }
};

const confirmClearCart = () => {
  showConfirm.value = true;
};

const clearCart = () => {
  cart.value = [];
  showConfirm.value = false;
};

const totalCart = computed(() => {
  return cart.value.reduce((total, item) => total + item.price * item.quantity, 0);
});

const goToCheckout = () => {
  if (cart.value.length === 0) {
    alert('Cart kosong! Tambahkan menu terlebih dahulu.');
    return;
  }
  localStorage.setItem('selectedMenus', JSON.stringify(cart.value));
  router.push('/checkout');
};
import '../../css/menu.css';
</script>

