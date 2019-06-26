build:
	docker build -t cjs/octodns:v0.9.5 --build-arg VERSION=v0.9.5 .

push:
	docker tag cjs/octodns:v0.9.5 csteinbe/docker-octodns:v0.9.5
	docker push csteinbe/docker-octodns:v0.9.5
