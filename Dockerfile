FROM ubuntu:14.04
MAINTAINER engineerball "ball@engineerball.com"

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential git python2.7 python-pip python-dev libevent-dev libzmq-dev python-virtualenv
RUN apt-get clean
RUN pip install locustio pyzmq
ADD ./scenario /opt/scenario
ENV SCENARIO_FILE /opt/scenario/locustfile.py
RUN pip install -r /opt/scenario/requirements.txt

ADD run.sh /usr/local/bin/run.sh
ADD export.sh /usr/local/bin/export.sh
RUN chmod 755 /usr/local/bin/run.sh
RUN chmod 755 /usr/local/bin/export.sh

EXPOSE 8089 5557 5558
WORKDIR /opt/scenario
CMD ["source /usr/local/bin/export.sh"]
CMD ["/usr/local/bin/run.sh"]
