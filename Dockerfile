FROM ubuntu:16.04
ENV workdir /usr/src/app
ARG USER
ARG PASS
RUN apt-get update
RUN apt-get install -y build-essential git curl vim
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs
RUN git clone https://github.com/krishnasrinivas/wetty.git $workdir && cd $workdir && npm install
WORKDIR $workdir
RUN useradd -d /home/term -m -s /bin/bash term
ADD csr.conf $workdir
RUN echo 'term:$USER' | chpasswd
RUN echo 'term:$PASS' | chpasswd
# self signed certificate
RUN openssl req -config csr.conf -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 30000 -nodes
EXPOSE 3000
CMD ["node", "app.js", "--sslkey", "key.pem", "--sslcert" ,"cert.pem", "-p", "3000"]