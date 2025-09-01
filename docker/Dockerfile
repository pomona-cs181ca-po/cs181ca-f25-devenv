FROM ubuntu:jammy

# set environment variables for tzdata
ARG TZ=America/Los_Angeles
ENV TZ=${TZ}

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update &&\
  yes | unminimize &&\
  apt-get -y install\
  # install GCC-related packages
  binutils-doc cpp-doc gcc-doc g++ g++-multilib gdb gdb-doc glibc-doc\
  libstdc++-10-doc make make-doc cmake\
  # install clang related packages
  clang lldb clang-format\
  # install interactive programs (emacs, vim, nano, man, sudo, etc.)
  bc curl dc git git-doc man micro vim nano\
  # set up libraries
  libreadline-dev locales wamerican libssl-dev\
  # install programs used for networking
  psmisc sudo wget dnsutils inetutils-ping iproute2 net-tools netcat\
  telnet time traceroute \
  # install dependencies for gem5
  build-essential scons python3-dev git pre-commit zlib1g zlib1g-dev \
  libprotobuf-dev protobuf-compiler libprotoc-dev libgoogle-perftools-dev \
  libboost-all-dev  libhdf5-serial-dev python3-pydot python3-venv python3-tk mypy \
  m4 libcapstone-dev libpng-dev libelf-dev pkg-config wget cmake doxygen clang-format \
  # install riscv cross compile
  gcc-riscv64-linux-gnu

# set up default locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

# remove unneeded .deb files
RUN rm -r /var/lib/apt/lists/*

# create binary reporting version of dockerfile
RUN (echo '#\!/bin/sh'; echo 'echo 1') > /usr/bin/cs181ca-docker-version; chmod ugo+rx,u+w,go-w /usr/bin/cs181ca-docker-version

# clone gem5 repo
RUN git clone https://github.com/pomona-cs181ca-po/gem5-assignment-stencil /home/cs181ca-user/gem5 &&\
  chmod ugo+rx,u+w,go-w /home/cs181ca-user/gem5

# compile gem5
RUN cd /home/cs181ca-user/gem5 &&\
  scons build/RISCV/gem5.debug -j4 --linker=gold

# configure your environment
ARG USER=cs181ca\ User
ARG EMAIL=nobody@example.com

USER cs181ca-user
RUN rm -f ~/.bash_logout

WORKDIR /home/cs181ca-user
CMD ["/bin/bash", "-l"]
