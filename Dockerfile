#Stage 1
FROM node:20-alpine as builder
WORKDIR /app
COPY .npmrc .
COPY package*.json .
RUN npm ci
COPY . .
RUN npm run build

#Stage 2
FROM nginx:1.19.0
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/dist .
ENTRYPOINT ["nginx", "-g", "daemon off;"]
