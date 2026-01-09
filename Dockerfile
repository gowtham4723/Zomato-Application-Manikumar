FROM node:20-trixie-slim AS build

WORKDIR /ARF

COPY package*.json ./

COPY . .

RUN npm install

RUN npm run build

#--------------------------------------------------------
    #docker build --n0-cache -t imagename:tag . (force rebuild for a image)

#FROM node:20-trixie-slim

FROM nginx:alpine

# RUN apt update && apt install nginx -y

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /ARF/build/ /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g" , "daemon off;"]