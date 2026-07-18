FROM ubuntu
RUN apt update && \
apt install -y python3 && \
apt install -y python3-pip && \
apt install -y wget && \
apt autoremove --purge -y python3 python3-pip wget
CMD ["wget", "-O-", "-q", "https://ifconfig.me/ip"]