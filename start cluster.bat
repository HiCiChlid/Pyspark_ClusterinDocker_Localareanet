ssh 192.168.0.3 "docker start geosci-env_M40;  docker exec geosci-env_M40 /root/init.sh; docker start slave41;  docker exec slave41 /root/init.sh"
ssh 192.168.0.2 "docker start slave30; docker exec slave30 /root/init.sh; docker start slave31; docker exec slave31 /root/init.sh"
