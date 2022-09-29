FROM amazonlinux

RUN yum update -y \
  && yum groupinstall -y "Development Tools" \
  && yum install -y \
  docker \
  vim-enhanced \
  git \
  libxml2 \
  libxslt \
  curl \
  openssl \
  autoconf \
  libxslt-devel \
  libxslt-devel \
  libvorbis \
  libvorbis-devel \
  openssl \
  wget \
  && yum clean all

RUN useradd --system icecast

WORKDIR icecast

RUN wget http://downloads.xiph.org/releases/icecast/icecast-2.4.4.tar.gz \
  && tar -xzvf icecast-2.4.4.tar.gz

WORKDIR icecast-2.4.4

RUN ./configure && make && make install

WORKDIR ..

RUN mkdir -p log web admin \
    && chown -R icecast:icecast log \
    && chown -R icecast:icecast web \
    && chown -R icecast:icecast admin

RUN cat "/usr/local/etc/icecast.xml" | \
  sed "s#/usr/local/var/log/icecast#/icecast/log#g" | \
  sed "s#/usr/local/share/icecast/web#/icecast/web#g" | \
  sed "s#/usr/local/share/icecast/admin#/icecast/admin#g" | \
  perl -00pe "s#.*<[!]--.*\n.*<changeowner>.*\n.*\n.*\n.*</changeowner>.*\n.*-->.*#<changeowner><user>icecast</user><group>icecast</group></changeowner>#g" \
  > icecast.xml

CMD ["icecast", "-c", "/icecast/icecast.xml"]