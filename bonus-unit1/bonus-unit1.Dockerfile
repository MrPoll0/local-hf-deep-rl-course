FROM base-env

# Install any additional system dependencies
USER root
RUN apt-get update && apt-get install -y git unzip wget && rm -rf /var/lib/apt/lists/*

# Copy the environment.yml file into the image
COPY environment.yml /tmp/environment.yml

# Create a new environment based on environment.yml
RUN conda env create -f /tmp/environment.yml && \
    conda clean -afy && \
    rm -rf /tmp/environment.yml

# Copy the rest of the project into the container
WORKDIR /app
COPY . .

# Clone ML-Agents repo (shallow)
RUN git clone --depth 1 https://github.com/Unity-Technologies/ml-agents /opt/ml-agents

# Install ML-Agents and ML-Agents-Env
RUN conda run -n mlagents-env pip install -e /opt/ml-agents/ml-agents-envs && \
    conda run -n mlagents-env pip install -e /opt/ml-agents/ml-agents

# Download and set up Huggy environment
RUN mkdir -p /opt/ml-agents/trained-envs-executables/linux && \
    wget "https://github.com/huggingface/Huggy/raw/main/Huggy.zip" -O /opt/ml-agents/trained-envs-executables/linux/Huggy.zip && \
    unzip -d /opt/ml-agents/trained-envs-executables/linux/ /opt/ml-agents/trained-envs-executables/linux/Huggy.zip && \
    chmod -R 755 /opt/ml-agents/trained-envs-executables/linux/Huggy

# Expose the JupyterLab port
EXPOSE 8888

# Start JupyterLab
CMD ["conda", "run", "-n", "mlagents-env", "jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]