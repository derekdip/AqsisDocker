# Use Ubuntu base image
FROM ubuntu:24.04

# Set environment variables to avoid prompts during install
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    g++ \
    libpng-dev \
    build-essential \
    git \
    cmake \
    libboost-all-dev \
    libtiff-dev \
    flex \
    bison \
    libgl-dev libglu-dev \
    zlib1g-dev \
    libjpeg-dev \
    libilmbase-dev \
    libopenexr-dev \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get update
RUN apt install openexr
RUN apt install -y qt5-qmake qtbase5-dev qtchooser qtbase5-dev-tools


# Clone Aqsis repo
RUN git clone https://github.com/aqsis/aqsis.git /opt/aqsis
    # Change submodule URL to HTTPS for partio (and any other submodule that uses SSH)
WORKDIR /opt/aqsis

RUN  rm -f .gitmodules
RUN echo "[submodule \"thirdparty/partio/src\"]" > .gitmodules \
    && echo "    path = thirdparty/partio/src" >> .gitmodules \
    && echo "    url = https://github.com/wdas/partio.git" >> .gitmodules
RUN git submodule sync
RUN git submodule update --init

WORKDIR /opt
RUN mkdir build

WORKDIR /opt/build/
RUN cmake ../aqsis
RUN make
RUN make install

#configure aqsis to be an environmental variable
#for some reason 'make install' didn't point to it correctly
RUN echo 'export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' >> ~/.bashrc

WORKDIR /workspace
CMD ["bash"]
