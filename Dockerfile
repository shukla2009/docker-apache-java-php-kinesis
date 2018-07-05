FROM shukla2009/apache-java-php
MAINTAINER Rahul Shukla <rahul@wootag.com>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y git jq moreutils
RUN cd /tmp && git clone https://github.com/awslabs/amazon-kinesis-agent.git
RUN cd /tmp/amazon-kinesis-agent && ./setup --install

RUN service aws-kinesis-agent start
RUN update-rc.d aws-kinesis-agent defaults
COPY agent.json /etc/aws-kinesis/agent.json
COPY ks /usr/local/bin
RUN chmod +x /usr/local/bin/ks

RUN apt-get -y install python-pip
RUN pip install awscli --upgrade --user
RUN echo "export PATH=/root/.local/bin:$PATH" >> /root/.bashrc

COPY uploadtos3 /etc/cron.daily/
RUN chmod +x /etc/cron.daily/uploadtos3