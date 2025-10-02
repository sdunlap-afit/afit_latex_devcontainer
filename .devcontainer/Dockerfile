
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
# texlive user already exists in the base image,
# so we just have to fix sudo permissions.
ARG USERNAME=texlive

##### Allow the user to run sudo commands #####
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Set the default user
USER $USERNAME
WORKDIR /home/$USERNAME
