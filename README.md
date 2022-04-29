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
  2. Plugin extra network cards to make sure they can access the global Internet;
  3. Plugin the network cable to connect these two;
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
 5. If one linux and one Windows: \
    5.1 Linux machine's configration refers to step4; \
    5.2 In Windows, install Vmware station player(VM); \
    5.3 Install linux (e.g., ubuntu) in the VM and install some softwares referring to step 4.3; \
    5.4 Network configuration: \
        5.4.1 In Vmware station player, bridge the v-net card with the net card with physical net port (or called as Ethernet), as shown in the following figure; \
        <div align=center><img src="https://user-images.githubusercontent.com/43268820/165894176-eaabd33a-2bba-4265-b509-4549cf5471ab.png" width="900"></div>
        5.4.2 To make VM access global Internet, add one more v-net card using NAT mode;
        <div align=center><img src="https://user-images.githubusercontent.com/43268820/165895085-86436994-6282-4301-bbf0-3fe06268fa3e.png" width="900"></div>
        5.4.3 Set static ip for windows, and you can click Start > Settings > Control Panel > Network and Internet > Network and Sharing Center > Change adapter settings. \
        <div align=center><img src="https://user-images.githubusercontent.com/43268820/165895852-d7cef5cb-3dfe-4c25-b8a8-bdea2f7dae30.png" width="900"></div>
        Right click Ethernet, and set static ip (e.g., 192.168.0.1) and subnet mask (e.g., 255.255.255.0, the same as the above setting); \
        <div align=center><img src="https://user-images.githubusercontent.com/43268820/165896789-7feabff9-ddc1-4609-8c40-7e6037e49e9b.png" width="900"></div>
        5.4.4 Set static ip for VM linux, referring step 4.6, but change the ip as 196.168.0.3; \
        5.4.5 Now three machine, including linux machine, Windows machine and VM machine are located in the same local area network, we can vertify them through "ping": \
        In VM:
        <div align=center><img src="https://user-images.githubusercontent.com/43268820/165898924-16fa25ec-9dd9-43ea-817d-0d4eb0cfe28b.png" width="900"></div>
        In Windows:
        <div align=center><img src="https://user-images.githubusercontent.com/43268820/165899678-5388706e-2fec-430b-b75d-e9458ce94205.png" width="900"></div>
        In linux:
        <div align=center><img src="https://user-images.githubusercontent.com/43268820/165899990-77df93d5-72e8-4fa4-a20a-961f0af8eb05.png" width="900"></div>
  6.
        
        

       





      


