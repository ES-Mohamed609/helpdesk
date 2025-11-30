#first stage: build stage
FROM node:iron-alpine3.22 AS build
RUN mkdir -p /app
WORKDIR /app

COPY package*.json /app/
RUN npm install 


COPY . /app/
RUN npm run build --prod

#second stage: production stage
FROM nginx:alpine
COPY --from=build /app/dist/helpdesk /usr/share/nginx/html