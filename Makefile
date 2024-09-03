PKG_VERSION=1.27.4+mod.1
PKG_REL_PREFIX=1hn1
ifdef NO_CACHE
DOCKER_NO_CACHE=--no-cache
endif
LUAJIT_DEB_VERSION=2.1.20240815-1hn1
MOSECURITY_DEB_VERSION=3.0.12-2hn1

LOGUNLIMITED_BUILDER=logunlimited

# Ubuntu 24.04
deb-ubuntu2404: build-ubuntu2404
	docker run --rm -v ./freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu24.04:/dist freenginx-ubuntu2404 bash -c \
	"cp /src/*${PKG_VERSION}* /dist/"
	docker run --rm -it freenginx-ubuntu2404 /src/run-nginx-tests.sh 2>&1 | sudo tee ./freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu24.04/freenginx-tests-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu24.04.log
	sudo xz --force ./freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu24.04/freenginx-tests-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu24.04.log
	sudo tar zcf freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu24.04.tar.gz ./freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu24.04/

build-ubuntu2404: buildkit-logunlimited
	sudo mkdir -p freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu24.04
	PKG_REL_DISTRIB=ubuntu24.04; \
	(set -x; \
	git config -l | sed -n '/^submodule\.[^.]*\.url/{s|^submodule\.||;s|\.url=|=|;p}' | sort; \
	git submodule status; \
	docker buildx build --progress plain --builder ${LOGUNLIMITED_BUILDER} --load \
		${DOCKER_NO_CACHE} \
		--build-arg OS_TYPE=ubuntu --build-arg OS_VERSION=24.04 \
		--build-arg PKG_REL_DISTRIB=$${PKG_REL_DISTRIB} \
		--build-arg PKG_VERSION=${PKG_VERSION} \
		--build-arg LUAJIT_DEB_VERSION=${LUAJIT_DEB_VERSION} \
		--build-arg LUAJIT_DEB_OS_ID=ubuntu24.04 \
		--build-arg MODSECURITY_DEB_VERSION=${MOSECURITY_DEB_VERSION} \
		--build-arg MODSECURITY_DEB_OS_ID=ubuntu24.04 \
		-t freenginx-ubuntu2404 . \
	) 2>&1 | sudo tee freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu24.04/freenginx_${PKG_VERSION}-${PKG_REL_PREFIX}${PKG_REL_DISTRIB}.build.log && \
	sudo xz --force freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu24.04/freenginx_${PKG_VERSION}-${PKG_REL_PREFIX}${PKG_REL_DISTRIB}.build.log

run-ubuntu2404:
	docker run --rm -it freenginx-ubuntu2404 bash

# Ubuntu 22.04
deb-ubuntu2204: build-ubuntu2204
	docker run --rm -v ./freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu22.04:/dist freenginx-ubuntu2204 bash -c \
	"cp /src/*${PKG_VERSION}* /dist/"
	docker run --rm -it freenginx-ubuntu2204 /src/run-nginx-tests.sh 2>&1 | sudo tee ./freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu22.04/freenginx-tests-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu22.04.log
	sudo xz --force ./freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu22.04/freenginx-tests-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu22.04.log
	sudo tar zcf freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu22.04.tar.gz ./freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu22.04/

build-ubuntu2204: buildkit-logunlimited
	sudo mkdir -p freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu22.04
	PKG_REL_DISTRIB=ubuntu22.04; \
	(set -x; \
	git config -l | sed -n '/^submodule\.[^.]*\.url/{s|^submodule\.||;s|\.url=|=|;p}' | sort; \
	git submodule status; \
	docker buildx build --progress plain --builder ${LOGUNLIMITED_BUILDER} --load \
		${DOCKER_NO_CACHE} \
		--build-arg OS_TYPE=ubuntu --build-arg OS_VERSION=22.04 \
		--build-arg PKG_REL_DISTRIB=$${PKG_REL_DISTRIB} \
		--build-arg PKG_VERSION=${PKG_VERSION} \
		--build-arg LUAJIT_DEB_VERSION=${LUAJIT_DEB_VERSION} \
		--build-arg LUAJIT_DEB_OS_ID=ubuntu22.04 \
		--build-arg MODSECURITY_DEB_VERSION=${MOSECURITY_DEB_VERSION} \
		--build-arg MODSECURITY_DEB_OS_ID=ubuntu22.04 \
		-t freenginx-ubuntu2204 . \
	) 2>&1 | sudo tee freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu22.04/freenginx_${PKG_VERSION}-${PKG_REL_PREFIX}${PKG_REL_DISTRIB}.build.log && \
	sudo xz --force freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu22.04/freenginx_${PKG_VERSION}-${PKG_REL_PREFIX}${PKG_REL_DISTRIB}.build.log

run-ubuntu2204:
	docker run --rm -it freenginx-ubuntu2204 bash

# Debian 12
deb-debian12: build-debian12
	docker run --rm -v ./freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}debian12:/dist freenginx-debian12 bash -c \
	"cp /src/*${PKG_VERSION}* /dist/"
	docker run --rm -it freenginx-debian12 /src/run-nginx-tests.sh 2>&1 | sudo tee ./freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}debian12/freenginx-tests-${PKG_VERSION}-${PKG_REL_PREFIX}debian12.log
	sudo xz --force ./freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}debian12/freenginx-tests-${PKG_VERSION}-${PKG_REL_PREFIX}debian12.log
	sudo tar zcf freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}debian12.tar.gz ./freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}debian12/

build-debian12: buildkit-logunlimited
	sudo mkdir -p freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}debian12
	PKG_REL_DISTRIB=debian12; \
	(set -x; \
	git config -l | sed -n '/^submodule\.[^.]*\.url/{s|^submodule\.||;s|\.url=|=|;p}' | sort; \
	git submodule status; \
	docker buildx build --progress plain --builder ${LOGUNLIMITED_BUILDER} --load \
		${DOCKER_NO_CACHE} \
		--build-arg OS_TYPE=debian --build-arg OS_VERSION=12 \
		--build-arg PKG_REL_DISTRIB=$${PKG_REL_DISTRIB} \
		--build-arg PKG_VERSION=${PKG_VERSION} \
		--build-arg LUAJIT_DEB_VERSION=${LUAJIT_DEB_VERSION} \
		--build-arg LUAJIT_DEB_OS_ID=debian12 \
		--build-arg MODSECURITY_DEB_VERSION=${MOSECURITY_DEB_VERSION} \
		--build-arg MODSECURITY_DEB_OS_ID=debian12 \
		-t freenginx-debian12 . \
	) 2>&1 | sudo tee freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}debian12/freenginx_${PKG_VERSION}-${PKG_REL_PREFIX}${PKG_REL_DISTRIB}.build.log && \
	sudo xz --force freenginx-${PKG_VERSION}-${PKG_REL_PREFIX}debian12/freenginx_${PKG_VERSION}-${PKG_REL_PREFIX}${PKG_REL_DISTRIB}.build.log

run-debian12:
	docker run --rm -it freenginx-debian12 bash

buildkit-logunlimited:
	if ! docker buildx inspect logunlimited 2>/dev/null; then \
		docker buildx create --bootstrap --name ${LOGUNLIMITED_BUILDER} \
			--driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=-1 \
			--driver-opt env.BUILDKIT_STEP_LOG_MAX_SPEED=-1; \
	fi

exec:
	docker exec -it $$(docker ps -q) bash

.PHONY: deb-debian12 run-debian12 build-debian12 deb-ubuntu2204 run-ubuntu2204 build-ubuntu2204 buildkit-logunlimited exec
