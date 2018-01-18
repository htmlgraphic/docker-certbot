FROM ubuntu:14.04

MAINTAINER Reprage

ADD crontab /etc/cron.d/certbot-cron
RUN chmod 0644 /etc/cron.d/certbot-cron
RUN touch /var/log/cron.log

RUN apt-get update
RUN apt-get -y install wget \
	cron \
	vim

RUN ls
RUN wget https://dl.eff.org/certbot-auto
RUN chmod a+x certbot-auto
RUN ./certbot-auto --os-packages-only -n

CMD cron && tail -f /var/log/cron.log
