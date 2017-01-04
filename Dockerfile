
FROM ubuntu:15.10

RUN \
  apt-get update \
  && apt-get purge -y ruby \
  && apt-get install -y \
    sudo \
    netcat \
    build-essential \
    git \
    vim \
    wget \
    curl \
    nodejs \
    libmysql++-dev

# Make sure the 'ubuntu' user has sudo privileges:
RUN \
  useradd -d /home/ubuntu -m -s /bin/bash ubuntu \
  && echo "ubuntu:changeme" | chpasswd \
  && echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
  && sed -i s#/home/ubuntu:/bin/false#/home/ubuntu:/bin/bash# /etc/passwd

USER ubuntu

RUN \
  cd /tmp && \
  wget -O ruby-install-0.6.0.tar.gz \
    https://github.com/postmodern/ruby-install/archive/v0.6.0.tar.gz && \
  tar -xzvf ruby-install-0.6.0.tar.gz && \
  cd ruby-install-0.6.0/ && \
  sudo make install && \
  sudo ruby-install ruby 2.3.3 --system && \
  sudo gem install rails && \
  sudo gem install bundler

WORKDIR /opt/rails-docker

ENTRYPOINT ["./docker-entrypoint.sh"]
