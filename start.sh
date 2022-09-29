#!/bin/bash

if [ -e /icecast/config/icecast.xml ]
then
    config="/icecast/config/icecast.xml"
else
    config="/usr/local/etc/icecast.xml"
fi


echo "Starting with config $config"

xsltproc uncomment.xslt "$config" | \
xsltproc -o /icecast/icecast.docker.xml \
  --stringparam source_pwd "$ICECAST_SOURCE_PWD" \
  --stringparam hostname "$ICECAST_HOST" \
  configure.xslt -

icecast -c /icecast/icecast.docker.xml
