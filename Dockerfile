FROM tensorflow/tensorflow:latest-gpu-jupyter

# Update, upgrade, install packages and clean up
RUN apt-get update --yes && \
  apt-get upgrade --yes && \
  apt install --yes --no-install-recommends git wget curl rsync bash libgl1 software-properties-common openssh-server nginx libcublas-12-0  && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

# Setup Jupyter Notebook
RUN pip install --upgrade --no-cache-dir jupyterlab ipywidgets jupyter-archive jupyter_contrib_nbextensions
RUN pip install notebook==6.5.5
RUN jupyter contrib nbextension install --user && \
  jupyter nbextension enable --py widgetsnbextension

# NGINX Proxy
COPY proxy/nginx.conf /etc/nginx/nginx.conf
COPY proxy/readme.html /usr/share/nginx/html/readme.html

# Copy the README.md
COPY README.md /usr/share/nginx/html/README.md

# Start Scripts
COPY scripts/start.sh /
RUN chmod +x /start.sh

# Custom MOTD
COPY scripts/runpod.txt /etc/motd

# Set the default shell for the container
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /workspace

# Set the default command for the container
CMD [ "/start.sh" ]
