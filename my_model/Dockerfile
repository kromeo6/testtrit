# Base image for Triton Inference Server
FROM nvcr.io/nvidia/tritonserver:23.05-py3

# Update and install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget git bash && \
    rm -rf /var/lib/apt/lists/*

# Set up Miniconda
WORKDIR /workspace
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda && \
    rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH="/opt/miniconda/bin:$PATH"

# # Install necessary Conda packages
# RUN conda install -c conda-forge libstdcxx-ng=12 -y && \
#     conda create -n custom_env python=3.8 -y
RUN conda update -n base -c defaults conda -y && \
    conda install -c conda-forge libstdcxx-ng=12 -y && \
    conda create -n custom_env python=3.8 -y

# Activate Conda environment and install additional dependencies
COPY ./requirements.txt /workspace/requirements.txt
# RUN /opt/miniconda/bin/conda run -n custom_env pip install -r /workspace/requirements.txt && \
#     conda install -c conda-forge conda-pack -y
RUN /opt/miniconda/bin/conda run -n custom_env pip install -r /workspace/requirements.txt && \
    conda install -c conda-forge conda-pack -y && \
    conda install -c conda-forge libstdcxx-ng=12 -y


# Pack the Conda environment
RUN /opt/miniconda/bin/conda run -n custom_env conda-pack -o /workspace/custom_env.tar.gz
ENV PYTHONNOUSERSITE=True

# Clone the Triton Python backend repository
RUN git clone https://github.com/triton-inference-server/python_backend -b r23.05

RUN mkdir -p models 

# Expose Triton server ports
EXPOSE 8000 8001 8002

# Default to interactive shell
CMD ["/bin/bash"]
