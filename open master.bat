@echo off
if not defined TAG (
    set TAG=1
    start wt -p "Windows PowerShell" %0
    :: Windows Terminal中你想要使用的配置名，我这里是“Windows PowerShell”
    exit
)

ssh 192.168.0.3 -t "docker start geosci-env_M40; docker exec -it geosci-env_M40 /bin/zsh"
pause
