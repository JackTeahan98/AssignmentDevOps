# FROM node:7-onbuild

# LABEL maintainer "jteahan98@gmail.com"

# HEALTHCHECK --interval=5s \
#             --timeout=5s \
#             CMD curl -f http:127.0.0.1:3000 || exit 1
          
# EXPOSE 3000
FROM node:10

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

EXPOSE 3000
CMD [ "npm", "start" ]
