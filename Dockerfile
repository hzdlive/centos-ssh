# sshd
#
# VERSION               0.0.1

FROM centos:6.8

RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y openssh-server openssh-clients python-setuptools && \
    yum install -y git wget && \
#    yum clean all && \
    easy_install supervisor && \
    mkdir /var/run/sshd

RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN service sshd start

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN git clone -b manyuser https://github.com/breakwa11/shadowsocks.git
RUN git clone https://github.com/snooda/net-speeder.git
RUN wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN wget https://github.com/xtaci/kcptun/releases/download/v20161222/kcptun-linux-amd64-20161222.tar.gz
#RUN rpm -ivh epel-release-6-8.noarch.rpm
RUN yum install -y libnet libpcap libnet-devel libpcap-devel gcc

RUN yum clean all

EXPOSE 22
CMD /usr/sbin/sshd -D
