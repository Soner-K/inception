# Use penultimate Alpine version (replace with actual version as needed)
FROM alpine:3.21

# Install Nginx and OpenSSL
RUN apk update && apk add --no-cache nginx openssl

# Create directories for SSL certs and web files
RUN mkdir -p /etc/nginx/certs /var/www/html

# Copy SSL certificate and key
COPY certs /etc/nginx/certs/

# Copy Nginx config
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf

# Copy website files
COPY ./www/ /var/www/html/

# Expose HTTPS port
EXPOSE 443

# Run Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]