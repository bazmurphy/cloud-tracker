# use node version20
FROM node:20-alpine

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

# (!) ARG is used during the build image process (baked in), whereas ENV is used when running the container (dynamic)

# define the arguments being passed to the Docker Run Command
# ARG DB_CONNECTION_STRING
# ARG DB_SSL
# ARG AWS_CLOUDWATCH_REGION
# ARG AWS_CLOUDWATCH_ACCESS_KEY_ID
# ARG AWS_CLOUDWATCH_SECRET_ACCESS_KEY

# set the Environment Variables
ENV DB_CONNECTION_STRING=$DB_CONNECTION_STRING
ENV DB_SSL=$DB_SSL
ENV AWS_CLOUDWATCH_REGION=$AWS_CLOUDWATCH_REGION
ENV AWS_CLOUDWATCH_ACCESS_KEY_ID=$AWS_CLOUDWATCH_ACCESS_KEY_ID
ENV AWS_CLOUDWATCH_SECRET_ACCESS_KEY=$AWS_CLOUDWATCH_SECRET_ACCESS_KEY
ENV EC2_INTERNAL_IP=$EC2_INTERNAL_IP

# Debug: Print the Environment Variables
# RUN echo "DB_CONNECTION_STRING is $DB_CONNECTION_STRING"
# RUN echo "DB_SSL is $DB_SSL"

# expose port 4000
EXPOSE 4000

# run the Expess application
CMD ["npm", "start"]