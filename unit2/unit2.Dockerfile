FROM base-env

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
    conda clean -afy

# Step 3: Set up the working directory and copy files
WORKDIR /app
COPY . .

# Step 4: Expose port and define default command
EXPOSE 8888
CMD ["conda", "run", "-n", "base-env", "jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]