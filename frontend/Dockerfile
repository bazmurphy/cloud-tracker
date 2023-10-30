# use node version 20, give it an alias to reference later for nginx
FROM node:20-alpine AS frontend-build

# start from the /frontend folder
WORKDIR /frontend

# copy both package and package-lock json files across
COPY package*.json ./

# install the packages
RUN npm install

# copy the rest of the files across
COPY . .

# define the arguments being passed to the Docker Run Command
# ARG VITE_API_URL

# set the localised Environment Variables as those arguments
# ENV VITE_API_URL=$VITE_API_URL

# Debug: Print the value of VITE_API_URL during the build process
# RUN echo "VITE_API_URL is $VITE_API_URL"

# set the ec2 instance internal ip dynamically to display on the frontend
ARG VITE_EC2_INTERNAL_IP
ENV VITE_EC2_INTERNAL_IP=$EC2_INTERNAL_IP
RUN echo "VITE_EC2_INTERNAL_IP is $VITE_EC2_INTERNAL_IP"

# run the typescript compiler to output to /dist/
RUN npm run build

# Debug: Check the contents of /frontend/dist
# RUN ls -l /frontend/dist

# Janky: Keep the container alive for 60 seconds 
# So the nginx container can copy across the dist folder (when we have a separate nginx container)
# CMD [ "sh", "-c", "sleep 60" ]

# use the latest nginx Image
FROM nginx:latest

# Remove the default nginx configuration from the container (is this really neccessary?)
RUN rm /etc/nginx/conf.d/default.conf

# Copy the nginx configuration to the container
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the contents of /dist from the alias "frontend-build" (above) to the /html of the nginx container
COPY --from=frontend-build /frontend/dist /usr/share/nginx/html

# Debug: Check the contents of /usr/share/nginx/html
# RUN ls -l /usr/share/nginx/html

# Expose port 80 (http)
EXPOSE 80

# Start nginx when the container is launched
CMD ["nginx", "-g", "daemon off;"]