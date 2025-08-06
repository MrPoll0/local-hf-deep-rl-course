FROM base-env

# Install system-level dependencies
RUN apt-get update && apt-get install -y \
    swig \
    cmake \
    ffmpeg \
    python3-opengl \
    xvfb \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create the environment for Unit 3
RUN conda run -n base-env pip install \
    git+https://github.com/DLR-RM/rl-baselines3-zoo \
    gymnasium[atari] \
    gymnasium[accept-rom-license] \
    gym==0.22 \
    pyvirtualdisplay \
    jupyterlab \
    ipywidgets \
    opencv-python \
    moviepy \
    && \
    conda run -n base-env pip install huggingface_hub && \
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