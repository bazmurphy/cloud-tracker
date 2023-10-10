# use node version 18, give it an alias to reference later for nginx
FROM node:18-alpine

# start from the /frontend folder
WORKDIR /frontend

# copy both package and package-lock json files across
COPY package*.json ./

# install the packages
RUN npm install

# copy the rest of the files across
COPY . .

# define the arguments being passed to the Docker Run Command
ARG VITE_API_URL

# set the localised Environment Variables as those arguments
ENV VITE_API_URL=$VITE_API_URL

# Debug: Print the value of VITE_API_URL during the build process
RUN echo "VITE_API_URL is $VITE_API_URL"

# run the typescript compiler to output to /dist/
RUN npm run build

# Debug: Check the contents of /frontend/dist
# RUN ls -l /frontend/dist

# Docker Build Command to build the Image:
# -t is the name of image
# . is the start location of the build

# docker build -t cloud-tracker-frontend-image .

# from the root directory:

# docker build -t cloud-tracker-frontend-image frontend


# Docker Run Command to run a Container using this image:

# -d is detached mode
# -p is the internal/external port mapping
# --name is the name of the container

# docker run -d -p 80:80 --name cloud-tracker-frontend-container cloud-tracker-frontend-image


# Tag the Image

# docker tag cloud-tracker-frontend-image:latest bazmurphy/cloud-tracker-frontend-image:latest


# Push the Image Docker Hub

# docker push bazmurphy/cloud-tracker-frontend-image:latest