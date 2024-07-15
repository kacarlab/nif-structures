FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    libxrender1 \
    && rm -rf /var/lib/apt/lists/*

COPY . .
RUN pip install .

WORKDIR /server
EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run", "streamlit-e24.py", "--server.port=80", "--server.address=0.0.0.0"]