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
  4. If both linux: \
    4.1 Open terminals; \
    4.2 Input `sudo su` and fill your password; \
    4.3 Install "ifconfig" and "ping" through `apt install net-tools` and `apt install iputils-ping`; \
    4.4 Set static ip through OS setting as shown in the following figure, in which you can set a static ip (e.g., 192.168.0.2) and subnet mask (e.g., 255.255.255.0); \
    <div align=center><img src="https://user-images.githubusercontent.com/43268820/165883798-6757ffd0-5c53-4cd3-9226-be1ea972f6f2.png" width="900"></div>
    4.5 Vertify ip whether having been changed or not through inputing `ifconfig` in terminal; \
    <div align=center><img src="https://user-images.githubusercontent.com/43268820/165884245-72365f1e-7235-4797-a985-b38227c6e086.png" width="900"></div>
    4.6 Repeat the similar operations in another linux machine, but use another ip within the same network segment, (e.g., 192.168.0.1) and the same subnet mask (e.g., 255.255.255.0); \
    4.7 Vertify two machines' connection through "ping" operation; if appearing "time=xxx.xx ms", it means they are connected; \
    <div align=center><img src="https://user-images.githubusercontent.com/43268820/165884601-7d5839a2-0081-437e-bf2d-0d04134efd49.png" width="900"></div>
 5. If one linux, one Windows: \
    5.1




      


