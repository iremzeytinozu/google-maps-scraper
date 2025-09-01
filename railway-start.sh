#!/bin/bash
# Railway startup script

echo "🚀 Starting Google Maps Scraper on Railway..."
echo "📊 Memory limit: ${MEMORY_LIMIT:-2048}MB"
echo "⚙️  Workers: ${WORKERS:-1}"
echo "⏱️  Timeout: ${TIMEOUT:-600}s"

# Set memory limits for Railway
export NODE_OPTIONS="--max-old-space-size=${MEMORY_LIMIT:-2048}"
export GOMAXPROCS=${WORKERS:-1}

# Optimize for Railway environment
export RAILWAY_ENVIRONMENT=production
export PLAYWRIGHT_BROWSERS_PATH=/opt/browsers
export PLAYWRIGHT_DRIVER_PATH=/opt

echo "🌍 Starting server on port ${PORT:-8080}..."
exec google-maps-scraper
