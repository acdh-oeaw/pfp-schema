# Stage 1: Build the HTML files
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim AS builder

# Set the working directory
WORKDIR /app

# Copy the rest of the application files
COPY . .

# Run the build script
RUN ./scripts/build.py

# Stage 2: Serve the HTML files with Nginx
FROM nginx

# Update the Nginx configuration to use port 5000
RUN sed -i 's/80;/5000;/g' /etc/nginx/conf.d/default.conf

# Copy the built HTML files from the builder stage
COPY --from=builder /app/html /usr/share/nginx/html