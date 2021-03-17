FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx_conf/default.conf /etc/nginx/conf.d/
COPY ./dist/angular-ecommerce /usr/share/nginx/html

EXPOSE 80
