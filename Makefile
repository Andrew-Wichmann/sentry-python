REPOSITORY?=sentry-onpremise
TAG?=latest

OK_COLOR=\033[32;01m
NO_COLOR=\033[0m

build:
	@echo "$(OK_COLOR)==>$(NO_COLOR) Building $(REPOSITORY):$(TAG)"
	@docker build --rm -t $(REPOSITORY):$(TAG) .
	@docker volume create sentry-data
	@docker volume create sentry-postgres
	@docker network create onpremise_default
	@PIPENV_VENV_IN_PROJECT=1 pipenv install
	@PIPENV_VENV_IN_PROJECT=1 pipenv run docker-compose run web upgrade

$(REPOSITORY)_$(TAG).tar: build
	@echo "$(OK_COLOR)==>$(NO_COLOR) Saving $(REPOSITORY):$(TAG) > $@"
	@docker save $(REPOSITORY):$(TAG) > $@

push: build
	@echo "$(OK_COLOR)==>$(NO_COLOR) Pushing $(REPOSITORY):$(TAG)"
	@docker push $(REPOSITORY):$(TAG)

up: build
	@PIPENV_VENV_IN_PROJECT=1 pipenv run docker-compose up

all: build push

.PHONY: all build push
