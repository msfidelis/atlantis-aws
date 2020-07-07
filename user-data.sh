#!/bin/bash

mkdir /atlantis
sudo chmod 777 -R /atlantis

sudo yum install docker amazon-efs-utils telnet -y

systemctl enable docker 

sudo mount -t efs ${efs}:/ /atlantis

$(aws --region ${region} ecr get-login --no-include-email)

docker run --detach \
    --log-opt "awslogs-region=${region}" \
    --log-opt "awslogs-group=/${docker_name}" \
    --name ${docker_name} \
    --network host \
    --restart always \
    --volume /atlantis:/atlantis:rw \
    --volume /var/run/docker.sock:/var/run/docker.sock:rw \
    ${docker_image}