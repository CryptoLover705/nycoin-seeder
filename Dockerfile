# ===============================================================================
# Dockerfile
#   Builds nycoin and the executable binary, "newyorkcd"
#
#
# It is based on Ubuntu 14.04 LTS
# ===============================================================================

# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER NYCoin_Community

# ===============================================================================
# Env. Setup
#

# Update repository
RUN apt-get update && apt-get -y upgrade

# ----------------------------------------------------------
# Dependencies
# ----------------------------------------------------------

# Basic Dependencies
#
RUN apt-get install -y git \
            telnet \
            unzip \
            build-essential \
            libboost-all-dev \
            libssl-dev \
            libtool \
            vim \
            curl \
            nginx
# ===============================================================================
# Set working directory
#
WORKDIR /work
COPY docker/nginx-default /etc/nginx/sites-enabled/default
# ===============================================================================
# Install configuration
#

# ===============================================================================
# System Initialization
#

## Copy folders

RUN git clone https://github.com/NewYorkCoin-NYC/nycoin-seeder.git /work
RUN cd /work && make

# Set default CMD
CMD service nginx start  && /work/dnsseed -h dnsseed.nycoin.community -n ns.nycoin.community -m dns@nycoin.community

EXPOSE 53:53/udp
