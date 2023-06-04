## Base image
FROM ubuntu:22.04

# Set a label 
LABEL author="Adnan"

# For no interactions
ARG DEBIAN_FRONTEND=noninteractive

# Update and upgrade your package
RUN apt update && apt upgrade -y

# Install nginX
RUN apt install nginx -y

# Install php and phpfpm 
RUN apt install php8.1 php8.1-fpm -y && \
    rm -rf /var/lib/apt/lists/

# Copy nginx conf file 
COPY nginx.conf /etc/nginx/sites-available/default
# The nginx -t command is used to test the configuration file of the Nginx web server for syntax errors

RUN nginx -t

# Change modifications
RUN chmod -R 777 /var/www/html

# Add php command to see php page
RUN echo "<?php phpinfo() ?>" >> /var/www/html/info.php

# ReStart php8.1 service
RUN service php8.1-fpm restart

#Expose on ports
EXPOSE 80

# It sets the default executable for the container.
ENTRYPOINT ["/bin/bash","-c","service php8.1-fpm start && nginx -g 'daemon off;'"]

# Start nginx 
CMD ["nginx","-g","daemon off;"]

#for this we need to create 3 files

1. index.html
<html>
  <head>
    <title>adnan website</title>
  </head>
  <body>
    <h1>Hello Adnan!</h1>

    <p>This is the landing page of <strong>adnan</strong>.</p>
  </body>
</html>
2. Adnan

server {
    listen 80;
    server_name adnan www.adnan;
    root /var/www/adnan;

    index index.html index.htm index.php;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
     }

    location ~ /\.ht {
        deny all;
    }

}

3. nginx.conf
server_name _;
  location / {
    try_files $uri $uri/ =404;
  }
  # pass PHP scripts on Nginx to FastCGI (PHP-FPM) server
  location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    # Nginx php-fpm sock config:
    fastcgi_pass unix:/run/php/php8.1-fpm.sock;
    # Nginx php-cgi config :
    # Nginx PHP fastcgi_pass 127.0.0.1:9000;
  }
  # deny access to Apache .htaccess on Nginx with PHP,
  # if Apache and Nginx document roots concur
  location ~ /\.ht {
    deny all;
  }

