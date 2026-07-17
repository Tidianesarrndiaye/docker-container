FROM ubuntu
RUN apt-get update && apt-get install -y python3
RUN apt-get install -y python3-pip
RUN apt-get install -y wget
CMD ["wget", "-O-", "-q", "https://ifconfig.me/ip"]