<template>
  <div class="portfolio">
    <transition name="fade-bounce">
      <img
        v-if="showLogo"
        src="./images/logo.jpg"
        alt="Logo Restoran"
        class="logo"
      />
    </transition>

   
    <transition name="slide-fade" appear>
      <h1 class="restaurant-name">{{ restaurantName }}</h1>
    </transition>
    <transition name="slide-fade" appear>
      <h2 class="tagline">{{ tagline }}</h2>
    </transition>
    <transition name="slide-fade" appear>
      <p class="description">{{ description }}</p>
    </transition>

    <button class="cta-button" @click="goToMenu">Lihat Menu</button>
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
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';

const restaurantName = 'Restoran Lezat';
const tagline = 'Nikmati Setiap Sajian';
const description =
  'Selamat datang di Restoran Lezat, tempat terbaik untuk menikmati hidangan yang menggugah selera.';

const showLogo = ref(false);
const router = useRouter();

onMounted(() => {
  showLogo.value = true;
});
const goToMenu = () => {
  router.push('/menu');
};
import '../../css/porto.css';

</script>

