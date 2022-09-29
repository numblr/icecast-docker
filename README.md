# icecast-docker
Docker image for icecast2

## Build

    docker build -t <my/tag:version> .

## Usage

    docker run --rm -p 8000:8000 <my/tag:version>
    docker run --rm -p 8000:8000 \
        -v /path/to/config:/icecast/config/ \
        -v /path/to/log_dir:/icecast/log \
        -v /path/to/web:/icecast/web \
        -v /path/to/admin:/icecast/admin \
        <my/tag:version>

or use the prebuilt image

    docker run --rm -p 8000:8000 numblr/icecast2:latest
