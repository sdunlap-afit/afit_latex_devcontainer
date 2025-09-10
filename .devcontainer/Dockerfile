# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.177.0/containers/debian/.devcontainer/base.Dockerfile

# [Choice] Version: bullseye-[slim|full], focal-[slim|full], alpine
# For bullseye and focal also language specific version exist. Use bullseye-<LANG>, focal-<LANG>
# LANG: [all, arabic, chinese, cjk, cyrillic, czechslovak, english, european, french, german, greek, italian, japanese, korean, other, polish, portuguese, spanish]
# Set in .devcontainer/devcontainer.json
ARG VARIANT="noble" 
FROM hegerdes/vscode-latex:${VARIANT}


RUN apt update && apt install -y \
    texlive-latex-recommended \
    texlive-bibtex-extra \
    biber

# Example for version 24.7.5 - check for the latest version
RUN sudo apt update && \ 
    apt-get install -y wget libnotify4 libsecret-1-0 && \
    cd /tmp && \
    wget https://github.com/jgraph/drawio-desktop/releases/download/v28.0.6/drawio-amd64-28.0.6.deb -O drawio.deb && \
    # Install the package (you may need to install dependencies)
    sudo dpkg -i drawio.deb && \
    # If it complains about missing dependencies, run:
    sudo apt-get install -f -y && \
    sudo rm drawio.deb

