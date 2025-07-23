# Running Unit 2 Locally

> **Build Time Notice:**
> 
> Building the provided `unit2.Dockerfile` may take a while, as it installs and resolves all dependencies from the pinned `environment.yml` for maximum reproducibility. For a **faster build**, you can use the `unit2_scratch.Dockerfile`, but be aware this is **risky**: it installs the latest versions of external packages, which may break due to upstream changes. The `environment.yml` approach is recommended for stability.

> **CUDA Version Notice:**
> 
> This environment uses **CUDA 12.1** (see the `FROM nvidia/cuda:12.1.1-devel-ubuntu22.04` line in the Dockerfile). Please ensure your GPU and drivers are compatible with CUDA 12.1. If you need a different CUDA version, edit the `FROM` line in `base.Dockerfile` and adjust package versions as needed. See the [NVIDIA CUDA compatibility page](https://docs.nvidia.com/deploy/cuda-compatibility/) for more info.

---

## Getting Started

1. **Move to the Unit 2 directory:**
   ```bash
   cd unit2
   ```
2. **Build the base image** (if not already built):
   ```bash
   docker build -t base-env -f ../base.Dockerfile .
   ```
3. **Build the Unit 2 image**:
   ```bash
   docker build -t unit2-env -f unit2.Dockerfile .
   ```
4. **Run the Unit 2 environment**:

   **For Linux/macOS:**
   ```bash
   docker run --gpus all -p 8888:8888 -v "$(pwd)":/app unit2-env
   ```
   **For Windows (PowerShell):**
   ```bash
   docker run --gpus all -p 8888:8888 -v ${PWD}:/app unit2-env
   ```

Once the container is running, open your browser and go to:

[http://localhost:8888](http://localhost:8888)

For more details and workflow for other units, see the [project root README](../README.md).

---

## Cleanup

To free up disk space or remove old containers/images:

- **Stop the running container:**
  - Press `Ctrl+C` in the terminal where the container is running, or find the container ID with `docker ps` and stop it:
    ```bash
    docker stop <container_id>
    ```
- **Remove stopped containers:**
    ```bash
    docker container prune
    ```
- **Remove images (optional):**
    ```bash
    docker rmi unit2-env base-env
    ```
- **Remove dangling/unused images (optional):**
    ```bash
    docker image prune
    ```