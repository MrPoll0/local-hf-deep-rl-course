FROM nvidia/cuda:12.1.1-devel-ubuntu22.04

# Set environment variables to prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install basic utilities and Miniconda prerequisites
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download and install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh
ENV PATH /opt/conda/bin:$PATH

# Accept the Terms of Service
RUN conda config --set always_yes yes --set changeps1 no && conda tos accept

# Create the environment
RUN conda create -n unit1-env python=3.11 -y && \
    conda run -n unit1-env conda install -y \
    -c pytorch \
    -c nvidia \
    -c conda-forge \
    pytorch torchvision torchaudio pytorch-cuda=12.1 \
    gymnasium=0.28.1 \
    stable-baselines3 \
    "box2d-py>=2.3.5" \
    pygame \
    jupyterlab \
    ipywidgets \
    moviepy \
    ffmpeg \
    && \
    conda run -n unit1-env pip install huggingface_sb3 sympy==1.13.1 && \
    # Clean up to reduce final image size
    conda clean -afy

# Copy the rest of the project into the container
WORKDIR /app
COPY . .

# Expose the JupyterLab port
EXPOSE 8888

# Start JupyterLab
CMD ["conda", "run", "-n", "unit1-env", "jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]