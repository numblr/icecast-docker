# icecast-docker
Docker image for icecast2

## Build

    docker build -t <my/tag:version> .

## Usage

    docker run --rm -p 8000:8000 <my/tag:version>
    
or use the prebuilt image
    
    docker run --rm -p 8000:8000 numblr/icecast2:latest
