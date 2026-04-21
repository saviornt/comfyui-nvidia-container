FROM nvidia/cuda:13.2.1-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# Update container dependencies and install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /ComfyUI

# Lock :latest at build time
RUN git clone https://github.com/Comfy-Org/ComfyUI.git .

# Install PyTorch (CUDA 13)
RUN pip install --no-cache-dir \
    torch torchvision torchaudio \
    --extra-index-url https://download.pytorch.org/whl/cu130

# Install ComfyUI dependencies
RUN pip install --no-cache-dir -r requirements.txt

COPY scripts/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8181

CMD ["python3", "main.py", "--listen", "0.0.0.0", "--port", "8181"]