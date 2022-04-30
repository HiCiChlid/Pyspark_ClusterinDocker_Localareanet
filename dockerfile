FROM ubuntu:18.04

#user
#USER root

#encoding
ENV LANG=C.UTF-8
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# change to Mainland apt update source
#RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
#    && apt-get clean \
#    && apt-get update

# install some tools
RUN apt-get -y update \
    && apt-get install -y --no-install-recommends apt-utils \
    && apt-get remove -y vim-common \
    && apt-get install -y vim \
    && apt-get install -y git \
    && apt-get install -y wget \
    && apt-get install -y libssl-dev \
    && apt-get install -y net-tools \
    && apt-get install -y iputils-ping \
    && apt-get install -y libcurl4-openssl-dev

# install JAVA
RUN apt-get install -y openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JRE_HOME $JAVA_HOME/jre
ENV CLASSPATH $CLASSPATH:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH

# install spark
WORKDIR /usr/local
RUN wget "http://archive.apache.org/dist/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz" \
    && tar -vxf spark-* \
    && mv spark-2.4.5-bin-hadoop2.7 spark \
    && rm -rf spark-2.4.5-bin-hadoop2.7.tgz
ENV SPARK_HOME /usr/local/spark
EXPOSE 6066 8080 7077 4044 18080 8888
ENV PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin:$SPARK_HOME/bin$PATH

# install python3
RUN apt install -y python3.6 \
&& apt install -y ipython3 \
&& apt install -y python3-pip \
&& ln -sf /usr/bin/python3.6 /usr/bin/python \
&& ln -sf /usr/bin/pip3 /usr/bin/pip

RUN pip3 install --upgrade pip \
&& pip3 install jupyter==1.0.0 \ 
&& pip3 install findspark==1.4.2 \ 
&& pip3 install supervisor \
&& pip3 install pyspark==3.0.1

# install ssh server about the remote operation
RUN apt-get install -y openssh-server \
    && mkdir -p /var/run/sshd \
    && mkdir -p /var/log/supervisor \
    && echo "root:abc123" | chpasswd
# allow rootssh login
RUN sed -i "s/#PermitRootLogin no/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
# create supervisord.conf
RUN echo '[supervisord]\n\
nodaemon=true\n\
[program:sshd]\n\
command=/usr/sbin/sshd -D\n'\
>>/etc/supervisord.conf
# container needs to open SSH 22 port for visiting from outsides.
EXPOSE 22
# start supervisord service
CMD ["/usr/bin/supervisord"]

# set default homepath
WORKDIR /home

# create jupyter shortcuts
RUN touch jp.sh \
&& echo jupyter notebook --ip=0.0.0.0 --no-browser --allow-root > jp.sh

CMD /bin/bash
