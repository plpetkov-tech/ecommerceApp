FROM node:alpine AS build-stage
WORKDIR /app
COPY . .
RUN npm ci && npm audit fix && npm run build

# stage 2

FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx_conf/default.conf /etc/nginx/conf.d/
COPY --from=build-stage /app/dist/angular-ecommerce /usr/share/nginx/html

EXPOSE 80