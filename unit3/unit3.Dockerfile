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

# Copy the environment.yml file into the image
COPY environment.yml /tmp/environment.yml

# Update the base-env environment using environment.yml
RUN conda run -n base-env conda env update -n base-env -f /tmp/environment.yml && \
    conda clean -afy

# Copy the rest of the project into the container
WORKDIR /app
COPY . .

# Expose the JupyterLab port
EXPOSE 8888

# Start JupyterLab
CMD ["conda", "run", "-n", "base-env", "jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]