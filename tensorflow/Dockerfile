FROM tensorflow/tensorflow:2.1.1

RUN apt update && apt install -y --no-install-recommends \
    python3-flake8 \
    python-autopep8 \
    git \
    python3-h5py \
    python3-pip

RUN pip install pyyaml tensorflow_datasets

RUN useradd --create-home --shell /bin/bash -u 1000 appuser
USER appuser

VOLUME [/tests]
