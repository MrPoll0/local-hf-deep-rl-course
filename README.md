# Hugging Face Deep Reinforcement Learning Course — Local Containerized Edition

This repository provides a **locally containerized environment** for running the [Hugging Face Deep Reinforcement Learning Course](https://huggingface.co/learn/deep-rl-course/unit0/introduction).

> **Note:** The course notebooks included in this repository have been slightly modified to remove unnecessary installation commands (e.g. `pip install`), as all required dependencies are already provided by the Docker environment.

## Prerequisites

Before you begin, make sure you have:

- **NVIDIA GPU** (with sufficient VRAM for deep learning workloads)
- **NVIDIA drivers** installed ([Download & install CUDA drivers](https://developer.nvidia.com/cuda-downloads); ensure compatibility with your desired CUDA version)
- **Docker** installed ([Get Docker](https://docs.docker.com/get-docker/))
- **NVIDIA Container Toolkit** installed ([Install guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html))

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
