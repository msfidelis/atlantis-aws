#!/bin/bash

mkdir /atlantis
sudo chmod 777 -R /atlantis

sudo yum install docker amazon-efs-utils telnet -y

systemctl start docker 
systemctl enable docker

sudo mount -t efs ${efs}:/ /atlantis

# uid and gid for atlantis user on container
chown 100:1000 /atlantis

$(aws --region ${region} ecr get-login --no-include-email)

docker run --detach \
    --name ${docker_name} \
    --network host \
    --restart always \
    --volume /atlantis:/atlantis:rw \
    --volume /var/run/docker.sock:/var/run/docker.sock:rw \
    ${docker_image}