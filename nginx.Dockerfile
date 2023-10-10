# Get latest nginx Image
FROM nginx:latest

# Copy the nginx configuration to the container
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 (http)
EXPOSE 80

# Start nginx when the container is launched
CMD ["nginx", "-g", "daemon off;"]