FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY index.html ./

COPY app.js ./

EXPOSE 2000

