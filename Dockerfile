FROM alpine
MAINTAINER Nick Lang "nick@nicklang.com"

RUN apk add --update \
  less \
  alpine-sdk \
  libtool \
  cmake \
  automake \
  m4 \
  autoconf \
  linux-headers \
  unzip \
  python \
  python-dev \
  py-pip   \
  ncurses-dev \
  && rm -rf /var/cache/apk/*


# Compile vim with python support
RUN git clone https://github.com/vim/vim.git && \
  cd vim && \
  git checkout tags/v7.0232 && \
  ./configure --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config && \
  make && \
  make install && \
  cd .. && rm -rf vim

CMD ["vim"]
