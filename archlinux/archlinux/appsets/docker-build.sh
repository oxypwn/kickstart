#!/usr/bin/env bash
# Setting up a dev environment
# http://docs.docker.io/en/latest/contributing/devenvironment/

sudo systemctl stop docker-build.service
sudo systemctl start docker.service

cd ~/Dropbox/github.com/dotcloud/docker && git pull
docker rmi docker
docker build -t docker .
docker run docker sh -c 'cat $(which docker)' > docker-build && chmod +x docker-build
sudo mv docker-build /usr/bin/docker-build


sudo bash -c "cat > /usr/lib/systemd/system/docker-build.service << EOF
[Unit]
Description=Docker Daemon
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/docker-build -d

[Install]
WantedBy=multi-user.target

EOF"

sudo systemctl stop docker.service
sudo systemctl --system daemon-reload
sudo systemctl start docker-build.service
