FROM debian:wheezy

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential cmake curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl http://iweb.dl.sourceforge.net/project/anope/anope-stable/Anope%202.0.1/anope-2.0.1-source.tar.gz | tar xz && \
    cd anope-2.0.1-source && \
    mkdir build && \
    cd build && \
    cmake \
      -DINSTDIR:STRING=/opt/services \
      -DDEFUMASK:STRING=077  \
      -DCMAKE_BUILD_TYPE:STRING=RELEASE \
      -DUSE_RUN_CC_PL:BOOLEAN=ON \
      -DUSE_PCH:BOOLEAN=ON .. && \
    make && \
    make install

ADD config/* /opt/services/conf/

ADD run.sh /tmp/run.sh

# Default command to run on boot
CMD ["/tmp/run.sh"]
