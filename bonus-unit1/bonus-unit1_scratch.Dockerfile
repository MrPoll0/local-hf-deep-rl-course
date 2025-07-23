FROM base-env

# Install any additional system dependencies
USER root
RUN apt-get update && apt-get install -y git unzip wget && rm -rf /var/lib/apt/lists/*

# Create a new conda environment for ML-Agents
RUN conda create -n mlagents-env python=3.10.12 -y && \
    conda run -n mlagents-env conda install -y -c conda-forge jupyter google-colab traitlets=5.5.0 && \
    conda run -n mlagents-env python -m ipykernel install --name "mlagents-env" --user

WORKDIR /app

# Clone ML-Agents repo (shallow)
RUN git clone --depth 1 https://github.com/Unity-Technologies/ml-agents /opt/ml-agents

# Install ML-Agents and ML-Agents-Env
RUN conda run -n mlagents-env pip install -e /opt/ml-agents/ml-agents-envs && \
    conda run -n mlagents-env pip install -e /opt/ml-agents/ml-agents && \
    conda run -n mlagents-env conda env export --no-builds > /environment.yml

# Download and set up Huggy environment
RUN mkdir -p /opt/ml-agents/trained-envs-executables/linux && \
    wget "https://github.com/huggingface/Huggy/raw/main/Huggy.zip" -O /opt/ml-agents/trained-envs-executables/linux/Huggy.zip && \
    unzip -d /opt/ml-agents/trained-envs-executables/linux/ /opt/ml-agents/trained-envs-executables/linux/Huggy.zip && \
    chmod -R 755 /opt/ml-agents/trained-envs-executables/linux/Huggy

# Expose Jupyter port
EXPOSE 8888

# Sstart Jupyter Lab
CMD ["conda", "run", "-n", "mlagents-env", "jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
