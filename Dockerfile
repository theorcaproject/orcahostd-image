FROM ubuntu:latest
RUN apt-get update -y && apt-get install -y supervisor git gcc g++
RUN apt-get install -y wget
WORKDIR /app

# Clone and configure the orca-web interface
COPY supervisorctl-app.conf /etc/supervisor/conf.d/

# Clone and build the orca trainer
RUN wget https://storage.googleapis.com/golang/go1.10.1.linux-amd64.tar.gz
RUN tar -xvf go1.10.1.linux-amd64.tar.gz
RUN mv go /usr/local
RUN export GOROOT=/usr/local/go

ENV GOROOT=/usr/local/go
ENV GOPATH=/app/build
ENV PATH=$GOPATH/bin:$GOROOT/bin:$PATH
RUN mkdir /app/build && mkdir /app/build/src

RUN cd /app/build/src && git clone -b v4 https://github.com/theorcaproject/orcahostd.git
RUN go get orcahostd
RUN go build orcahostd 
RUN go install orcahostd 

CMD ["supervisord", "-n"]

