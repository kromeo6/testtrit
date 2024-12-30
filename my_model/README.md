# Triton model with python backend
purpose of this file is to explain how VAD model has to be deployed. Before merging to main build-artifacts directory can be removed including this file.

## Table of Contents

- [About](#about)
- [Instructions for generating artifacts](#instructions-for-generating-artifacts)
- [Usage](#python-backend-with-conda-pack-and-python-stub)

## About

In order to use not python 3.10 version conda-pack needs triton_python_backend_stub
pyannote.audio 1.1.1 release cant run in python 3.10 environment because of dependecy conflicts.

## Instructions for generating artifacts:

1. Ensure the following ARG values are set in your `Dockerfile`:
   ```Dockerfile
   ARG PYTHON_VERSION=3.8
   ARG GIT_BRANCH_NAME=r24.09
   ARG TRITON_ENABLE_GPU=ON
   ``` 
   The `BASE_IMAGE` has to be the Docker image that is currently used in production
2. Build the image and run:
   ```
    $ cd buld-artifacts
    $ docker build -t triton-mage .
    $ bash build-artifacts.sh
   ```
## Python backend with conda-pack and python stub

Generated files, `py_env.tar.gz` and `triton_python_backend_stub` has to be moved to `models/vad` directory 

```
models
|-- model_a
|   |-- 1
|   |   `-- model.py
|   |-- config.pbtxt
|   |-- python3.6.tar.gz
|   `-- triton_python_backend_stub
```

   
