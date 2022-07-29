FROM ubuntu:latest
USER root
# install openssh-server openjdk8
RUN apt-get update -y && apt-get install -y openjdk-8-jdk openssh-server
RUN useradd -m -s /bin/bash jenkins
COPY jenkins.pub /home/jenkins/.ssh/authorized_keys
RUN chown -R jenkins:jenkins /home/jenkins/.ssh 
RUN chmod 700 /home/jenkins/.ssh 
RUN chmod 644 /home/jenkins/.ssh/authorized_keys

USER jenkins
RUN mkdir /home/jenkins/jenkins_home
WORKDIR /home/jenkins/jenkins_home
# RUN chmod 644 /home/jenkins/.ssh/authorized_keys
USER root

ENTRYPOINT service ssh restart && bash

