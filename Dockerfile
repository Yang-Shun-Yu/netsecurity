FROM debian:latest

RUN apt update && apt install -y --fix-missing \
    git \
    build-essential \
    wget \
    python3 \
	netcat-openbsd \
    libssl-dev \
    lsof

WORKDIR /exploit


COPY tgsocksproxy.py proxy.py

COPY server.py server.py

COPY start.sh start.sh

WORKDIR /build

RUN wget https://github.com/curl/curl/releases/download/curl-7_81_0/curl-7.81.0.tar.gz

RUN tar -xzvf curl-7.81.0.tar.gz

WORKDIR /build/curl-7.81.0

RUN ./configure --with-openssl

RUN make -j$(nproc)

RUN make install

RUN cp -r /usr/local/lib /usr/lib

RUN ldconfig

WORKDIR /
# Make sure the script is executable
RUN chmod +x /exploit/start.sh

ENTRYPOINT [ "/exploit/start.sh"]

