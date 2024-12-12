docker run -v /path/to/host/models:/workspace/python_backend/models \
  --shm-size=1g --ulimit memlock=-1 -p 8000:8000 -p 8001:8001 -p 8002:8002 \
  -ti triton_custom_image



wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
export PATH=~/miniconda3/bin:$PATH
conda install -c conda-forge libstdcxx-ng=12 -y

conda create -n custom_env python=3.8 -y
conda init
exec bash
conda activate custom_env
pip install -r requirements.txt

export PYTHONNOUSERSITE=True


conda install -c conda-forge conda-pack
conda-pack -n custom_env -o custom_env.tar.gz

conda update -n base -c defaults conda

conda install -c conda-forge libstdcxx-ng=12 -y
tritonserver --model-repository `pwd`/models



# to run from new it shell
1. exec bash
2.conda install -c conda-forge libstdcxx-ng=12 -y
3. conda-pack -n custom_env -o custom_env.tar.gz
