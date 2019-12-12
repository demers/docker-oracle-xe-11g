FROM wnameless/oracle-xe-11g-r2
# Voir https://github.com/wnameless/docker-oracle-xe-11g
#
MAINTAINER FND <fndemers@gmail.com>

ENV PROJECTNAME=ORACLE

ENV TERM=xterm\
    TZ=America/Toronto\
    DEBIAN_FRONTEND=noninteractive

# Access SSH login
ENV USERNAME=ubuntu
ENV PASSWORD=ubuntu

ENV WORKDIRECTORY=/home/ubuntu

RUN apt-get update

RUN apt install -y apt-utils

RUN apt-get install -y vim-nox curl git

# Install a basic SSH server
RUN apt install -y openssh-server
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd
RUN /usr/bin/ssh-keygen -A

# Add user to the image
RUN adduser --quiet --disabled-password --shell /bin/bash --home /home/${USERNAME} --gecos "User" ${USERNAME}
# Set password for the jenkins user (you may want to alter this).
RUN echo "$USERNAME:$PASSWORD" | chpasswd

RUN apt-get clean && apt-get -y update && apt-get install -y locales && locale-gen fr_CA.UTF-8
ENV TZ=America/Toronto
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#RUN /usr/bin/timedatectl set-timezone $TZ
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/$TZ /etc/localtime

RUN apt install -y fish

RUN echo "export PS1=\"\\e[0;31m $PROJECTNAME\\e[m \$PS1\"" >> ${WORKDIRECTORY}/.bash_profile

# Ajout des droits sudoers
RUN apt-get install -y sudo
RUN echo "%ubuntu ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN echo "export DISPLAY=:0.0" >> ${WORKDIRECTORY}/.bash_profile
RUN echo "export DISPLAY=:0.0" >> /root/.bash_profile

RUN echo "export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe" >> ${WORKDIRECTORY}/.bash_profile

RUN echo "export PATH=\$ORACLE_HOME/bin:$PATH" >> ${WORKDIRECTORY}/.bash_profile

RUN echo "export ORACLE_SID=XE" >> ${WORKDIRECTORY}/.bash_profile

RUN echo "sleep 1; echo 'alter system disable restricted session;' | /u01/app/oracle/product/11.2.0/xe/bin/sqlplus -s SYSTEM/oracle" >> ${WORKDIRECTORY}/.bash_profile

RUN apt-get install -y rlwrap

RUN echo "alias sqlplus='rlwrap sqlplus'" >> ${WORKDIRECTORY}/.bash_profile
RUN echo "alias sp='rlwrap sqlplus SYSTEM/oracle'" >> ${WORKDIRECTORY}/.bash_profile

# Installation X11.
RUN apt install -y xauth vim-gtk
#RUN apt install -y xorg

RUN apt-get update
RUN apt-get install -y build-essential cmake python3-dev

RUN apt install -y software-properties-common apt-transport-https wget

EXPOSE 22
EXPOSE 1521
EXPOSE 8080

# Installation Java 13
# http://ubuntuhandbook.org/index.php/2019/10/how-to-install-oracle-java-13-in-ubuntu-18-04-16-04-19-04/
RUN add-apt-repository ppa:linuxuprising/java
RUN apt-get update


#RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 \
    #select true | /usr/bin/debconf-set-selections
RUN echo oracle-java13-installer shared/accepted-oracle-license-v1-2 \
    select true | sudo /usr/bin/debconf-set-selections

# Alternatives... pris de https://www.linuxuprising.com/2019/09/install-oracle-java-13-on-ubuntu-linux.html
#RUN echo oracle-java13-installer shared/accepted-oracle-licence-v1-2 boolean true | sudo /usr/bin/debconf-set-selections
RUN apt install -y oracle-java13-installer
RUN apt install -y oracle-java13-set-default

# Installation du pilote Java Oracle
# https://www.codejava.net/java-se/jdbc/connect-to-oracle-database-via-jdbc
ADD o.j /
RUN mv -f /o.j /ojdbc6.jar
RUN mkdir /home/ubuntu/classpath
RUN mv -f /ojdbc6.jar /home/ubuntu/classpath/
RUN chown -R ubuntu:ubuntu /home/ubuntu/classpath

ADD JdbcOracleConnection.java /home/ubuntu/
RUN chown -R ubuntu:ubuntu /home/ubuntu/JdbcOracleConnection.java

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-13-oracle/bin" >> ${WORKDIRECTORY}/.bash_profile
RUN echo "export CLASSPATH=.:/usr/lib/jvm/java-13-oracle/lib:/home/ubuntu/classpath" >> ${WORKDIRECTORY}/.bash_profile

#JAVA_HOME="/usr/lib/jvm/java-13-oracle/bin"
#export JAVA_HOME
#CLASSPATH=".:/usr/lib/jvm/java-13-oracle/lib:/home/ubuntu/classpath"

ADD start.sh /
RUN chmod +x /start.sh

CMD ["/start.sh"]
