FROM php:8.2-fpm

# Install required extensions
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Set timezone
RUN echo "date.timezone=Asia/Jakarta" > /usr/local/etc/php/conf.d/timezone.ini

# Set working directory
WORKDIR /var/www/html

# Copy all project files
COPY . /var/www/html

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Healthcheck (opsional, untuk readiness probe)
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:9000 || exit 1

# Expose port for PHP-FPM
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
