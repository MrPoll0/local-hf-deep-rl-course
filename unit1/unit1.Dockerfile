FROM base-env

# Create the environment for Unit 1
RUN conda run -n base-env conda install -y \
    -c conda-forge \
    gymnasium=0.28.1 \
    stable-baselines3 \
    "box2d-py>=2.3.5" \
    pygame \
    jupyterlab \
    ipywidgets \
    moviepy \
    ffmpeg \
    && \
    conda run -n base-env pip install huggingface_sb3 sympy==1.13.1 && \
    # Clean up to reduce final image size
    conda clean -afy

# Copy the rest of the project into the container
WORKDIR /app
COPY . .

# Expose the JupyterLab port
EXPOSE 8888

# Start JupyterLab
CMD ["conda", "run", "-n", "base-env", "jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]