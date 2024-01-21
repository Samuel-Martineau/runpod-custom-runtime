FROM runpod/base:0.4.4-cuda12.1.0

RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux \
  --extra-conf "sandbox = false" \
  --init none \
  --no-confirm
ENV PATH="${PATH}:/nix/var/nix/profiles/default/bin"
RUN nix-env -f "<nixpkgs>" -iA fish direnv pyenv python311
# COPY config.fish /root/.config/fish/config.fish
# RUN chsh -s $(which fish)
