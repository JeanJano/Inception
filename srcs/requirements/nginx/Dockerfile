FROM debian:bullseye

RUN apt update && apt upgrade -y

RUN apt install nginx -y

RUN apt install curl -y

RUN mkdir -p /etc/nginx/ssl/certs
RUN mkdir -p /etc/nginx/ssl/private
RUN mkdir -p /var/run/nginx

RUN apt install openssl -y

RUN openssl req -newkey rsa:4096 -sha256 -days 42 -x509 -nodes \
    -subj "/C=FR/ST=Paris/L=Paris/0=42/OU=42Paris/CN=jsauvage.42.fr/UID=jsauvage" \
    -out /etc/ssl/certs/inception.crt \
    -keyout /etc/ssl/private/inception.key

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html

RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]