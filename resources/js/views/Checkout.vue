<template>
  <div class="checkout">
    <!-- Animasi piring, sendok, dan garpu -->
    <transition name="plate-anim" appear>
      <div class="animation-container" v-if="animate">
        <img src="./images/plate.png" alt="Plate" class="plate" />
        <img src="./images/spoon.png" alt="Spoon" class="spoon" />
        <img src="./images/fork.png" alt="Fork" class="fork" />
      </div>
    </transition>

    <div class="invoice">
      <h1>Invoice</h1>
      <ul class="selected-menu">
        <li v-for="(item, index) in selectedMenus" :key="index">
          {{ item.name }} (x{{ item.quantity || 1 }}) - {{ formatCurrency(item.price * (item.quantity || 1)) }}
        </li>
      </ul>
      <h2>Total: {{ formatCurrency(totalPrice) }}</h2>

      <div class="payment-method">
        <h3>Pilih Metode Pembayaran:</h3>
        <select v-model="paymentMethod">
          <option disabled value="">Pilih metode pembayaran</option>
          <option>COD</option>
          <option>Transfer Bank</option>
          <option>E-Wallet</option>
        </select>
      </div>

      <button :disabled="!paymentMethod" @click="confirmOrder" class="confirm-btn">
        Confirm Order
      </button>
    </div>


    <transition name="modal-fade">
      <div v-if="showModal" class="modal-overlay">
        <div class="modal">
          <h2>Order Berhasil!</h2>
          <p>Pesanan Anda telah dikonfirmasi.</p>
          <button @click="closeModal" class="modal-btn">OK</button>
        </div>
      </div>
    </transition>
  </div>
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
import { ref, computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();
const selectedMenus = ref([]);
const paymentMethod = ref("");
const showModal = ref(false);
const animate = ref(false);

const totalPrice = computed(() =>
  selectedMenus.value.reduce((sum, item) => sum + item.price * (item.quantity || 1), 0)
);

onMounted(() => {
  const storedMenus = localStorage.getItem('selectedMenus');
  if (storedMenus) {
    selectedMenus.value = JSON.parse(storedMenus);
  }
  animate.value = true;
});

const formatCurrency = (value) => {
  return new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
  }).format(value);
};

const confirmOrder = () => {
  showModal.value = true;
  localStorage.removeItem('selectedMenus');  
  selectedMenus.value = [];  
};

const closeModal = () => {
  showModal.value = false;
  router.push('/menu');
};
import '../../css/checkout.css';
</script>


