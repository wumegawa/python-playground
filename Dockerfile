FROM python:3

ARG _PROJECT_DIR='/app'

ENV DOCKER_USER='python'
ENV PROJECT_DIR=${_PROJECT_DIR}
ENV PYTHONUNBUFFERED=1

WORKDIR ${_PROJECT_DIR}

RUN adduser --system --group --disabled-password --shell /bin/bash --home ${_PROJECT_DIR} ${DOCKER_USER}

COPY requirements.txt ${_PROJECT_DIR}/
RUN pip install -r requirements.txt
COPY . ${_PROJECT_DIR}/