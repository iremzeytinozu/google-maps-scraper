# Build stage for Playwright dependencies
FROM golang:1.24.6-bullseye AS playwright-deps
ENV PLAYWRIGHT_BROWSERS_PATH=/opt/browsers
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && go install github.com/playwright-community/playwright-go/cmd/playwright@latest \
    && mkdir -p /opt/browsers \
    && playwright install chromium --with-deps

# Build stage
FROM golang:1.24.6-bullseye AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -ldflags="-w -s" -o /usr/bin/google-maps-scraper

# Final stage
FROM debian:bullseye-slim

ENV PLAYWRIGHT_BROWSERS_PATH=/opt/browsers
ENV PLAYWRIGHT_DRIVER_PATH=/opt
ENV PORT=8080

# Data klasörü oluştur
RUN mkdir -p /gmapsdata
RUN chmod -R 755 /gmapsdata

# Gerekli bağımlılıkları yükle
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libdbus-1-3 \
    libxkbcommon0 \
    libatspi2.0-0 \
    libx11-6 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Playwright dosyalarını kopyala
COPY --from=playwright-deps /opt/browsers /opt/browsers
COPY --from=playwright-deps /root/.cache/ms-playwright-go /opt/ms-playwright-go
RUN chmod -R 755 /opt/browsers /opt/ms-playwright-go

# Scraper binary'yi kopyala
COPY --from=builder /usr/bin/google-maps-scraper /usr/bin/

# ENTRYPOINT: Go HTTP server ve scraper
ENTRYPOINT ["google-maps-scraper", "-data-folder", "/gmapsdata", "-port", "$PORT"]
