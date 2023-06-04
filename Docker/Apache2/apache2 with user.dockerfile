FROM docker.io/library/ubuntu:20.04@sha256:db8bf6f4fb351aa7a26e27ba2686cf35a6a409f65603e59d4c203e58387dc6b3
ARG DEBIAN_FRONTEND=noninteractive
RUN useradd -m adnanuser
USER root
RUN apt update && apt install -y apache2
RUN apt install -y sudo
RUN echo "adnanuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER adnanuser
RUN sudo apt install -y php libapache2-mod-php php-mysql