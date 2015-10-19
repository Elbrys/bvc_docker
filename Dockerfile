FROM ubuntu:14.04
RUN apt-get update && apt-get install -y openjdk-7-jdk python-psycopg2 wget zip unzip curl openssh-server psmisc patch
RUN curl -sL https://deb.nodesource.com/setup | bash
RUN apt-get install -y nodejs 
WORKDIR /opt
RUN groupadd -r bvc && useradd -r -g bvc bvc
RUN mkdir bvc
ADD SDN-Controller-2.1.0-Software.gz /opt/bvc/
RUN chown -R bvc:bvc bvc
USER bvc
WORKDIR /opt/bvc/SDN-Controller-2.1.0-Software
RUN curl https://raw.githubusercontent.com/Elbrys/bsc_openstack/master/bvc2.patch > bvc2.patch 
EXPOSE 162 179 1088 1790 1830 2400 2550 2551 2552 4189 4342 5005 5666 6633 6640 6653 7800 8000 8080 8101 8181 8383 9001 12001
#NOTE! need to run the resulting image with -p 8181:8181 e.g. docker run -p 8181:8181 -P <img_name>
CMD ./installbsc -y && cd / && patch -p0 < /opt/bvc/SDN-Controller-2.1.0-Software/bvc2.patch && cd /opt/bvc/SDN-Controller-2.1.0-Software && /opt/bvc/bin/taillog