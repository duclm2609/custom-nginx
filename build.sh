#!/bin/bash

# Custom Nginx Build Script
# This script builds and runs the custom Nginx container

set -e

echo "🚀 Building Custom Nginx Server..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    print_error "Docker is not running. Please start Docker and try again."
    exit 1
fi

# Check if Docker Compose is available
if ! command -v docker-compose &> /dev/null; then
    print_error "Docker Compose is not installed. Please install Docker Compose and try again."
    exit 1
fi

# Create logs directory if it doesn't exist
if [ ! -d "logs" ]; then
    print_status "Creating logs directory..."
    mkdir -p logs
    chmod 755 logs
fi

# Stop and remove existing containers
print_status "Stopping existing containers..."
docker-compose down --remove-orphans 2>/dev/null || true

# Build and start the container
print_status "Building and starting custom Nginx container..."
docker-compose up --build -d

# Wait for container to be ready
print_status "Waiting for container to be ready..."
sleep 5

# Check if container is running
if docker ps | grep -q custom-nginx-server; then
    print_success "Custom Nginx server is running!"
    echo ""
    echo -e "${GREEN}🌐 Access your custom Nginx server at:${NC}"
    echo -e "   ${BLUE}http://localhost:8080${NC}"
    echo ""
    echo -e "${GREEN}🔍 Health check endpoint:${NC}"
    echo -e "   ${BLUE}http://localhost:8080/health${NC}"
    echo ""
    echo -e "${GREEN}📋 Useful commands:${NC}"
    echo -e "   View logs: ${BLUE}docker-compose logs -f custom-nginx${NC}"
    echo -e "   Stop server: ${BLUE}docker-compose down${NC}"
    echo -e "   Restart server: ${BLUE}docker-compose restart${NC}"
    echo ""
    print_success "Enjoy your custom Nginx server! 🎉"
else
    print_error "Failed to start the container. Check the logs:"
    docker-compose logs custom-nginx
    exit 1
fi 