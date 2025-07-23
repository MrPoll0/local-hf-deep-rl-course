# Running Unit 1 Locally

> **CUDA Version Notice:**
> 
> This environment uses **CUDA 12.1** (see the `FROM nvidia/cuda:12.1.1-devel-ubuntu22.04` line in the Dockerfile). Please ensure your GPU and drivers are compatible with CUDA 12.1. If you need a different CUDA version, edit the `FROM` line in `base.Dockerfile` and adjust package versions as needed. See the [NVIDIA CUDA compatibility page](https://docs.nvidia.com/deploy/cuda-compatibility/) for more info.

> **Important:** The section on loading a saved model from the Hugging Face Hub is **not supported** in this local environment due to conflicting dependencies. Please skip this part if following the notebook locally.

---

## Getting Started

1. **Move to the Unit 1 directory:**
   ```bash
   cd unit1
   ```
2. **Build the base image** (if not already built):
   ```bash
   docker build -t base-env -f ../base.Dockerfile .
   ```
3. **Build the Unit 1 image**:
   ```bash
   docker build -t unit1-env -f unit1.Dockerfile .
   ```
4. **Run the Unit 1 environment**:

   **For Linux/macOS:**
   ```bash
   docker run --gpus all -p 8888:8888 -v "$(pwd)":/app unit1-env
   ```
   **For Windows (PowerShell):**
   ```bash
   docker run --gpus all -p 8888:8888 -v ${PWD}:/app unit1-env
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
    docker rmi unit1-env base-env
    ```
- **Remove dangling/unused images (optional):**
    ```bash
    docker image prune
    ```