 
# Gunakan image PHP resmi
FROM php:8.1-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

# Install ekstensi PHP yang dibutuhkan
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Set working directory
WORKDIR /var/www

# Salin composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy semua file project ke dalam container
COPY . .

# Install dependencies composer
RUN composer install --no-dev --optimize-autoloader && \
    php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache

# Set permissions
RUN chown -R www-data:www-data /var/www && chmod -R 755 /var/www

# Expose port 9000 dan start PHP-FPM
EXPOSE 9000
CMD ["php-fpm"]
