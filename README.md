# orcahostd-image
Docker image configuration

docker run -e HOSTID="dudes" -e TRAINER_URL="http://orca.beta-1.linewize.net:5001" -e DOCKER_SOCKET="/var/root/run/docker.sock"  -v /var/run:/var/root/run/ orcahostd
