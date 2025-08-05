FROM base-env

# Install system-level ffmpeg with H.264 support
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libx264-dev \
    libx265-dev \
    libvpx-dev \
    && rm -rf /var/lib/apt/lists/*

# Create the environment for Unit 2
RUN conda run -n base-env conda install -y \
    -c conda-forge \
    gymnasium \
    pygame \
    numpy \
    imageio \
    imageio-ffmpeg \
    pyglet \
    jupyterlab \
    ipywidgets \
    tqdm \
    && \
    conda run -n base-env pip install huggingface_hub pyyaml==6.0 && \
    # Clean up to reduce final image size
    conda clean -afy && \
    # Export the environment to environment.yml
    conda run -n base-env conda env export --no-builds > /environment.yml

# Set up the working directory and copy files
WORKDIR /app
COPY . .

# Expose the JupyterLab port
EXPOSE 8888

# Start JupyterLab
CMD ["conda", "run", "-n", "base-env", "jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]