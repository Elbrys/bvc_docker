FROM ubuntu:14.04
RUN apt-get update && apt-get install -y wget zip unzip curl openssh-server psmisc
RUN curl -sL https://deb.nodesource.com/setup | bash
RUN apt-get install -y nodejs 
WORKDIR /opt
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u71-b14/server-jre-7u71-linux-x64.tar.gz  && tar xzf server-jre-7u71-linux-x64.tar.gz && rm -rf server-jre-7u71-linux-x64.tar.gz
RUN mkdir bvc
COPY bvc-1.2.0.zip /opt/
RUN unzip -o bvc-1.2.0.zip -d /opt && rm -rf bvc-1.2.0.zip
COPY bvc-dependencies-1.2.0.zip /opt/
RUN unzip -o bvc-dependencies-1.2.0.zip -d /opt && rm -rf bvc-dependencies-1.2.0.zip
WORKDIR /opt/bvc
ENV JAVA_HOME /opt/jdk1.7.0_71/jre
RUN ./install -i
COPY web.zip /opt/bvc/
RUN unzip -o web.zip && rm -rf web.zip 
EXPOSE 162 179 1088 1790 1830 2400 2550 2551 2552 4189 4342 5005 5666 6633 6640 6653 7800 8000 8080 8101 8181 8383 9000 12001
CMD /opt/bvc/bin/start && /opt/bvc/bin/taillog