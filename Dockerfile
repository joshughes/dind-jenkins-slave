# Docker-in-Docker Jenkins Slave
#
# See: https://github.com/tehranian/dind-jenkins-slave
# See: https://dantehranian.wordpress.com/2014/10/25/building-docker-images-within-docker-containers-via-jenkins/
#
# Following the best practices outlined in:
#   http://jonathan.bergknoff.com/journal/building-good-docker-images

FROM docker:1.9.1

RUN apk update && apk add openssh make openjdk7-jre git
RUN mkdir -p /var/run/sshd &&\
    adduser -s /bin/ash -D jenkins &&\
    echo "jenkins:jenkins" | chpasswd &&\
    ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa &&\
    ln -s /usr/local/bin/docker /usr/bin/docker

EXPOSE 22

COPY jenkins-slave-startup.sh /

ENTRYPOINT ["/jenkins-slave-startup.sh"]
