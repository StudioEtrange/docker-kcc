all: image-linux

VERSION=latest

.PHONY: image-linux
image-linux:
	@DOCKER_BUILDKIT=1 docker build . --platform linux/amd64 -t studioetrange/docker-kcc:${VERSION} -t ghcr.io/studioetrange/docker-kcc:${VERSION} 



