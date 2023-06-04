# Set the base image to the official Ubuntu image
FROM ubuntu:latest
# Set the DEBIAN_FRONTEND environment variable to noninteractive
ARG DEBIAN_FRONTEND=noninteractive
# Update the package lists and install Apache2
RUN apt update && apt install apache2 -y
# Install PHP and the Apache PHP module
RUN apt install php -y
RUN apt install libapache2-mod-php -y
# Set the working directory to /var/www/html
WORKDIR /var/www/html
# Copy the info.php file to the /var/www/html directory
RUN echo "<?php phpinfo(); ?>" | tee /var/www/html/info.php > /dev/null
# Expose port 80 for incoming HTTP traffic
EXPOSE 80
# Set an environment variable to customize Apache document root
ENV APACHE_DOCUMENT_ROOT /var/www/html
# Configure Apache to use the custom document root
RUN sed -i "s|/var/www/html|$APACHE_DOCUMENT_ROOT|" /etc/apache2/sites-available/000-default.conf
# Start the Apache service in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]


FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN useradd -m adnanuser
USER root
RUN apt update
RUN apt install apache2 -y
USER adnanuser
RUN apt install php libapache2-mod-php php-mysql -y

EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]