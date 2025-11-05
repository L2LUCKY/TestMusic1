# Base image with Python 3.10 and Node.js 19
FROM nikolaik/python-nodejs:python3.10-nodejs19

# Fix Debian old repo issue and install ffmpeg + system deps
RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i '/security.debian.org/d' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg build-essential libssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Clean up build dependencies (optional, for smaller image)
RUN apt-get purge -y build-essential libssl-dev && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Run the bot
CMD ["python3", "-m", "ANNIEMUSIC"]