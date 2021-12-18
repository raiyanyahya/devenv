from ubuntu:latest
LABEL maintainer="Raiyan Yahya <raiyanyahyadeveloper@gmail.com>"

#install and setup golang
COPY --from=golang /usr/local/go/ /usr/local/go/  
ENV PATH="/usr/local/go/bin:${PATH}" 

#need this to generate the locale
ENV DEBIAN_FRONTEND noninteractive

#Update system
RUN apt-get update

# Installing build dependencies
RUN apt-get install -y build-essential automake make cmake sudo g++ wget git python3-pip curl zsh wget nano nodejs npm fonts-powerline lsof


# Prepare environment UTF-8
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

#Add a dev user and make zsh default
RUN adduser --quiet --disabled-password --shell /bin/zsh --home /home/devuser --gecos "User" devuser && \
    echo "devuser:<a href="mailto://password123">password123</a>" | chpasswd &&  usermod -aG sudo devuser

#Install and setup Gitpod's vscode server
RUN wget https://github.com/gitpod-io/openvscode-server/releases/download/openvscode-server-v1.63.0/openvscode-server-v1.63.0-linux-x64.tar.gz
RUN tar -xzf openvscode-server-v1.63.0-linux-x64.tar.gz
RUN chmod +x openvscode-server-v1.63.0-linux-x64/server.sh

RUN rm -rf /var/lib/apt/lists/* && \
	apt-get clean && \
	apt-get autoclean && \
	apt-get autoremove
USER devuser
ENV TERM xterm
WORKDIR /home/devuser
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

#Setup alias commands for starting and stopping a vscode server
RUN echo 'alias upcode="nohup /openvscode-server-v1.63.0-linux-x64/server.sh --connection-token password123 & "' >> .zshrc
RUN echo 'alias downcode="kill -9 \$(lsof -t -i:3000) "' >> .zshrc

CMD ["zsh"]

#docker run --rm -it -p 3000:3000 -v ${PWD}:/home/devuser/ imageid
#http://localhost:3000/?tkn=password123
