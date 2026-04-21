# ComfyUI Docker (CUDA 13)

Minimal, NVIDIA GPU-enabled ComfyUI container using the latest version of ComfyUI at build time.

## Features

- NVIDIA GPU support (CUDA 13)
- Latest ComfyUI pulled during build from their GitHub repository
- Compatible with existing ComfyUI Docker setups

## Requirements

- NVIDIA GPU with CUDA >= 13.0.0 support
- NVIDIA GPU drivers >= 580
- Docker with NVIDIA Container Toolkit installed


## Usage

### Docker Compose

```bash
docker compose up -d
```
