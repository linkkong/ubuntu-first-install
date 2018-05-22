cd /home/m/lnmp
if [ "$1" == "stop" ]; then
    echo "stop lnmp docker"
    docker-compose stop
    exit 1
fi
echo "start lnmp docker"
docker-compose up -d
