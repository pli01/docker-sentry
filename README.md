# docker-sentry

Docker sentry stack for dev purpose only

install instruction from `https://hub.docker.com/_/sentry/`

Contains a docker-compose stack with following
- mailhog local smtp (web ui on 0.0.0.0:8025)
- redis
- postgres
- sentry (web ui on 0.0.0.0:9000)
- sentry-cron
- sentry-worker


## Usage

The first time, To initialize the stack, with default SENTRY_EMAIL / SENTRY_PASSWORD admin account
```
# please wait , the bootstrap step take time
make bootstrap SENTRY_EMAIL="mytest@example.org" SENTRY_PASSWORD="_TODEFINED_"
```

After bootstrap steps, you can:
- connect to sentry : http://localhost:9000
- connect to local mailhog (SMTP webmail): http://localhost:8025

After bootstrap steps, you can down/up the stack, a volume is defined for postgresl data persistence
```
# stop on service
make down-cron
# stop all services
make down-all
# or
make up-all
```
