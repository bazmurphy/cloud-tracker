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
ARG AWS_CLOUDWATCH_REGION
ARG AWS_CLOUDWATCH_ACCESS_KEY_ID
ARG AWS_CLOUDWATCH_SECRET_ACCESS_KEY

# set the localised Environment Variables as those arguments
ENV DB_CONNECTION_STRING=$DB_CONNECTION_STRING
ENV DB_SSL=$DB_SSL
ENV AWS_CLOUDWATCH_REGION=$AWS_CLOUDWATCH_REGION
ENV AWS_CLOUDWATCH_ACCESS_KEY_=$AWS_CLOUDWATCH_ACCESS_KEY_
ENV AWS_CLOUDWATCH_SECRET_ACCESS_KEY=$AWS_CLOUDWATCH_SECRET_ACCESS_KEY

# Debug: Print the value of DB_CONNECTION_STRING and DB_SSL before starting
# RUN echo "DB_CONNECTION_STRING is $DB_CONNECTION_STRING"
# RUN echo "DB_SSL is $DB_SSL"

# run the Expess application
CMD ["npm", "start"]