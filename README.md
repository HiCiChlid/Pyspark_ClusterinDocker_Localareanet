# Spark-cluster-in_docker-by_networkcable
The instruction of deploying Pyspark cluster based on docker between two computers by a network cable.  

## Requirement:
  1. Two computers with the physical network port;  
  2. Extra network cards (2 or more) for the global Internet access;  
  3. One network cable;  
  4. Linux (e.g., ubuntu) or MS Windows installed in these two computers; 
  5. CPU supporting the virtualization technology, if Windows;
  6. Vmware station player, if Windows.

## Steps:
  1. Install Operation System (OS) for each computer;  
  2. Plugin extra network cards to make sure they can access the global Internet;  
  3. Plugin the network cable to connect these two machines;  
  4. If both linux:  
    4.1. Open terminals;  
    4.2. Input `sudo su` and fill your password;  
    4.3. Install "ifconfig" and "ping" through `apt install net-tools` and `apt install iputils-ping`;  
    4.4. Set static ip through OS setting as shown in the following figure, in which you can set a static ip (e.g., 192.168.0.2) and subnet mask (e.g., 255.255.255.0);   
    <div align=center><img src="https://user-images.githubusercontent.com/43268820/165883798-6757ffd0-5c53-4cd3-9226-be1ea972f6f2.png" width="900"></div>    
    4.5. Vertify ip whether having been changed or not through inputing `ifconfig` in terminal;  
    <div align=center><img src="https://user-images.githubusercontent.com/43268820/165884245-72365f1e-7235-4797-a985-b38227c6e086.png" width="600"></div>  
    4.6. Repeat the similar operations in another linux machine, but use another ip within the same network segment, (e.g., 192.168.0.1) and the same subnet mask (e.g., 255.255.255.0);  
    4.7. Vertify two machines' connection through "ping" operation; if appearing "time=xxx.xx ms", it means they are connected;  
    <div align=center><img src="https://user-images.githubusercontent.com/43268820/165884601-7d5839a2-0081-437e-bf2d-0d04134efd49.png" width="600"></div>  
 5. If one linux and one Windows:  
    5.1. Linux physical machine(PhyM)'s configration refers to step4;  
    5.2. In Windows host machine(HostM), install Vmware station player sofware and create a new Vmware machine(VM);  
    5.3. Install linux OS (e.g., ubuntu) for VM and install some softwares referring to step 4.3; To use the shared clipboard, please install `apt install open-vm-tools open-vm-tools-desktop` in VM.  
    5.4. Network configuration:  
    &ensp;&ensp;5.4.1. Open Vmware station player software, and bridge the v-net card with the net card with physical net port (or called as Ethernet), as shown in the following figure;  
        <div align=center><img src="https://user-images.githubusercontent.com/43268820/165894176-eaabd33a-2bba-4265-b509-4549cf5471ab.png" width="900"></div>  
    &ensp;&ensp;5.4.2. To make VM access global Internet, add one more v-net card using NAT mode;  
        <div align=center><img src="https://user-images.githubusercontent.com/43268820/165895085-86436994-6282-4301-bbf0-3fe06268fa3e.png" width="900"></div>  
    &ensp;&ensp;5.4.3. Set static ip for Windows host machine (HostM), and you can click Start > Settings > Control Panel > Network and Internet > Network and Sharing Center > Change adapter settings.  
        <div align=center><img src="https://user-images.githubusercontent.com/43268820/165895852-d7cef5cb-3dfe-4c25-b8a8-bdea2f7dae30.png" width="600"></div>  
        Right click Ethernet, and set static ip (e.g., 192.168.0.1) and subnet mask (e.g., 255.255.255.0, the same as the above setting);  
        <div align=center><img src="https://user-images.githubusercontent.com/43268820/165896789-7feabff9-ddc1-4609-8c40-7e6037e49e9b.png" width="600"></div>
    &ensp;&ensp;5.4.4. Set static ip for VM's linux, referring step 4.6, but change the ip as 196.168.0.3;  
    &ensp;&ensp;5.4.5. Now three machines, including linux physical machine (PhyM), Windows host machine (HostM) and Vmware machine (VM) are located in the same local area network, we can vertify them through "ping":  
        In VM:  
        <div align=center><img src="https://user-images.githubusercontent.com/43268820/165898924-16fa25ec-9dd9-43ea-817d-0d4eb0cfe28b.png" width="600"></div>  
        In HostM:  
        <div align=center><img src="https://user-images.githubusercontent.com/43268820/165899678-5388706e-2fec-430b-b75d-e9458ce94205.png" width="600"></div>  
        In PhyM:  
        <div align=center><img src="https://user-images.githubusercontent.com/43268820/165899990-77df93d5-72e8-4fa4-a20a-961f0af8eb05.png" width="600"></div>  
  6. Install docker for linux machines (both in PhyM and VM):  
    6.1. Input `sudo apt-get install ca-certificates curl gnupg lsb-release` in terminal and wait for installation finishing;  
    6.2. Input `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg` and press 'Enter';  
    6.3. Input `echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null` and press 'Enter';  
    6.4. Input `sudo apt-get update`;  
    6.5. Input `sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin`;  
    6.6. Input `sudo docker run hello-world` to vertify the installation;  
    6.7. Refer to the [link](https://docs.docker.com/engine/install/linux-postinstall/) to do more things for docker，e.g., non-root user, starting on boot.  
  7. Install spark and some other softwares as the master node through dockerfile `docker build -t your_image_name:master https://raw.githubusercontent.com/HiCiChlid/geosci-pyenv/main/dockerfile`.  
     Install the slave node through dockerfile `docker build -t your_image_name:slave https://raw.githubusercontent.com/HiCiChlid/pysparkcluster_indocker_bynetworkcable/main/dockerfile`  
     You can choose which node to deploy on which one machine.  
  8. Open net card promiscuous mode for both linux machines，`ip link set eno1 promisc on` for PhyM's ethernet net card named as eno1, and `ip link set ens33 promisc on` for VM's net card named as ens33. If success, "ifconfig" appears PROMISC as shown in red rectangle.  <div align=center><img src="https://user-images.githubusercontent.com/43268820/165923712-b55b41fb-0204-4279-9d73-5d697342b417.png" width="600"></div>
  9. Due to PhyM and VM are connected through HostM (192.168.0.1), so the Gateway is 192.168.0.1;  
  10. Create docker net card for PhyM `docker network create -d macvlan --subnet=192.168.0.30/24 --gateway=192.168.0.1 -o parent=eno1 -o macvlan_mode=bridge eth0_1`,  (subnet=192.168.0.30, just an example);  
    and similarly, we can create docker net card for VM `docker network create -d macvlan --subnet=192.168.0.40/24 --gateway=192.168.0.1 -o parent=ens33 -o macvlan_mode=bridge eth0_1`, (subnet=192.168.0.40, just an example);  
    and we can check the docker network to find the new net card through `docker network ls`;  
    <div align=center><img src="https://user-images.githubusercontent.com/43268820/165931945-d90a6a29-81c3-461f-8a79-ecc257b3bef2.png" width="600"></div>  
  11. Mount HostM's folders to VM, and set it self-booting, referring to the [link](https://linuxhint.com/mount_vmware_shares_command_line_linux_vm/#:~:text=To%20share%20a%20directory%2Ffolder%20from%20the%20host%20to%20a,Shared%20Folders%2C%20select%20Always%20enabled).  
     Self-booting: after `sudo su` add `.host:/ /mnt fuse.vmhgfs-fuse allow_other,defaults 0 0` to /etc/fstab.  
  12. Create docker containers for two machines,  
    In VM node1 `docker run --privileged --net=eth0_1 --ip=192.168.0.40 -v /mnt/[connected_folder]:/home/current -id --name=geosci-env_M40 -p 8888:8888 -p 4040:4040 --shm-size 2g your_image_name:master /bin/bash`;  
    In VM node2 `docker run -it --privileged --net=eth0_1 --ip=192.168.0.41 --name=spark41 your_image_name:slave /bin/bash`;  
    In PhyM node1 `docker run -it --privileged --net=eth0_1 --ip=192.168.0.30 --name=spark30 your_image_name:slave /bin/bash`;  
    In PhyM node2 `docker run -it --privileged --net=eth0_1 --ip=192.168.0.31 --name=spark31 your_image_name:slave /bin/bash`;   
  13. Check network connections between containers, for example, "spark40" ping "spark30"; or "spark31" ping "spark41";  <div align=center><img src="https://user-images.githubusercontent.com/43268820/165934538-d2d8d1cd-b320-4b6e-a2d7-dfa6d31ee392.png" width="600"></div>
      I hope master node to access the global Internet, I can input `docker network connect bridge geosci-env_M40`, and test it through `ping www.google.com`.  
      <div align=center><img src="https://user-images.githubusercontent.com/43268820/166199407-49e504c2-b993-4ebb-9fff-2f511e4d02a7.png" width="600"></div>
  14. Configure one node (e.g., spark40) to log in to other containers through SSH without password.  
      14.1. Start all relevant containers in both PhyM and VM. `docker start spark40` (and spark41, spark30, spark31);  
      14.2. Attain the node (e.g., spark40), `docker exec -it spark40 /bin/bash`;  
      14.3. In spark40, input `sh gs.sh` to generate the public/private rsa key pair; <div align=center><img src="https://user-images.githubusercontent.com/43268820/166130560-d736f485-9563-476c-904a-1629c14ef05e.png" width="600"></div>  
      14.4. Copy the key to other docker containers,  
      `ssh-copy-id root@192.168.0.41`, and input the password `abc123` (you can change it by yourselves);  <div align=center><img src="https://user-images.githubusercontent.com/43268820/166130655-a9b6fbc1-98f9-425a-b80f-21d34e176130.png" width="600"></div>   
      `ssh-copy-id root@192.168.0.30`, and input the password `abc123`;  
      `ssh-copy-id root@192.168.0.31`, and input the password `abc123`;  
      14.5. test the ssh connection, `ssh root@192.168.0.41` etc.  
      <div align=center><img src="https://user-images.githubusercontent.com/43268820/166130719-8b26daf5-a790-4d37-ac9b-4e8adcee9fef.png" width="600"></div> 
  15. Configure VScode (in Windows host machine, 192.168.0.1) to realize remotely control linux PhyM and VM.  
      15.1. Open VScode and install "Remote - SSH" plugin;<div align=center><img src="https://user-images.githubusercontent.com/43268820/166130878-f553dbbf-ffef-4b80-89a6-5c8d4212682b.png" width="300"></div>
      15.2. Install SSH for windows, referring to the [link](https://websiteforstudents.com/how-to-install-openssh-client-in-windows-11/);  
      15.3. Open powershell (or Terminal), and then generate the public/private rsa key pair through inputing `ssh-keygen`. (p.s., using password function may cause this [issue](https://github.com/microsoft/vscode-remote-release/issues/2581).);  
      15.4. Copy the key to other machines (including PhyM, VM, Docker containers, etc.) by the example:  
      `type $env:USERPROFILE\.ssh\id_rsa.pub | ssh root@192.168.0.40 "cat >> ~/.ssh/authorized_keys"`  
      If not root user, you can just input:  
      `type $env:USERPROFILE\.ssh\id_rsa.pub | ssh 192.168.0.2 "cat >> ~/.ssh/authorized_keys"`  
      15.5. Create SSH nodes in "Remote - SSH", you can click '+',<div align=center><img src="https://user-images.githubusercontent.com/43268820/166132148-350ad000-9b08-43d6-9354-561f93a2a98f.png" width="300"></div>  
      and input `ssh root@192.168.0.40` and then press 'Enter' (or for non-root user `ssh 192.168.0.2`), and then choose the first one config path; <div align=center><img src="https://user-images.githubusercontent.com/43268820/166132232-bc139e00-c977-4c29-a536-1138b2c65534.png" width="600"></div>  
      15.6. Log in the node through click the right folder icon, and wait for a minute to attain the node (including PhyM, VM, and Docker containers);  
      <div align=center><img src="https://user-images.githubusercontent.com/43268820/166132355-e4743cfa-c089-476b-80c8-95608b54f5a7.png" width="600"></div>  
      15.7. When logining to PhyM and VM through SSH in VScode, we can also install "Docker" plugin to manage the docker images and containers.
      <div align=center><img src="https://user-images.githubusercontent.com/43268820/166132416-58c2790f-3807-4a98-9e01-f30db64a33d0.png" width="300"></div>  
      <div align=center><img src="https://user-images.githubusercontent.com/43268820/166132433-82535320-aa91-4daa-8a16-2015a523253e.png" width="300"></div>  
 16. Configure spark cluster  
      16.1. Attain spark configration path, `cd /usr/local/spark/conf`;  
      16.2. Create environmental file through `cp spark-env.sh.template spark-env.sh`;  
      16.3. Add Java home to spark-env.sh, `vim spark-env.sh`, press 'i' to enter "Insert" mode, and type `export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64`, and then press 'esc' to end the insert mode, and then press ':wq' to exit vim;   
      <div align=center><img src="https://user-images.githubusercontent.com/43268820/166191310-f6cfff94-fdb1-4775-80e4-cc85568434f6.png" width="600"></div>  
      
      16.4. Copy spark-env.sh to other nodes (docker containers),  
       `scp /usr/local/spark/conf/spark-env.sh root@192.168.0.41:/usr/local/spark/conf`,  
       `scp /usr/local/spark/conf/spark-env.sh root@192.168.0.30:/usr/local/spark/conf`,  
       `scp /usr/local/spark/conf/spark-env.sh root@192.168.0.31:/usr/local/spark/conf`;  
      16.5. Create slave file through `cp slave.template slave`;  
      16.6. Edit slave file, `vim slaves`, press 'i' to enter "Insert" mode, delete localhost and type  
      ```
      192.168.0.41
      192.168.0.30
      192.168.0.31
      ```  
      into it, and then press `esc` to end the insert mode, and then press `:wq` to exit vim;   
      <div align=center><img src="https://user-images.githubusercontent.com/43268820/166191622-9b114e84-841d-427f-be0e-61d8aab85029.png" width="600"></div>

      16.7. Change node's ip with hostname (otherwise authentication disabled issues, referring to the [link](https://zhuanlan.zhihu.com/p/163407531));  
      &ensp;&ensp;16.7.1. Remember each docker container's id through `docker ps -a`;  
          <div align=center><img src="https://user-images.githubusercontent.com/43268820/166151412-22330d32-6073-422c-9db2-8abb345c096b.png" width="900"></div>  
      &ensp;&ensp;16.7.2. In Vm or PhyM, stop docker service, `service docker stop`;  
      &ensp;&ensp;16.7.3. Go to the path `cd /var/lib/docker/containers/bc...` where docker can be configured through changing the files;  
          <div align=center><img src="https://user-images.githubusercontent.com/43268820/166151077-8612c58e-ff24-471d-b04b-160f03c808ef.png" width="600"></div>  
      &ensp;&ensp;16.7.4. Change orginal Hostname in file 'hostname' and 'config.v2.json' to `master` as an example (also change slave41, slave30, slave31 in other machines);  
          <div align=center><img src="https://user-images.githubusercontent.com/43268820/166151744-ab9e71e7-8cd8-45f9-8fda-cd4221bce796.png" width="900"></div>
          <div align=center><img src="https://user-images.githubusercontent.com/43268820/166190077-e4a789f2-639f-41c9-a4b7-4a59ee87c595.png" width="600"></div> 
          <div align=center><img src="https://user-images.githubusercontent.com/43268820/166189967-201e672a-2bd2-41ad-b032-0735d656df36.png" width="600"></div> 

      &ensp;&ensp;16.7.5. Create a host change scrtipt `init.sh` to change the hosts:  
      &ensp;&ensp;&ensp;&ensp;16.7.5.1. Attain 'master' node;  
      &ensp;&ensp;&ensp;&ensp;16.7.5.2. Input `vim /root/init.sh` and write the following contents into it:  
        ```
        #!/bin/bash
        echo 127.0.0.1 localhost > /etc/hosts
        echo 192.168.231.30 slave30 >> /etc/hosts
        echo 192.168.231.31 slave31 >> /etc/hosts
        echo 192.168.231.40 master >> /etc/hosts
        echo 192.168.231.41 slave41 >> /etc/hosts
        /bin/bash
        ```
      &ensp;&ensp;&ensp;&ensp;16.7.5.3. `chmod +x /root/init.sh`  
      &ensp;&ensp;&ensp;&ensp;16.7.5.4. Copy it to the other three nodes, through  
      `scp /root/init.sh root@192.168.0.41:/root/init.sh`;  
      `scp /root/init.sh root@192.168.0.30:/root/init.sh`;  
      `scp /root/init.sh root@192.168.0.31:/root/init.sh`;  
      &ensp;&ensp;&ensp;&ensp;16.7.5.5. Exit the current nodes through inputting `exit` and stop these containers `docker stop slave_41` etc, and then open these containers through `docker start slave_41` etc.;  
      &ensp;&ensp;&ensp;&ensp;16.7.5.6. Re-attain these four nodes through  
      `docker exec geosci-env_M40 /root/init.sh`;  
      `docker exec slave_41 -it /root/init.sh`;  
      `docker exec slave_30 -it /root/init.sh`;  
      `docker exec slave_31 -it /root/init.sh`.      
      16.8. Start Spark Cluster  
      &ensp;&ensp;16.8.1 Go to spark path `cd /usr/local/spark`;  
      &ensp;&ensp;16.8.2 Run `./sbin/start-all.sh`;    
      &ensp;&ensp;16.8.3 Input `192.168.0.40:8080` at HostM's brower and you can see: 
      <div align=center><img src="https://user-images.githubusercontent.com/43268820/166196184-4207b278-3dbc-4c41-87cd-449b4787047e.png" width="900"></div>
      There are three workers in the spark cluster;  
      
      &ensp;&ensp;16.8.4 You can also change the [hosts](https://docs.rackspace.com/support/how-to/modify-your-hosts-file/) in HostM, through add `192.168.0.40 master` in the file, and if inputing 'master:8080', it can also work.
      <div align=center><img src="https://user-images.githubusercontent.com/43268820/166197350-365d0946-bbf6-44b9-863f-dd775cb23382.png" width="300"></div>
  
      16.9. Test spark cluster  
      &ensp;&ensp;16.9.1 Go to spark path `cd /usr/local/spark`;  
      &ensp;&ensp;16.9.2 Input `./bin/spark-submit --master spark://192.168.0.40:7077 --class org.apache.spark.examples.SparkPi examples/jars/spark-examples_2.11-2.4.5.jar 10000`  
      We can find:  
      <div align=center><img src="https://user-images.githubusercontent.com/43268820/166197829-c6ce290e-bbd9-44c2-9a43-a4f1182f54a4.png" width="600"></div>
      <div align=center><img src="https://user-images.githubusercontent.com/43268820/166197882-ed320699-9055-4a5a-a22f-294209e08eee.png" width="900"></div>
      <div align=center><img src="https://user-images.githubusercontent.com/43268820/166197932-951ad58f-cf4e-43c5-bd0e-9de37dc2f1d5.png" width="900"></div>
**Successfully!! Deploying Spark cluster based on dockers between two computers by a network cable**
