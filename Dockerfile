FROM amazonlinux


ARG iceversion=2.4.4


RUN yum update -y \
  && yum groupinstall -y "Development Tools" \
  && yum install -y \
  libxml2 \
  curl \
  libxslt-devel \
  libvorbis-devel \
  openssl \
  wget \
  && yum clean all

RUN useradd --system icecast

WORKDIR icecast

RUN wget http://downloads.xiph.org/releases/icecast/icecast-$iceversion.tar.gz \
  && tar -xzvf icecast-$iceversion.tar.gz

WORKDIR icecast-$iceversion

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
