FROM jenkins/jenkins:lts

USER root
# install Docker client
RUN apt-get update -y && apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg2
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt-get update -y && apt-get install -y docker-ce
RUN apt install ansible -y
RUN usermod -aG docker jenkins
