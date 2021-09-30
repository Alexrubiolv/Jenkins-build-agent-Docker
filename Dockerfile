FROM foxylion/jenkins-ssh-slave
MAINTAINER James Tanner "james.tanner@tanndev.com"

# Install Node.JS
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs

# Add global NPM packages
RUN npm i -g semantic-release semantic-release-docker

# Provide SSH config
#COPY ssh-config /root/.ssh/config
#RUN ssh-keyscan -t rsa docker.tanndev.com > ~/.ssh/known_hosts

# Install Kubectl
RUN KUBECTL_VERSION=`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt` \
    && curl -s -LO https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl
