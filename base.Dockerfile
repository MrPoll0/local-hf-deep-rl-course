FROM nvidia/cuda:12.1.1-devel-ubuntu22.04

# Install Miniconda and accept ToS
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y wget bzip2 ca-certificates && rm -rf /var/lib/apt/lists/*
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh
ENV PATH /opt/conda/bin:$PATH
RUN conda config --set always_yes yes --set changeps1 no && conda tos accept

# Create a base environment with Python and the heavy PyTorch dependency
RUN conda create -n base-env python=3.11 -y && \
    conda run -n base-env conda install -y \
        -c pytorch \
        -c nvidia \
        pytorch torchvision torchaudio pytorch-cuda=12.1 && \
    conda clean -afy