# pysparkcluster_indocker_bynetworkcable
The instruction of deploying Pyspark cluster based on docker between two computers by a network cable.

## Requirement:
  1. Two computer with the physical network port;
  2. Extra network cards (2 or more) for the global Internet access;
  3. A network cable;
  4. Linux (e.g., ubuntu) or MS windows installed in these computers;
  5. Vmware station player, if windows.

## Steps:
  1. Install Operation System for each computer;
  2. Plugin the network cable to connect these two;
  3. Plugin extra network cards to make sure they can access the global Internet;
  4. If both linux, \
    4.1 open terminals; \
    4.2 input `sudo su` and fill your password; \
    4.3 install "ifconfig" and "ping" through `apt install net-tools` and `apt install iputils-ping`; \
    4.4 set statisc ip through OS setting;
  ![image](https://user-images.githubusercontent.com/43268820/165883798-6757ffd0-5c53-4cd3-9226-be1ea972f6f2.png)


      


