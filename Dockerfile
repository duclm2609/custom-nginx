# Use the official Nginx Alpine image as base
FROM nginx:alpine


# Copy custom HTML files
COPY index.html /usr/share/nginx/html/index.html