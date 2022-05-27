FROM jenkins/jenkins:lts
USER root
RUN curl -SSL https://get.docker.com/|sh
USER jenkins