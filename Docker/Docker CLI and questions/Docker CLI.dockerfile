sudo apt update
 curl -fsSL https://get.docker.com -o install-docker.sh
sudo sh install-docker.sh
sudo usermod -aG docker ubuntu
exit
ssh ubuntu@ip-address
docker info (to check installation)
docker login
sudo nano Dockerfile {write a dockerfile }
docker build -t myimage . {to build docker image}
docker images {to check whether image is created or not}
docker run -d --name demo-container2 -p 8081:8080 mytomcat {to run docker image and container}
docker container create/pause/unpause/start/stop
docker container run -it -d -P --name demo ubuntu:20.04 /bin/bash
docker exec -it demo /bin/bash
docker image inspect imagename {to get sha256 number}
docker rmi $(docker images -a -q) to delete all images at once
docker rm -f $(docker ps -aq)  to delete all containers at once
docker tag imageid syedadnan05/ubuntu_gameoflife:latest {tag image before pushing}
docker push syedadnan05/ubuntu_gameoflife:latest {to push image}
docker run -d --user adnanuser -p 81:80 apache










