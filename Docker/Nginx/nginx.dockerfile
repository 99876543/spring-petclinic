FROM ubuntu:20.04


RUN apt update
RUN apt install nginx -y
RUN apt install php libapache2-mod-php php-mysql -y

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]




