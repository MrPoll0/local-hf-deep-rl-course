# Running Unit 1 Locally

> **CUDA Version Notice:**
> 
> This environment uses **CUDA 12.1** (see the `FROM nvidia/cuda:12.1.1-devel-ubuntu22.04` line in the Dockerfile). Please ensure your GPU and drivers are compatible with CUDA 12.1. If you need a different CUDA version, edit the `FROM` line in `unit1/Dockerfile` and adjust package versions as needed. See the [NVIDIA CUDA compatibility page](https://docs.nvidia.com/deploy/cuda-compatibility/) for more info.

> **Important:** The section on loading a saved model from the Hugging Face Hub is **not supported** in this local environment due to conflicting dependencies. Please skip this part if following the notebook locally.

Follow these steps to build and run the Unit 1 environment locally:

---

## 1. Build the Docker Image

```bash
docker build -t unit1-env .
```

---

## 2. Run the Docker Container

**For Linux/macOS:**

```bash
docker run --gpus all -p 8888:8888 -v "$(pwd)":/app unit1-env
```

**For Windows (PowerShell):**

```bash
docker run --gpus all -p 8888:8888 -v ${PWD}:/app unit1-env
```

---

## 3. Access Jupyter Notebook

Once the container is running, open your browser and go to:

[http://localhost:8888](http://localhost:8888)