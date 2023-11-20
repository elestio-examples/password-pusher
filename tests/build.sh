cp containers/docker/pwpush/Dockerfile ./
mv docker-compose-new.yml docker-compose.yml

docker buildx build . --output type=docker,name=elestio4test/password-pusher:latest | docker load