FROM fedora:latest

RUN dnf install perl public-inbox git public-inbox-server perl-Plack-Middleware-ReverseProxy  -y

WORKDIR /home/app

RUN git clone --mirror https://gnusha.org/pi/bitcoindev /home/app/bitcoindev

RUN public-inbox-init -V1 bitcoindev /home/app/bitcoindev https://gnusha.org/pi/bitcoindev bitcoindev@googlegroups.com

RUN public-inbox-index /home/app/bitcoindev

WORKDIR /home/app/bitcoindev

RUN public-inbox-fetch .

WORKDIR /home/app

RUN public-inbox-index /home/app/bitcoindev

COPY . /home/app/bitcoindev/

EXPOSE 8080

CMD [ "public-inbox-httpd"]