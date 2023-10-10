# Get latest nginx Image
FROM nginx:latest

# Copy the nginx configuration to the container
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 (http)
EXPOSE 80

# Debug: Check the contents of /usr/share/nginx/html
# RUN ls -l /usr/share/nginx/html

# Start nginx when the container is launched
CMD ["nginx", "-g", "daemon off;"]