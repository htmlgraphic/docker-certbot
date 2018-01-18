## Docker Cloud Certificate Node - Certbot / LetsEncrypt


Create and automatically renew website SSL certificates using the Let's Encrypt a free certificate authority. This container will renew your certificates, and place the lastest certificates in a folder as you need.

## How is this different?

In general you want to have an SSL Certificate created for a online web service, many cases this will require a publicly hosted container. Docker might be managed via an orchestration tool like Docker Cloud, (formly Tutum) or any of the others growing container services. This solution will allow you to spin up a container connect to your web service via a shared volume and manage the ongoing certificate renewal providing you with ease of use and peace of mind.



### Docker / Docker Cloud

Now the new certbot container needs to be hooked into the rest of your infrastructure. This can be done with compose, or directly with the docker command:

```
./certbot-auto certonly --config-dir /data/certs --agree-tos --renew-by-default --no-eff-email --email email@domain.com --webroot -w /data/www/public_html -d domain1.com -d www.domain1.com

```

In the above example certbot is expecting the ablilty to modify your webroot directly, certbot will need public access to verify the DNS is correctly pointing to the same host a valid SSL certificate will be generated on. It writes a little proof to the web directory.

# Usage

## Setup

Use this repo Dockerfile to create your own container or use the prebuilt container [htmlgraphic/certbot](https://hub.docker.com/r/htmlgraphic/certbot/) In this example, [docker-cloud cli](https://docs.docker.com/docker-cloud/installing-cli/) is used:

```
$ docker-cloud service run --volumes-from container-name htmlgraphic/certbot:latest
```



### crontab

The schedule for the cron job follows the recommendations from Let’s Encrypt; a random minute within the hour, twice a day. The renewal process doesn’t do anything if the SSL certificates haven’t expired. Yet, checking twice a day helps you stay online in case Let’s Encrypt needs to revoke your existing certificate for some reason.

The cron tab looks like this:
```
6,18 * * * sleep $(expr $RANDOM % 55)m; /./certbot-auto renew --config-dir /data/certs --quiet --no-self-upgrade
```

# More information

Helpful configuration settings: https://certbot.eff.org/docs/using.html

Contribution: https://reprage.com/post/SSL-with-letsencrypt-nginx-and-docker
