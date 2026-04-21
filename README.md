# ComfyUI NVIDIA Container

A minimal, production-ready Docker container for running the latest ComfyUI with NVIDIA GPU acceleration (CUDA-enabled PyTorch).

This image builds ComfyUI directly from the official upstream repository at build time and is designed as a **drop-in replacement runtime environment** for local or server-based AI workflows.

This is **not** a development container with custom abstractions or modifications,  nor intended for large-scale orchestration or multi-node cloud deployments. It is intended for end-users who want a clean, GPU-accelerated ComfyUI environment without the overhead of manual setup inside of a Docker container on their local machine or server.

---

## 🚀 Features

- 🧠 Latest ComfyUI pulled from upstream GitHub at build time
- ⚡ NVIDIA GPU acceleration (CUDA-enabled PyTorch)
- 📦 Persistent model, input, output, and custom node storage
- 🔌 Standard ComfyUI port (8181)
- 🧱 Clean upstream-compatible directory structure (no custom abstraction layers)
- 🐳 Designed for Docker Compose and standalone `docker run` usage

---

## 🧰 Requirements

### 🖥️ Hardware

- NVIDIA GPU (RTX-class recommended, 12GB+ VRAM for SDXL/Flux workloads)

### 🧩 Software (HOST)

- NVIDIA GPU driver (latest stable recommended, 580+ or newer)
- Docker Engine / Docker Desktop with GPU support
- NVIDIA Container Toolkit

> CUDA Toolkit is **not** required on the host system, as the container includes the necessary CUDA libraries for GPU acceleration.

Verify GPU support:

```bash
docker run --rm --gpus all nvidia/cuda:13.2.0-base-ubuntu22.04 nvidia-smi
```

---

## 🚀 Quick Start

Run with Docker

```bash
docker run --gpus all -p 8181:8181 \
  -v comfyui:/ComfyUI \
  saviornt/comfyui-nvidia-container:latest
```

Then open:

`http://localhost:8181`

---

🐳 Docker Compose (recommended)

```yaml
services:
  comfyui:
    image: saviornt/comfyui-nvidia-container:latest
    ports:
      - "8181:8181"
    volumes:
      - comfyui:/ComfyUI
    gpus: all

volumes:
  comfyui:
```

## 📁 Persistent Data

This container preserves ComfyUI’s native directory structure.

All persistent data is stored in the ComfyUI root directory:

```text
/ComfyUI
```

Inside this directory, ComfyUI uses the following standard folders:

```text
/ComfyUI/models         → AI models (checkpoints, SDXL, Flux, LoRAs, VAEs)
/ComfyUI/input          → input images and uploads
/ComfyUI/output         → generated outputs
/ComfyUI/custom_nodes   → community extensions and plugins
```

These paths are defined by ComfyUI itself and are not modified by this container.

The Docker volume is mounted directly to `/ComfyUI` to ensure full compatibility with standard ComfyUI installations and workflows.

---

## 📦 What This Container Does

On build:

- Clones the latest ComfyUI from official GitHub
- Installs PyTorch with CUDA support
- Installs ComfyUI dependencies
- Exposes ComfyUI on port 8181

At runtime:

- Starts ComfyUI listening on 0.0.0.0:8181
- Uses mounted volume for all persistent data

---

## ❌ What This Container Does NOT Do

- Does NOT automatically download models
- Does NOT include preinstalled checkpoints or LoRAs
- Does NOT auto-update ComfyUI during server startup
- Does NOT modify upstream ComfyUI behavior

---

## ⚡ Updating ComfyUI

### Initial Installation

This container installs ComfyUI from the official upstream GitHub repository during build time.

This means:

- The container is always built using the latest ComfyUI version available at build time
- No runtime auto-updates are performed inside the container

---

### Updating ComfyUI (Manual)

After the container is running, users can update ComfyUI directly from the UI using ComfyUI Manager:

- Open the ComfyUI interface
- Go to **Manager**
- Click **“Update ComfyUI”**

This will pull the latest upstream ComfyUI version into the running environment.

---

### Alternative Update Method (Advanced Users)

Users can also manually update via terminal inside the container:

```bash
cd /ComfyUI
git pull
```

Followed by:

```bash
pip install -r requirements.txt
```

---

### Important Notes

- Updates performed via UI or git pull modify the running container's filesystem and will only persist through the `/ComfyUI` volume.
- These changes persist only if using a mounted volume (`/ComfyUI`)
- Rebuilding the Docker image will reset ComfyUI back to the version pinned at build time (latest at the time of build)

---

## 🧠 General Notes

- Internal ComfyUI port is fixed at 8181
- External port can be changed via Docker mapping
- GPU access requires NVIDIA Container Toolkit on the host system
- This container is designed for local runtime inference workflows, not development or cloud-based production builds

---

## 🏷️ License

Licensed under the Apache License, Version 2.0 (the “License”);

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

---

## 💖 Support This Project

If this project saves you time or helps your workflow, consider supporting its development:

⭐ Star the repository (helps visibility)

💸 [GitHub Sponsorship](https://github.com/sponsors/saviornt)

☕ [Buy Me a Coffee](https://www.buymeacoffee.com/davidwadswq)
