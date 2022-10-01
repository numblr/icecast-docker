#!/bin/bash

image="${1:-numblr/icecast2:alpine-arm}"

docker run --rm -p 8000:8000 \
    -v /home/ec2-user/config:/icecast/config \
    -v /home/ec2-user/log:/icecast/log \
    -v /home/ec2-user/web:/icecast/web \
    -v /home/ec2-user/admin:/icecast/admin \
    "$image"
