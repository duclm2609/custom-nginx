# Custom Nginx Server

A custom Nginx Docker container with a personalized home page and optimized configuration.

## Features

- 🎨 **Custom Home Page**: Beautiful, modern design with gradient backgrounds and animations
- 🔧 **Optimized Configuration**: Enhanced Nginx settings with security headers, gzip compression, and caching
- 🛡️ **Security**: Non-root user, security headers, and access restrictions
- 📊 **Health Checks**: Built-in health monitoring endpoint
- 🚀 **Performance**: Optimized for speed with proper caching and compression
- 📝 **Logging**: Comprehensive access and error logging

## Quick Start

### Using Docker Compose (Recommended)

1. **Clone or download this repository**
   ```bash
   git clone <repository-url>
   cd custom-nginx
   ```

2. **Build and run the container**
   ```bash
   docker-compose up --build
   ```

3. **Access your custom Nginx server**
   - Open your browser and go to: `http://localhost:8080`
   - You should see the custom home page with a beautiful gradient design

### Using Docker directly

1. **Build the image**
   ```bash
   docker build -t custom-nginx .
   ```

2. **Run the container**
   ```bash
   docker run -d -p 8080:80 --name custom-nginx-server custom-nginx
   ```

3. **Access the server**
   - Visit: `http://localhost:8080`

## File Structure

```
custom-nginx/
├── Dockerfile              # Custom Nginx Docker image
├── docker-compose.yml      # Docker Compose configuration
├── nginx.conf             # Custom Nginx configuration
├── index.html             # Custom home page
├── .dockerignore          # Docker build exclusions
└── README.md              # This file
```

## Configuration Details

### Nginx Configuration (`nginx.conf`)

The custom Nginx configuration includes:

- **Security Headers**: X-Frame-Options, XSS Protection, Content Security Policy
- **Gzip Compression**: Optimized compression for better performance
- **Caching**: Static file caching with proper headers
- **Rate Limiting**: API rate limiting protection
- **Error Pages**: Custom 404 and 50x error pages
- **Health Check**: `/health` endpoint for monitoring

### Custom Home Page (`index.html`)

Features a modern, responsive design with:

- Gradient background with glassmorphism effects
- Animated loading transitions
- Real-time timestamp display
- Server status information
- Mobile-responsive layout

## Customization

### Changing the Home Page

1. **Edit `index.html`** to modify the home page content and styling
2. **Rebuild the container**:
   ```bash
   docker-compose up --build
   ```

### Modifying Nginx Configuration

1. **Edit `nginx.conf`** to change server settings
2. **Rebuild the container**:
   ```bash
   docker-compose up --build
   ```

### Adding Static Files

1. **Create a `static/` directory** in your project
2. **Add your files** (CSS, JS, images, etc.)
3. **Update the Dockerfile** to copy the static files:
   ```dockerfile
   COPY static/ /usr/share/nginx/html/static/
   ```

## Health Check

The container includes a health check endpoint:

- **URL**: `http://localhost:8080/health`
- **Response**: `healthy` (text/plain)
- **Use case**: Docker health monitoring, load balancer health checks

## Logs

Access Nginx logs:

```bash
# View container logs
docker-compose logs custom-nginx

# Access logs directly (if volume mounted)
tail -f logs/access.log
tail -f logs/error.log
```

## Security Features

- **Non-root user**: Container runs as `nginx` user (UID 101)
- **Security headers**: Protection against XSS, clickjacking, and other attacks
- **File access restrictions**: Hidden files and backup files are blocked
- **Rate limiting**: API endpoints are protected against abuse
- **Version hiding**: Nginx version is hidden from responses

## Performance Optimizations

- **Gzip compression**: Reduces bandwidth usage
- **Static file caching**: Long-term caching for static assets
- **Sendfile optimization**: Efficient file serving
- **Keep-alive connections**: Reduced connection overhead
- **Worker processes**: Auto-configured based on CPU cores

## Troubleshooting

### Container won't start

1. **Check if port 8080 is available**:
   ```bash
   lsof -i :8080
   ```

2. **View container logs**:
   ```bash
   docker-compose logs custom-nginx
   ```

### Can't access the website

1. **Verify container is running**:
   ```bash
   docker ps
   ```

2. **Check port mapping**:
   ```bash
   docker port custom-nginx-server
   ```

3. **Test health endpoint**:
   ```bash
   curl http://localhost:8080/health
   ```

### Permission issues

If you encounter permission issues with logs:

```bash
# Create logs directory with proper permissions
mkdir -p logs
chmod 755 logs
```

## Development

### Local Development

For development, you can mount the HTML file as a volume:

```yaml
# In docker-compose.yml, add:
volumes:
  - ./index.html:/usr/share/nginx/html/index.html:ro
```

### Testing Changes

1. **Make your changes** to the files
2. **Rebuild and restart**:
   ```bash
   docker-compose down
   docker-compose up --build
   ```

## License

This project is open source and available under the [MIT License](LICENSE).

## Contributing

Feel free to submit issues and enhancement requests! 