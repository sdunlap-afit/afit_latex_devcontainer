
FROM texlive/texlive:latest


RUN apt update && apt install -y \
    git ssh sudo \
    ant biber \
    xz-utils
    

# https://github.com/jgraph/docker-drawio/blob/dev/main/Dockerfile
RUN cd /tmp && \
    git clone --depth 1 https://github.com/jgraph/drawio.git && \
    cd /tmp/drawio/etc/build/ && \
    ant war


##### Update non-root user #####

ARG USERNAME=texlive
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# ##### Create user for Ubuntu 22.04 #####
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# # [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME
WORKDIR /home/$USERNAME
