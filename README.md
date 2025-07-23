# Hugging Face Deep Reinforcement Learning Course — Local Containerized Edition

<p align="center">
  <a href="https://github.com/MrPoll0/local-hf-deep-rl-course/actions/workflows/docker-build.yml">
    <img src="https://github.com/MrPoll0/local-hf-deep-rl-course/actions/workflows/docker-build.yml/badge.svg" alt="Build Docker Images">
  </a>
</p>

This repository provides a **locally containerized environment** for running the [Hugging Face Deep Reinforcement Learning Course](https://huggingface.co/learn/deep-rl-course/unit0/introduction).

> **Note:** The course notebooks included in this repository have been slightly modified to remove unnecessary installation commands (e.g. `pip install`), as all required dependencies are already provided by the Docker environment.

## Prerequisites

Before you begin, make sure you have:

- **NVIDIA GPU** (with sufficient VRAM for deep learning workloads)
- **NVIDIA drivers** installed ([Download & install CUDA drivers](https://developer.nvidia.com/cuda-downloads); ensure compatibility with your desired CUDA version)
- **Docker** installed ([Get Docker](https://docs.docker.com/get-docker/))
- **NVIDIA Container Toolkit** installed ([Install guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html))

## Modular Docker Workflow

To optimize build times and disk usage, this project uses a modular Docker workflow with a shared base image:

1. **Build the base image** (with CUDA, Conda, Python, and PyTorch):
   - File: `base.Dockerfile`
   - Build:
     ```bash
     docker build -t base-env -f base.Dockerfile .
     ```
   - This step is only needed once (unless you change the base dependencies).

2. **Build the unit-specific image** (e.g., for Unit 1):
   - File: `unit1.Dockerfile`
   - Build:
     ```bash
     docker build -t unit1-env -f unit1.Dockerfile .
     ```
   - This image builds quickly, as it reuses the heavy base image.

3. **Run the environment for a unit** (e.g., Unit 1):
   ```bash
   docker run --gpus all -p 8888:8888 -v ${PWD}:/app unit1-env
   ```

4. **Repeat for other units** (e.g., Unit 2) using their respective Dockerfiles and image tags.

This approach ensures you only download and build the large dependencies once, and each unit's environment is isolated and fast to build.

See below for CUDA compatibility and further details.

## CUDA Version & Compatibility

> **Note:** The environments use **CUDA 12.1** (see `FROM nvidia/cuda:12.1.1-devel-ubuntu22.04`).
>
> - Ensure your GPU and NVIDIA drivers are compatible with CUDA 12.1. You can check compatibility on the [NVIDIA CUDA compatibility page](https://docs.nvidia.com/deploy/cuda-compatibility/).
> - If you need a different CUDA version, you can edit the `FROM` line in `unit1/Dockerfile` to match your system (e.g., `nvidia/cuda:11.8.0-devel-ubuntu22.04`).
> - After changing the CUDA version, you may also need to adjust package versions for compatibility.

## Why run locally?

While the official course is designed for [Google Colab](https://colab.research.google.com/), and the notebooks include their own `pip install` instructions, these dependencies are often **outdated or broken** due to changes in external packages. This can lead to installation errors, incompatibilities, or deprecated packages that prevent the notebooks from running as intended.

By running the course locally in a Docker container, you get:

- **A stable, pre-configured environment** with all required dependencies pinned and tested
- **No dependency errors** from outdated or broken `pip install` commands in the notebooks
- **Full access to your own GPU** (no Colab quotas or timeouts)
- **Consistent, reproducible setup**
- **No session interruptions**

## Getting Started

- See [unit1/README.md](unit1/README.md) for step-by-step instructions to build and run the local environment.
- For more about the course content, visit the [official Hugging Face Deep RL Course page](https://huggingface.co/learn/deep-rl-course/unit0/introduction).

---

**Note:** This project is not affiliated with Hugging Face, but provides a convenient way to complete the course locally.
