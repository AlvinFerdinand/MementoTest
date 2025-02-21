
📋 Spesifikasi:

- Laravel Version: 10.x
- PHP Version: 8.2
- Node.js Version: 18.x
- Vite: 4.x
- Vue.js Version: 3.x
- Database: MySQL
- Hosting Backend: Railway
- Hosting Frontend: Vercel

📂 Struktur Folder Utama:

project-root/
│── app/                 # Folder utama Laravel (Model, Controllers, Middleware, dll.)
│── bootstrap/           # Bootstrapping framework Laravel
│── config/              # Konfigurasi aplikasi (database, auth, CORS, dll.)
│── database/            # Migrations, seeders, dan factories
│── public/              # Entry point aplikasi (index.php) & assets publik
│── resources/           
│   ├── js/              # Tempat file Vue.js (frontend)
│   │   ├── views/       # Komponen halaman Vue.js
│   │   ├── components/  # Komponen kecil yang digunakan ulang
│   │   ├── router/      # File routing Vue.js
│   │   ├── store/       # Vuex/Pinia store (jika digunakan)
│   ├── css/             # Stylesheet tambahan
│   ├── views/           # Blade templates (jika masih digunakan)
│── routes/              # Routing backend Laravel (web.php & api.php)
│── storage/             # Cache, logs, dan file yang di-upload
│── tests/               # Unit & feature tests Laravel
│── .env                 # Konfigurasi environment aplikasi
│── .gitignore           # File yang diabaikan Git
│── package.json         # Dependencies frontend (Vue.js & Vite)
│── vite.config.js       # Konfigurasi Vite
│── composer.json        # Dependencies Laravel
│── artisan              # CLI Laravel

⚙️ Instalasi dan Menjalankan Proyek Secara Lokal

1️⃣ Clone Repository

git clone https://github.com/username/project.git
cd project

2️⃣ Setup Backend (Laravel)

Install Dependencies

composer install

Buat File Environment

cp .env.example .env

Lalu, sesuaikan konfigurasi database di dalam .env:

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=namadatabase
DB_USERNAME=root
DB_PASSWORD=password

Generate Key & Migrasi Database

php artisan key:generate
php artisan migrate --seed

Jalankan Server Laravel

php artisan serve

Server akan berjalan di http://127.0.0.1:8000

3️⃣ Setup Frontend (Vue.js + Vite)

Masuk ke Direktori Frontend

cd resources/js/views

Install Dependencies

npm install

Jalankan Vite agar Vue.js bisa menampilkan frontend

npm run dev

Frontend akan berjalan di http://localhost:5173

Untuk Build Production (Opsional)

npm run build
php artisan serve

🔗 API Endpoint (Backend Laravel)

Method:
GET

Endpoint:
/api/menus

Deskripsi:
Mengambil daftar menu

🚀 Deploy Backend ke Railway

- Login & Buat Proyek di Railway
- Masuk ke Railway
- Klik New Project → Deploy from GitHub
- Pilih repository backend Laravel
- Konfigurasi Environment di Railway
- Masukkan variabel DATABASE_URL sesuai koneksi MySQL yang digunakan
- Pastikan variabel .env sudah sesuai dengan database Railway
- Deploy Backend
- Railway akan otomatis membangun dan menjalankan backend setelah setup selesai
- Jika perlu, jalankan migrasi secara manual:
    railway run php artisan migrate --seed

🚀 Deploy Frontend ke Vercel
- Login & Buat Proyek di Vercel
- Masuk ke Vercel
- Klik New Project → Pilih repository frontend Vue.js
- Konfigurasi Build di Vercel
    Build Command: npm run build
    Output Directory: dist
- Tambahkan Environment Variable untuk koneksi backend:
    VITE_API_URL=https://backendmu.railway.app/api
- Deploy
- Klik Deploy dan tunggu proses selesai

🛠 Troubleshooting

1️⃣ Error CORSTambahkan domain frontend ke config/cors.php:

'allowed_origins' => ['http://localhost:5173', 'https://frontendmu.vercel.app'],

2️⃣ Database tidak tersinkronPastikan migrasi sudah dijalankan:

php artisan migrate --seed

3️⃣ Gambar Tidak Muncul di FrontendPastikan path gambar sesuai dengan public path di Laravel:

/storage/app/public/images/nasigoreng.jpg

Jalankan perintah ini untuk memastikan gambar bisa diakses:

php artisan storage:link

✅ Proyek Laravel + Vue.js sudah siap dijalankan! 🚀
