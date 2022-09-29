# syntax=docker/dockerfile:1


FROM amazonlinux AS builder


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

WORKDIR /icecast

RUN wget http://downloads.xiph.org/releases/icecast/icecast-$iceversion.tar.gz \
  && tar -xzvf icecast-$iceversion.tar.gz

WORKDIR icecast-$iceversion

RUN ./configure && make && make install



# Final stage without compile time libs and layers

FROM amazonlinux


RUN yum update -y && yum install -y \
  libxml2 \
  curl \
  libxslt \
  libvorbis \
  openssl \
  shadow-utils \
  && yum clean all


RUN useradd --system icecast


# Get the installed libraries and applications from the earlier stage.
COPY --from=builder /usr/local/ /usr/local/
COPY --from=builder /icecast/ /icecast/
# Regenerate the shared-library cache.
RUN ldconfig


WORKDIR /icecast

RUN mkdir -p log web admin \
    && chown -R icecast:icecast log \
    && chown -R icecast:icecast web \
    && chown -R icecast:icecast admin

COPY --chmod=0755 uncomment.xslt configure.xslt start.sh ./

CMD ["./start.sh", "/usr/local/etc/icecast.xml"]
