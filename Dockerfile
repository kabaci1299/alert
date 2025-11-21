#FROM python:3.9.7-slim-buster
FROM python:3.13.0
WORKDIR /app
RUN apt-get update && \
    apt-get install -y ffmpeg jq python3-dev && \
    rm -rf /var/lib/apt/lists/*
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
RUN python3 -m pip check yt-dlp
RUN pip install pytube
RUN pip install yt-dlp
ENV COOKIES_FILE_PATH="youtube_cookies.txt"

CMD gunicorn app:app & python3 modules/main.py
