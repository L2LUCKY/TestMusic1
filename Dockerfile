FROM nikolaik/python-nodejs:python3.10-nodejs19

RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i '/security.debian.org/d' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY . /app/
WORKDIR /app/
apt-get update && \
    apt-get install -y --no-install-recommends git ffmpeg build-essential libssl-dev && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --upgrade -r requirements.txt && \
    apt-get purge -y git build-essential libssl-dev && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

CMD ["python3", "-m", "ANNIEMUSIC"]