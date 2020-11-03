FROM node:alpine AS build-stage
WORKDIR /app
COPY . .
RUN npm ci && npm audit fix && npm run build

# stage 2

FROM nginx:alpine
COPY --from=build-stage /app/dist/angular-ecommerce /usr/share/nginx/html
EXPOSE 80