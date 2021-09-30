FROM openjdk:8-jdk

ARG MAVEN_VERSION=3.3.9
ARG USER_HOME_DIR="/var/jenkins-agent"

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

RUN apt-get update && apt-get install -y git curl ssh && rm -rf /var/lib/apt/lists/*

# Set user jenkins to the image
RUN useradd -m -d /var/jenkins-agent -s /bin/sh jenkins &&\
    echo "jenkins:jenkins" | chpasswd

# SSH stuff
RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd

# Maven
RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# Maven / Docker stuff...
ADD settings.xml $USER_HOME_DIR/.m2/
RUN chown -R jenkins:jenkins $USER_HOME_DIR

# DEMO not export volume
#VOLUME "$USER_HOME_DIR/.m2

# Standard SSH port
EXPOSE 22

# Default command
CMD ["/usr/sbin/sshd", "-D"]
