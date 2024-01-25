FROM runpod/pytorch:2.1.1-py3.10-cuda12.1.1-devel-ubuntu22.04

RUN apt-get update && apt-get install -y fish
RUN chsh -s /usr/bin/fish

RUN curl -fsSL https://code-server.dev/install.sh | sh
RUN code-server --install-extension wesbos.theme-cobalt2
RUN code-server --install-extension ms-toolsai.jupyter
RUN code-server --install-extension ms-python.python
RUN code-server --install-extension ms-python.autopep8
COPY settings.json /root/.local/share/code-server/User/settings.json

COPY post_start.sh /post_start.sh
