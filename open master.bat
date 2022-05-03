@echo off
if not defined TAG (
    set TAG=1
    start wt -p "Windows PowerShell" %0
    exit
)

ssh 192.168.0.3 -t "docker start geosci-env_M40; docker exec geosci-env_M40 /root/init.sh; docker exec -it geosci-env_M40 /bin/zsh"
pause
