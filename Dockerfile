# FROM node:7-onbuild

# LABEL maintainer "jteahan98@gmail.com"

# HEALTHCHECK --interval=5s \
#             --timeout=5s \
#             CMD curl -f http:127.0.0.1:3000 || exit 1
          
# EXPOSE 3000
FROM keymetrics/pm2:latest-alpine

ADD . /app
WORKDIR /app
RUN npm install
CMD ["npm", "start"]
