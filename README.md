# icecast-docker
Docker image for icecast2

## Images

| Image                      | Description                   | Platform  |
| -------------------------- |:-----------------------------:| ---------:|
| numblr/icecast2:alpine.arm | Image for arm64 architecture  | arm64     |


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
    
### EC2 setup

To run an icecast2 server on an EC2 instance install docker and run the server in a docker container on the instance:

* Launch an instance, e.g. t4g.micro with 2vCPU, 1GB RAM, 8GB disk (choose the arm64 architecture).
** In the security group allow ssh and port 8000 (TCP).
* Copy `aws/setup.sh` to the instance and run the script.
* Logout and reconnect.
* Copy `aws/run.sh` to the instance and start the icecast server with the image name as parameter.
* Use `nohup ./run.sh numblr/icecast2:alpine-arm &` to start the server in the background.
* To use a custom configuration copy into the `config/` folder created by the setup script on the instance. Ensure the config file is readable for all users.

The `aws/setup.sh` script will create a `log/` folder on the instance where the server logs will be stored.


## Build

Build the image with

    docker build -t <my/tag:version> .
    docker build -t <my/tag:version> -f Dockerfile.alpine.arm .
