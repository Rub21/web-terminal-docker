FROM ubuntu:16.04
LABEL maintainer="Rub21"
ENV workdir /usr/src/app
ENV USER ubuntu
ARG PASS
RUN apt-get update
RUN apt-get install -y build-essential git curl vim
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs
RUN git clone https://github.com/krishnasrinivas/wetty.git $workdir && cd $workdir && npm install
WORKDIR $workdir
RUN useradd -d /home/$USER -m -s /bin/bash $USER
RUN echo $USER:$USER | chpasswd
RUN echo $USER:$PASS | chpasswd
# self signed certificate
ADD csr.conf $workdir
RUN openssl req -config csr.conf -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 30000 -nodes
EXPOSE 3000
CMD ["node", "app.js", "--sslkey", "key.pem", "--sslcert" ,"cert.pem", "-p", "3000"]