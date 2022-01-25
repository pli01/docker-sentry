SHELL = /bin/bash

SENTRY_EMAIL ?= user@example.org
SENTRY_PASSWORD ?= _TODEFINED_

bootstrap: up-mailhog up-redis up-postgres sentry-key sentry-upgrade sentry-createuser up-sentry up-cron up-worker
	echo "$@ done"

up-all:
	docker-compose up -d

up-%:
	docker-compose up -d $*

down-%: stop-% rm-%
	echo "$@ done"

stop-%:
	docker-compose stop $*
rm-%:
	docker-compose rm -f $*

clean-all: down-all
	echo "$@ done"

down-all:
	docker-compose down

rm-all:
	docker-compose rm -f

sentry-key:
	[ -f .env ] && grep -q "^SENTRY_SECRET_KEY=" .env || (SENTRY_SECRET_KEY="$$(docker-compose run  -T --rm sentry config generate-secret-key)" ; \
	echo "SENTRY_SECRET_KEY=\"$$SENTRY_SECRET_KEY\"" > .env ; )

sentry-upgrade:
	( echo "n" | docker-compose run -T --rm sentry upgrade ) || true
sentry-createuser:
	@[ -z "${SENTRY_EMAIL}" -o -z "${SENTRY_PASSWORD}" ] || docker-compose run -T --rm sentry createuser --email ${SENTRY_EMAIL} --password ${SENTRY_PASSWORD} --superuser --no-input
