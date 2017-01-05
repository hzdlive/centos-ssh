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

RUN yum clean all

EXPOSE 22
CMD /usr/sbin/sshd -D
