# use node version18
FROM node:18-alpine

# start from the /backend folder
WORKDIR /backend

# copy both package and package-lock json files across
COPY package*.json ./

# install the packages
RUN npm install

# copy the rest of the files across
COPY . .

# run the typescript compiler to output to /dist/
RUN npm run build

# expose port 4000
EXPOSE 4000

# define the arguments being passed to the Docker Run Command
ARG DB_CONNECTION_STRING
ARG DB_SSL

# set the localised Environment Variables as those arguments
ENV DB_CONNECTION_STRING=$DB_CONNECTION_STRING
ENV DB_SSL=$DB_SSL

# Debug: Print the value of DB_CONNECTION_STRING and DB_SSL before starting
RUN echo "DB_CONNECTION_STRING is $DB_CONNECTION_STRING"
RUN echo "DB_SSL is $DB_SSL"

# run the Expess application
CMD ["npm", "start"]


# Docker Build Command to build the Image:
# -t is the name of image
# . is the start location of the build

# docker build -t cloud-tracker-backend-image .

# from the root directory:

# docker build -t cloud-tracker-backend-image backend


# Docker Run Command to run a Container using this image:

# -d is detached mode
# -p is the internal/external port mapping
# -e is to pass environment variables
# --name is the name of the container

# docker run -d -p 4000:4000 -e DB_CONNECTION_STRING=<value> -e DB_SSL=<value> --name cloud-tracker-backend-container cloud-tracker-backend-image


# Tag the Image

# docker tag cloud-tracker-backend-image:latest bazmurphy/cloud-tracker-backend-image:latest


# Push the Image Docker Hub

# docker push bazmurphy/cloud-tracker-backend-image:latest