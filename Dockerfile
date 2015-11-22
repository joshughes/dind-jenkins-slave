# Docker-in-Docker Jenkins Slave
#
# See: https://github.com/tehranian/dind-jenkins-slave
# See: https://dantehranian.wordpress.com/2014/10/25/building-docker-images-within-docker-containers-via-jenkins/
#
# Following the best practices outlined in:
#   http://jonathan.bergknoff.com/journal/building-good-docker-images

FROM docker:1.9.1-dind

RUN apk update && apk add openssh openjdk7-jre
RUN mkdir -p /var/run/sshd &&\
    adduser -s /bin/ash -D jenkins &&\
    echo "jenkins:jenkins" | chpasswd &&\
    ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa &&\
    echo "export DOCKER_HOST=tcp://localhost:2375" >> /etc/profile

EXPOSE 22

COPY jenkins-slave-startup.sh /

CMD ["/jenkins-slave-startup.sh"]
