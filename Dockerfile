FROM alpine
MAINTAINER Nick Lang "nick@nicklang.com"

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
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
  ./configure --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config && \
  make && \
  make install && \
  cd .. && rm -rf vim

ADD vimrc /root/.vimrc
ADD vim /root/.vim
RUN vim +PlugInstall +qall 
RUN /root/.vim/plugged/YouCompleteMe/install.py

CMD ["vim"]
