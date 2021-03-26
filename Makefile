APP_NAME=gitsync
VERSION=0.1


.PHONY: help


help:
	@echo "Makefile arguments:"
	@echo "build"
	@echo "build-no-caching"
	@echo "run"
	@echo "up : build and run docker instance"
	@echo "stop : stop and remove docker instance"
	@echo "version"


.DEFAULT_GOAL := help


build:
	docker build -t $(APP_NAME):$(VERSION) -t $(APP_NAME):latest .


build-no-caching:
	docker build --no-cache -t $(APP_NAME):$(VERSION) -t $(APP_NAME):latest.


run:
	docker run -it --rm --name="$(APP_NAME)" $(APP_NAME):$(VERSION)


up: build run 


stop: 
	docker stop $(APP_NAME); docker rm $(APP_NAME)


version:
	@echo $(VERSION)
	