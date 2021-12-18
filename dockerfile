from ubuntu:latest
LABEL maintainer="Raiyan Yahya <raiyanyahyadeveloper@gmail.com>"
ENV DEBIAN_FRONTEND noninteractive
#Update system
RUN apt-get update

# Installing build dependencies
RUN apt-get install -y build-essential automake make cmake g++ wget git python3-pip curl zsh wget nano nodejs npm fonts-powerline


# Prepare environment UTF-8
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

#Add a dev user and make zsh default
RUN adduser --quiet --disabled-password --shell /bin/zsh --home /home/devuser --gecos "User" devuser && \
    echo "devuser:<a href="mailto://p@ssword123">p@ssword123</a>" | chpasswd &&  usermod -aG sudo devuser

RUN rm -rf /var/lib/apt/lists/*
USER devuser
ENV TERM xterm
WORKDIR /home/devuser
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
CMD ["zsh"]

#docker run --rm -it -v ${PWD}:/home/devuser/ imageid
