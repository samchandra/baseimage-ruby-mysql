FROM phusion/baseimage:0.9.22

MAINTAINER Samuel Chandra <sam@buuuk.com>

# install all our usual dependencies, mostly specced for ruby, followed by clean up
RUN apt-get update && apt-get install -y \
  vim \
  wget \
  curl \
  git \
  autoconf \
  bison \
  build-essential \
  libssl-dev \
  libyaml-dev \
  libreadline6-dev \
  zlib1g-dev \
  libncurses5-dev \
  libffi-dev \
  libgdbm3 \
  libgdbm-dev \
  libmysqlclient-dev \
  libcurl3 \
  libcurl3-gnutls \
  libcurl4-openssl-dev \
  libmagickwand-dev \
  ntp \
  tzdata \
  imagemagick \
  redis-server \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /var/tmp/*

# setup time servers
RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/Asia/Singapore /etc/localtime

# install ruby
RUN mkdir -p tmp && cd /tmp && \
  wget https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.gz && \
  tar -xvzf ruby-2.4.1.tar.gz && cd ruby-2.4.1 && \
  ./configure --disable-install-doc && make && make install && \
  rm -rf /tmp/ruby-2.4.1

RUN gem install --no-rdoc --no-ri bundler

# clean up crap in /tmp to reduce size
RUN rm -rf /tmp/*
