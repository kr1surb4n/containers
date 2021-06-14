FROM jenkins/jenkins:slim

USER root

RUN apt-get update && apt-get upgrade && apt-get -y install build-essential git \
	python python3 python-pip python3-pip

# fix the access to 
RUN groupadd docker;groupmod -g 999 docker; usermod -aG docker jenkins

USER jenkins

WORKDIR /home/jenkins

# the .ssh keys can be in /var/lib/jenkins/.ssh
# RUN mkdir .ssh; ssh-keygen -t rsa; cat .ssh/id_rsa.pub; 

RUN pip3 install virtualenv


